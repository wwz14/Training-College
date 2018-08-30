package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.Lesson;

import java.util.Date;
import java.util.List;

public interface LessonDao extends BaseDao<Lesson,Integer>  {
    public List<Lesson> getByCollegeId(int cid);

    public List<Lesson> getByState(int state);

    public List<Lesson> getByLessonStateCid(int cid,int state);

    public List<Lesson> getBetweenDays(Date start, Date end);
}
