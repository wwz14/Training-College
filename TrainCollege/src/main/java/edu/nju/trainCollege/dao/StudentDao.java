package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.NormalStudent;
import edu.nju.trainCollege.model.Student;

import java.util.List;

public interface StudentDao extends BaseDao<Student,Integer> {

    public Student getByEmailPwd(String email, String password);

    public Student getByEmail(String email);

    public List<Student> getStudent();

    public Integer saveNmStudent(NormalStudent student);

    public NormalStudent getNormalStudent(int id);

    public NormalStudent getNmStudentByNamePhone(String name,String phone);

}
