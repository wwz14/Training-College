package edu.nju.trainCollege.service.impl;

import edu.nju.trainCollege.dao.*;
import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.CollegeService;
import edu.nju.trainCollege.tools.LevelDiscount;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class CollegeServceImpl implements CollegeService{
    @Autowired
    private StudentDao studentDao;
    @Autowired
    private LessonDao lessonDao;
    @Autowired
    private CollegeDao collegeDao;
    @Autowired
    private ClassesDao classesDao;
    @Autowired
    private LessonProDao lessonProDao;
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private BankDao bankDao;

    private static final String ID_FORMATTER = "%07d";

    public College login(String id, String password) {
        if(id.length()<7)
            return null;
        try{
            int cid = Integer.parseInt(id);
            return collegeDao.getByIdPwd(cid,password);
        }catch (Exception ex){
            return null;
        }
    }

    public String register(College college) {
        try{
            int id = collegeDao.save(college);
            if(id==0)
                return "";
            return String.format(ID_FORMATTER,id);
        }catch (Exception e){
            e.printStackTrace();
            return "";
        }

    }

    public int createLessonClass(Lesson lesson, List<Classes> classes) {
        int lid = lessonDao.save(lesson);
        if(lid==0)
            return 0;
        else{
            for(Classes c:classes){
                c.setLid(lid);
                classesDao.save(c);
            }
        }
        return lid;
    }

    public void enrollLesson(Orders order, LessonProgress lp) throws ServiceException {
        if(lp==null)
            throw new ServiceException("报名人数至少一人");
        order.setOrderTime(new Date());
        order.setState(1);

        Classes classes = classesDao.get(lp.getClassId());
        if(order.getUid()==0){
            lp.setPayment(new Double(classes.getPrice()).intValue());
        }else{
            int expr = studentDao.get(order.getUid()).getExpr();
            double discount = LevelDiscount.getDiscount(expr);
            lp.setPayment(new Double(classes.getPrice()*discount).intValue());
        }

        int studentNum = lessonProDao.getByClassIdNo(lp.getClassId(),-1).size();
        if(studentNum>=classes.getNum()*classes.getSize()){
            throw new ServiceException(classes.getName()+" 报名人数已达上限，请重新选班");
        }else{
            int classNo = studentNum / classes.getSize()+1;
            lp.setClassNo(classNo);
        }
        order.setTotalPay(lp.getPayment());

//        保存order，获得它的ID
        lp.setOid(orderDao.save(order));
        lp.setState(1);
        lessonProDao.save(lp);

        if(order.getUid()!=0){
            Student student = studentDao.get(order.getUid());
            student.setExpr(student.getExpr()+order.getTotalPay()/100);
            studentDao.saveOrUpdate(student);
        }
    }

    public void newAttendance(List<Attendance> attds) {
        for(Attendance attd:attds){
            lessonProDao.saveAttendance(attd);
        }
    }

    public boolean checkCard(String cardNo, String pwd) {
        return bankDao.findByCardIDPwd(cardNo,pwd)!=null;
    }

    public void autoArrangeClass(){
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_YEAR,2);
        Date start = calendar.getTime();
        calendar.add(Calendar.DATE,2);
        Date end = calendar.getTime();
        List<Lesson> lessons = lessonDao.getBetweenDays(start,end);

        for(Lesson l:lessons){
            arrangeClass(l.getId());
        }
    }

    public boolean arrangeClass(int lid) {
        Lesson lesson = lessonDao.get(lid);
        if(lesson==null)
            return false;

        List<Classes> classes = classesDao.getByLidOrder(lid,"price DESC");
        int cheapCid = classes.get(classes.size()-1).getId();
        Object[] oids = orderDao.getOidByLid(lid).toArray();

        for(Classes c:classes){
            List<LessonProgress> progresses = lessonProDao.getByOidClassIdOrder(oids,c.getId(),null);

            if(progresses==null)
                continue;

            int vacant;
//            如果是高价班，补满已有班号就行，低价班，补满所有班号
            if(cheapCid==c.getId()){
                vacant = c.getNum()*c.getSize()-progresses.size();
            }else{
                vacant = (c.getNum()*c.getSize()-progresses.size())%c.getSize();
            }

            int already = progresses.size();
            if(vacant>0){
                progresses = lessonProDao.getByOidClassIdOrder(oids,0,null);
                if(vacant>=progresses.size()){
                    for(int i = 0;i<progresses.size();i++){
                        LessonProgress lp = progresses.get(i);
                        lp.setClassId(c.getId());
                        lp.setClassNo((already+i)/c.getSize()+1);
                        lessonProDao.saveOrUpdate(lp);
                    }
                    return true;
                }else{
                    for(int i = 0;i<vacant;i++){
                        LessonProgress lp = progresses.get(i);
                        lp.setClassId(c.getId());
                        lp.setClassNo((already+i)/c.getSize()+1);
                        lessonProDao.saveOrUpdate(lp);
                    }
                }
            }
        }

//        剩余人员退款
        List<LessonProgress> progresses = lessonProDao.getByOidClassIdOrder(oids,0,null);
        for(LessonProgress lp:progresses){
            lp.setState(2);
            lessonProDao.saveOrUpdate(lp);
            PayRecord record = bankDao.findByOrderId(lp.getOid());
            record.setId(0);
            record.setType(1);
            record.setPayment(lp.getPayment());
            bankDao.save(record);
            bankDao.saveCard("00000000",-record.getPayment());
            bankDao.saveCard(record.getBankCardID(),record.getPayment());
        }
        return true;
    }

    public void saveCollege(College college) {
        collegeDao.saveOrUpdate(college);
    }

    public List<LessonProgress> getNoclassLpByLid(int lid) {
        Object[] oids = orderDao.getOidByLid(lid).toArray();
        return lessonProDao.getByOidClassIdOrder(oids,0,null);
    }

    public List<Orders> getOrderByCidState(int cid, int state) {
        return orderDao.getByStateCid(cid,state);
    }

    public Student getStudentById(int uid) {
        return studentDao.get(uid);
    }

    public int[] getPaymentByYear(int cid, int year) {
        //前12个为用户付费每月数额，后12个为用户退款每月数额
        int[] result = new int[24];
        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.set(year,0,1);
        Date start = calendar.getTime();
        calendar.set(year+1,0,1);
        Date end = calendar.getTime();


        List<PayRecord> payRecords = bankDao.findBetweenDays(start,end);
        for(PayRecord record : payRecords){
            if(record.getCid()==cid){
                if(record.getType()==0){
//               用户付费
                    calendar.setTime(record.getPaytime());
                    result[calendar.get(Calendar.MONTH)]+=record.getPayment();//月份从0开始
                }else if(record.getType()==1){
                    calendar.setTime(record.getPaytime());
                    result[calendar.get(Calendar.MONTH)+12]+=record.getPayment();//月份从0开始
                }
            }
        }
        return result;
    }

    public int[] getHomepageData(int cid) {
        int[] result = {0,0,0,0};

        result[0] = lessonDao.getByCollegeId(cid).size();
        result[1] = orderDao.getByStateCid(cid,-1).size();

        result[2] = lessonProDao.getByCollegeId(cid).size();
        result[3] = bankDao.findByCollegeid(cid).size();
        return result;
    }

    public List<PayRecord> getPayRecordByCollegeid(int cid) {
        return bankDao.findByCollegeid(cid);
    }

    public List<Attendance> getAttendanceByLpidType(int lpid, int type) {
        return lessonProDao.getAttdByLessonProIdType(lpid,type);
    }

    public List<LessonProgress> getLessonProByClassIdNo(int classId, int classNo) {
        return lessonProDao.getByClassIdNo(classId,classNo);
    }

    public List<Lesson> getLessonByStateCid(int cid, int state) {
        List<Lesson> result =lessonDao.getByLessonStateCid(cid,state);
        if(result==null){
            return new ArrayList<Lesson>(0);
        }else
            return result;
    }

    public void saveLesson(Lesson lesson) {
        if(lesson.getId()<1){
            return;
        }
        lessonDao.saveOrUpdate(lesson);
    }

    public void saveClass(Classes c) {
        if(c.getLid()<1){
            return;
        }
        classesDao.saveOrUpdate(c);
    }

    public void deleteClass(int cid) {
        classesDao.delete(cid);
    }

    public Lesson getLessonByLid(int lid) {
        return lessonDao.get(lid);
    }

    public Classes getClassesById(int id) {
        return classesDao.get(id);
    }

    public College getCollegeById(int cid) {
        return collegeDao.get(cid);
    }

    public List<Classes> getClassesByLid(int lid) {
        return classesDao.getByLessonId(lid);
    }
}
