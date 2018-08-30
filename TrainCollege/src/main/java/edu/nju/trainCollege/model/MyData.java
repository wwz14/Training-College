package edu.nju.trainCollege.model;

public class MyData {
    private Object data;

    public MyData(){}

    public MyData(Object o){
        this.data = o;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
