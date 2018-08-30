package edu.nju.trainCollege.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "lesson")
public class Lesson {
    @Id
    private int id;
//    所属的机构ID
    private int cid;
    private Date startDay;
    private Date endDay;
    private String name;
    private String type;
    private String intro;
    //    状态0，保存未发布；状态1，发布可报名；状态2，报名截至，开课；状态3，已结束
    private int state;

//    每周多少个课时
    private int timePerWeek;

//    要上多少周
    private int weekNum;

    public Lesson() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getStartDay() {
        return startDay;
    }

    public void setStartDay(Date startDay) {
        this.startDay = startDay;
    }

    public Date getEndDay() {
        return endDay;
    }

    public void setEndDay(Date endDay) {
        this.endDay = endDay;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public int getTimePerWeek() {
        return timePerWeek;
    }

    public void setTimePerWeek(int timePerWeek) {
        this.timePerWeek = timePerWeek;
    }

    public int getWeekNum() {
        return weekNum;
    }

    public void setWeekNum(int weekNum) {
        this.weekNum = weekNum;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
