package edu.nju.trainCollege.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "normal_student")
public class NormalStudent {
    @Id
    private int id;

    private String username;

    private String phone;

    public NormalStudent(){}

    public NormalStudent(Student student){
        this.username = student.getUsername();
        this.phone = student.getPhone();
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
