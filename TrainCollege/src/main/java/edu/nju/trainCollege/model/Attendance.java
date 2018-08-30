package edu.nju.trainCollege.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "attendance")
public class Attendance {
    @Id
    private int id;

    private int lessonProId;

    private String uid;//方便检索

//    类型为0，则为考勤；类型为1，则为成绩
    private int type;

//    若是考勤，0为缺勤，1为迟到，2为早退，3为出勤；若为成绩，这就是分数
    private int grade;

    private Date lessonDate;

    public Attendance(int type) {
        this.type = type;
    }

    public Attendance() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public Date getLessonDate() {
        return lessonDate;
    }

    public void setLessonDate(Date lessonDate) {
        this.lessonDate = lessonDate;
    }

    public int getLessonProId() {
        return lessonProId;
    }

    public void setLessonProId(int lessonProId) {
        this.lessonProId = lessonProId;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
}
