package edu.nju.trainCollege.model;

import javax.persistence.*;

@Entity
@Table(name = "student")
public class Student{

    @Id
    private int id;

    private String email;

    private String username;

    private String password;

    private String phone;

//    实付金额/100
    private int expr;

//    状态0：未验证，状态1：已验证，状态2：已注销
    private int state;

    public int getExpr() {
        return expr;
    }

    public void setExpr(int expr) {
        this.expr = expr;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
