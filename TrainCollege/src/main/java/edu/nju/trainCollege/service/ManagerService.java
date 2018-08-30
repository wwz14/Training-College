package edu.nju.trainCollege.service;

import edu.nju.trainCollege.model.College;
import edu.nju.trainCollege.model.Manager;
import edu.nju.trainCollege.model.MyData;
import edu.nju.trainCollege.model.Student;

import java.util.List;

public interface ManagerService {
    public Manager login(String name, String password);

    public void collegePayment(double proportion);

    public int[] getCollegeOrderByYear(int cid,int year);

    public int[] getStudentLevelData();

    public int[] getPaymentByYear(int year);

    public String getAllPayCollege();

    public List<College> getAllColleges();

    public List<College> getUncheckedColleges();

    public College getCollege(int id);

    public boolean changeCollegeState(int id,int state);

    public List<Student> getAllStudents();

    public Student getStudent(int id);
}
