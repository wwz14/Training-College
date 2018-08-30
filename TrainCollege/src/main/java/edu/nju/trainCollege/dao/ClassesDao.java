package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.Classes;

import java.util.List;

public interface ClassesDao extends BaseDao<Classes,Integer> {
    public List<Classes> getByLessonId(int lid);

    public List<Classes> getByLidOrder(int lid, String order);
}
