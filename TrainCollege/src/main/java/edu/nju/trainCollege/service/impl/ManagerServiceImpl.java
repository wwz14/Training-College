package edu.nju.trainCollege.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import edu.nju.trainCollege.dao.*;
import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.ManagerService;
import edu.nju.trainCollege.tools.LevelDiscount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    private ManagerDao managerDao;
    @Autowired
    private CollegeDao collegeDao;
    @Autowired
    private StudentDao studentDao;
    @Autowired
    private BankDao bankDao;

    @Autowired
    private OrderDao orderDao;

    public Manager login(String name, String password) {
        return managerDao.getByNamePwd(name,password);
    }

    public void collegePayment(double proportion) {
        Date startDay;
        List<PayRecord> records = bankDao.findByType2();
        if(records==null||records.size()==0)
            startDay=null;
        else
            startDay = records.get(0).getPaytime();

        Date endDay = new Date();
        //TODO
        records = bankDao.findBetweenDays(startDay,endDay);

        if(records==null||records.size()==0)
            return;
        PayRecord last = records.get(0);
        double payment = 0;
        for(PayRecord record:records){
            if(last.getCid()!=record.getCid()){
                payment*=proportion;
                PayRecord newRecord = new PayRecord();
                newRecord.setUid(0);
                newRecord.setEmail("管理员");
                newRecord.setCid(last.getCid());
                newRecord.setCollegeName(last.getCollegeName());
                newRecord.setType(2);
                newRecord.setPaytime(new Date());
                newRecord.setOid(0);
                if(collegeDao.get(last.getCid())==null)
                    continue;
                else{
                    String no = collegeDao.get(last.getCid()).getCardNo();
                    if(no==null||no.equals(""))
                        continue;
                    else {
                        newRecord.setBankCardID("00000000");
                    }
                }
                newRecord.setPayment(payment);
                bankDao.saveCard(last.getBankCardID(),payment);
                bankDao.saveCard("00000000",-payment);
                bankDao.save(newRecord);
                last = record;
                payment = 0;
            }

            if(record.getType()==0){
                payment+=record.getPayment();
            }else{
                payment-=record.getPayment();
            }
        }

        payment*=proportion;
        PayRecord newRecord = new PayRecord();
        newRecord.setUid(0);
        newRecord.setEmail("管理员");
        newRecord.setCid(last.getCid());
        newRecord.setCollegeName(last.getCollegeName());
        newRecord.setType(2);
        newRecord.setPaytime(new Date());
        newRecord.setOid(0);
        if(collegeDao.get(last.getCid())==null)
            return;
        else{
            String no = collegeDao.get(last.getCid()).getCardNo();
            if(no==null||no.equals(""))
                return;
            else {
                newRecord.setBankCardID("00000000");
            }
        }
        newRecord.setPayment(payment);
        bankDao.saveCard(last.getBankCardID(),payment);
        bankDao.saveCard("00000000",-payment);
        bankDao.save(newRecord);
    }

    public int[] getCollegeOrderByYear(int cid, int year) {
        int[] result = new int[12];
        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.set(year,0,1);
        Date start = calendar.getTime();
        calendar.set(year+1,0,1);
        Date end = calendar.getTime();

        List<Orders> orders = orderDao.getNumByCidYear(cid,start,end);

        for(Orders o:orders){
            calendar.setTime(o.getOrderTime());
            result[calendar.get(Calendar.MONTH)]++;//月份从0开始
        }
        return result;
    }

    public int[] getStudentLevelData() {
        int[] result = new int[7];
        List<Student> students = studentDao.getStudent();

        for(Student student:students){
            result[LevelDiscount.getLevel(student.getExpr())-1]++;
        }
        return result;
    }

    public int[] getPaymentByYear(int year) {
//        前12个为用户付费每月数额，后12个为用户退款每月数额
        int[] result = new int[24];

        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.set(year,0,1);
        Date start = calendar.getTime();
        calendar.set(year+1,0,1);
        Date end = calendar.getTime();

        List<PayRecord> payRecords = bankDao.findBetweenDays(start,end);
        for(PayRecord record : payRecords){
            if(record.getType()==0){
//               用户付费
                calendar.setTime(record.getPaytime());
                result[calendar.get(Calendar.MONTH)]+=record.getPayment();//月份从0开始
            }else if(record.getType()==1){
                calendar.setTime(record.getPaytime());
                result[calendar.get(Calendar.MONTH)+12]+=record.getPayment();//月份从0开始
            }
        }
        return result;
    }

    public String getAllPayCollege() {
        Date startDay;
        List<PayRecord> records = bankDao.findByType2();
        if(records==null||records.size()==0)
            startDay=null;
        else
            startDay = records.get(0).getPaytime();

        Date endDay = new Date();
        //TODO
        records = bankDao.findBetweenDays(startDay,endDay);

        if(records==null||records.size()==0)
            return null;

        PayRecord last = records.get(0);
        double in = 0;
        double out = 0;
        int number = 0;

        ObjectMapper mapper = new ObjectMapper();
        ObjectNode root = mapper.createObjectNode();
        ArrayNode arrayNode = root.putArray("data");
        for(PayRecord record:records){
            if(last.getCid()!=record.getCid()){
                ObjectNode node = mapper.createObjectNode();
                node.put("cid", last.getCid());
                node.put("in", in);
                node.put("out", out);
                node.put("number", number);
                arrayNode.add(node);

                last = record;
                in = 0;
                out = 0;
                number = 0;
            }

            number++;
            if(record.getType()==0){
                in+=record.getPayment();
            }else{
                out+=record.getPayment();
            }
        }

        ObjectNode node = mapper.createObjectNode();
        node.put("cid", last.getCid());
        node.put("in", in);
        node.put("out", out);
        node.put("number", number);
        arrayNode.add(node);

        try {
            return mapper.writeValueAsString(root);
        }catch (Exception ex){
            ex.printStackTrace();
            return "";
        }

    }

    public List<College> getAllColleges() {
        return collegeDao.getCollegeByState(-1);
    }

    public List<College> getUncheckedColleges() {
        return collegeDao.getCollegeByState(0);
    }

    public College getCollege(int id) {
        return collegeDao.get(id);
    }

    public boolean changeCollegeState(int id,int state) {
        try {
            College college = collegeDao.get(id);
            college.setState(state);
            collegeDao.saveOrUpdate(college);
            return true;
        }catch (Exception ex){
            return false;
        }
    }

    public List<Student> getAllStudents() {
        return studentDao.getStudent();
    }

    public Student getStudent(int id) {
        return studentDao.get(id);
    }
}
