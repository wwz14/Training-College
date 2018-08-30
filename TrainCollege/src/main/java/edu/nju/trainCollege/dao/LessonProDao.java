package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.Attendance;
import edu.nju.trainCollege.model.LessonProgress;

import java.util.List;

public interface LessonProDao extends BaseDao<LessonProgress,Integer> {
    public List<LessonProgress> getByOrderId(int oid);

    public List<LessonProgress> getByUidState(String uid,int state);

    public List<LessonProgress> getByCollegeId(int cid);

    public List<LessonProgress> getByOidClassIdOrder(Object[] oids, int classId, String order);

    public void saveAttendance(Attendance attendance);

    public List<Attendance> getAttdByUidType(String uid,int type);

    public List<Attendance> getAttdByLessonProIdType(int lessonProId,int type);

    /**
     * 默认搜索状态为已支付的报名，若班号为负，即为搜索所有班号
     * @param classId 班级ID
     * @param classNo 班号
     * @return
     */
    public List<LessonProgress> getByClassIdNo(int classId,int classNo);
}
