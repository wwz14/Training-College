package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.College;

import java.util.List;

public interface CollegeDao extends BaseDao<College,Integer> {
    public College getByIdPwd(int id, String password);

    /**
     * if find all colleges, state<0
     * @param state
     * @return
     */
    public List<College> getCollegeByState(int state);

}
