package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.Manager;

public interface ManagerDao extends BaseDao<Manager,Integer>{
    public Manager getByNamePwd(String name, String password);
}
