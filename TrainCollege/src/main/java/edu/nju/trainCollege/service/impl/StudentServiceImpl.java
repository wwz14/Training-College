package edu.nju.trainCollege.service.impl;

import edu.nju.trainCollege.dao.*;
import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.StudentService;
import edu.nju.trainCollege.tools.LevelDiscount;
//import edu.nju.trainCollege.tools.SendEmail;
import edu.nju.trainCollege.tools.SendEmail;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {
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

    public Student login(String email, String password) {
        return studentDao.getByEmailPwd(email,password);
    }

    public boolean register(Student student) {
        if(studentDao.getByEmail(student.getEmail())!=null)
            return false;
        else{
            studentDao.save(student);
            ///邮件的内容
            StringBuffer sb=new StringBuffer("感谢您注册Train COLLEGE,点击下面链接激活账号，请尽快激活！<br>");
            sb.append("如果这不是您的注册行为，请不要点击!<br>");
            sb.append("<a href=\"http://localhost:8080/student/activate?email=");
            sb.append(student.getEmail());
            sb.append("&validateCode=");
            sb.append(student.getPassword());
            sb.append("\">点击此处激活账户");
            sb.append("</a>");

            //发送邮件
          //  SendEmail.send(student.getEmail(), sb.toString());
            return true;
        }
    }

    public void processActivate(String email, String validateCode) throws ServiceException {
        Student student = studentDao.getByEmail(email);
        if(student!=null){
            if(student.getState()==0){
                if(validateCode.equals(student.getPassword())) {
                    //激活成功，并更新用户的激活状态，为已激活
                    student.setState(1);//把状态改为激活
                    studentDao.saveOrUpdate(student);
                } else {
                    throw new ServiceException("激活码不正确");
                }
            }else if(student.getState()==1){
                throw new ServiceException("该邮箱已经激活！");
            }else{
                throw new ServiceException("该邮箱所注册账号已废弃，不可激活！");
            }
        }else{
            throw new ServiceException("该邮箱未注册（邮箱地址不存在）！");
        }
    }

    public int enrollLesson(Orders orders, List<LessonProgress> progresses) throws ServiceException {
        if(progresses==null||progresses.size()==0)
            throw new ServiceException("报名人数至少一人");
        int expr = studentDao.get(orders.getUid()).getExpr();
        double discount = LevelDiscount.getDiscount(expr);

        orders.setOrderTime(new Date());
        int cid = lessonDao.get(orders.getLid()).getCid();
        orders.setCid(cid);

        int totalPay = 0;
        if(progresses.get(0).getClassId()==0){
//            不分配班级
            List<Classes> classes = classesDao.getByLessonId(orders.getLid());
            double payment = classes.get(0).getPrice();
            for(Classes c:classes){
                if(payment>c.getPrice())
                    payment = c.getPrice();
            }

            totalPay = new Double(progresses.size()*payment).intValue();
            for(LessonProgress lp:progresses){
                lp.setCid(cid);
                lp.setPayment(new Double(payment).intValue());
                lp.setClassNo(0);
            }
        }else{
            for(LessonProgress lp:progresses){
                lp.setCid(cid);
                Classes classes = classesDao.get(lp.getClassId());
                lp.setPayment(new Double(classes.getPrice()*discount).intValue());
                totalPay+=lp.getPayment();

                int studentNum = lessonProDao.getByClassIdNo(classes.getId(),-1).size();
                if(studentNum>=classes.getNum()*classes.getSize()){
                    throw new ServiceException(classes.getName()+" 报名人数已达上限，请重新选班");
                }else{
                    int classNo = studentNum / classes.getSize()+1;
                    lp.setClassNo(classNo);
                }
            }
        }
        orders.setTotalPay(totalPay);

//        保存order，获得它的ID
        int oid = orderDao.save(orders);

        for(LessonProgress lp:progresses){
            lp.setOid(oid);
            lessonProDao.save(lp);
        }
        return oid;
    }

    public void payOrder(int oid, String bankCardID, String password) throws ServiceException {
        Orders order = orderDao.get(oid);
        if(order.getState()!=0)
            throw new ServiceException("订单状态已发生变化，请刷新后重试");

        BankCard card = bankDao.findByCardIDPwd(bankCardID,password);
        if(card==null)
            throw new ServiceException("银行卡密码输入不正确，支付失败");
        else if(card.getBalance()<order.getTotalPay())
            throw new ServiceException("银行卡余额不足，支付失败");

        PayRecord payRecord = new PayRecord();
        payRecord.setCid(order.getCid());
        payRecord.setUid(order.getUid());
        payRecord.setBankCardID(bankCardID);
        payRecord.setPayment(order.getTotalPay());
        payRecord.setType(0);
        payRecord.setEmail(studentDao.get(order.getUid()).getEmail());
        payRecord.setCollegeName(collegeDao.get(order.getCid()).getName());
        payRecord.setOid(oid);
        payRecord.setPaytime(new Date());

        bankDao.save(payRecord);

        changeOrderState(oid,1);
        Student student = studentDao.get(order.getUid());
        student.setExpr(student.getExpr()+order.getTotalPay()/100);
        studentDao.saveOrUpdate(student);
        bankDao.saveCard("00000000",order.getTotalPay());
        bankDao.saveCard(card.getCardNo(),-order.getTotalPay());
    }

    public double retrieve(int oid) {
        Orders order = orderDao.get(oid);
        PayRecord before = bankDao.findByOrderId(oid);
        if(before==null||order==null)
            return 0;

        Lesson lesson = lessonDao.get(order.getLid());
        double result = order.getTotalPay()*LevelDiscount.getCompensation(lesson.getStartDay());
        Student student = studentDao.get(order.getUid());
        student.setExpr(student.getExpr()-order.getTotalPay()/100);
        studentDao.saveOrUpdate(student);

        PayRecord payRecord = new PayRecord();
        payRecord.setCid(order.getCid());
        payRecord.setUid(order.getUid());
        payRecord.setBankCardID("00000000");
        payRecord.setPayment(result);
        payRecord.setType(1);
        payRecord.setEmail(studentDao.get(order.getUid()).getEmail());
        payRecord.setCollegeName(collegeDao.get(order.getCid()).getName());
        payRecord.setOid(oid);
        payRecord.setPaytime(new Date());
        bankDao.save(payRecord);

        changeOrderState(oid,2);
        bankDao.saveCard("00000000",-result);
        bankDao.saveCard(before.getBankCardID(),result);
        return result;
    }

    public void changeOrderState(int oid, int state) {
        List<LessonProgress> progresses = lessonProDao.getByOrderId(oid);
        for(LessonProgress lp:progresses){
            lp.setState(state);
            lessonProDao.saveOrUpdate(lp);
        }
        Orders order = orderDao.get(oid);
        order.setState(state);
        orderDao.saveOrUpdate(order);
    }

    public void profileSave(Student student) {
        studentDao.saveOrUpdate(student);
    }

    public int[] getHomepageData(int uid) {
        int[] result = {0,0,0,0};
//        订单数，课程数，出勤率，交易量
        result[0] = orderDao.getByStateUid(uid,-1).size();
        result[1] = lessonProDao.getByUidState(Integer.toString(uid),-1).size();
        List<Attendance> attds = lessonProDao.getAttdByUidType(Integer.toString(uid),0) ;
        for(Attendance attd:attds){
            if(attd.getGrade()==3)
                result[2]++;
        }
        if(attds==null||attds.size()==0){
            result[2] = 0;
        }else{
            result[2] = 100*result[2]/attds.size();
        }

        result[3] = bankDao.findByUid(uid).size();
        return result;
    }

    public int[] getAttdNums1(int lpid) {
        int[] result = {0,0,0,0};

        List<Attendance> attds = lessonProDao.getAttdByLessonProIdType(lpid,0);
        for(Attendance attd:attds){
            result[attd.getGrade()]++;
        }

        return result;
    }

    public int[] getAttdNums2(int lpid) {
//        <60/60-80/80-90/90-100
        int[] result = {0,0,0,0};

        List<Attendance> attds = lessonProDao.getAttdByLessonProIdType(lpid,1);
        for(Attendance attd:attds){
            int grade = attd.getGrade();
            if(grade<60)
                result[0]++;
            else if(grade<80)
                result[1]++;
            else if(grade<90)
                result[2]++;
            else
                result[3]++;
        }

        return result;
    }

    public List<PayRecord> getPayRecordByUid(int uid) {
        return bankDao.findByUid(uid);
    }

    public List<Lesson> getLessons() {
        return lessonDao.getByState(123);
    }

    public List<Orders> getOrdersByStateUid(int uid, int state) {
        return orderDao.getByStateUid(uid,state);
    }

    public Orders getOrderById(int oid) {
        return orderDao.get(oid);
    }

    public List<LessonProgress> getLessonProByUidState(String uid, int state) {
        List<LessonProgress> progresses = lessonProDao.getByUidState(uid,state);
        if(progresses==null)
            progresses = new LinkedList<LessonProgress>();
        return progresses;
    }

    public List<LessonProgress> getLessonProByOid(int oid) {
        return lessonProDao.getByOrderId(oid);
    }

    public NormalStudent getStudentById(String id) {
        if(id.startsWith("x")){
            return studentDao.getNormalStudent(Integer.parseInt(id.substring(1)));
        }else{
            return new NormalStudent(studentDao.get(Integer.parseInt(id)));
        }
    }

    public Student getStudentByEmail(String email) {
        return studentDao.getByEmail(email);
    }

    public College getCollegeById(int cid) {
        return collegeDao.get(cid);
    }

    public Lesson getLessonByLid(int lid) {
        return lessonDao.get(lid);
    }

    public List<Classes> getClassesByLid(int lid) {
        return classesDao.getByLessonId(lid);
    }

    public Classes getClassesById(int id) {
        return classesDao.get(id);
    }

    public NormalStudent getNmStudent(String name, String phone) {
        NormalStudent ns = studentDao.getNmStudentByNamePhone(name,phone);
        if(ns==null) {
            ns = new NormalStudent();
            ns.setPhone(phone);
            ns.setUsername(name);
            ns.setId(studentDao.saveNmStudent(ns));
        }
        return ns;
    }

}
