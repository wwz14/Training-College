package edu.nju.trainCollege.model;

import javax.persistence.*;

@Entity
@Table(name = "college")
public class College {
    @Id
    private int id;

    private String name;
    private String password;
    private String location;
    private String phone;
    private String other;
    private String teacher;
    private String cardNo;

//    状态0：注册未认证##状态1：已认证##状态2：审核不通过##状态3：主动关门
    private int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }
}
