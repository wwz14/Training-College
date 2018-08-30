package edu.nju.trainCollege.service;

import edu.nju.trainCollege.model.*;
import org.hibernate.service.spi.ServiceException;

import javax.mail.internet.ParseException;
import java.util.List;

public interface StudentService {
    public Student login(String email,String password);

    public boolean register(Student student);

    public void processActivate(String email , String validateCode)throws ServiceException;

    public int enrollLesson(Orders orders,List<LessonProgress> progresses)throws ServiceException;

    public void payOrder(int oid, String bankCardID, String password) throws ServiceException;

    public double retrieve(int oid);

    public void changeOrderState(int oid,int state);

    public void profileSave(Student student);

    public int[] getHomepageData(int uid);

    public int[] getAttdNums1(int lpid);

    public int[] getAttdNums2(int lpid);

    public List<PayRecord> getPayRecordByUid(int uid);

    public List<Lesson> getLessons();

    public List<Orders> getOrdersByStateUid(int uid,int state);

    public Orders getOrderById(int oid);

    public List<LessonProgress> getLessonProByUidState(String uid,int state);

    public List<LessonProgress> getLessonProByOid(int oid);

    /**
     * 如果ID以"x"开头，那么是普通学员，如果不是，则为会员
     * @param id LessonProgress中的uid
     * @return 学员
     */
    public NormalStudent getStudentById(String id);

    public Student getStudentByEmail(String email);

    public College getCollegeById(int cid);

    public Lesson getLessonByLid(int lid);

    public List<Classes> getClassesByLid(int lid);

    public Classes getClassesById(int id);

    /**
     * 如果非会员的信息不存在，就新建一条保存
     * @param name 学员名称
     * @param phone 学员联系方式
     * @return 非会员本人
     */
    public NormalStudent getNmStudent(String name,String phone);
}
