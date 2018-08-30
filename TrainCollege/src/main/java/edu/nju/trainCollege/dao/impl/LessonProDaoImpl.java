package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.LessonProDao;
import edu.nju.trainCollege.model.Attendance;
import edu.nju.trainCollege.model.LessonProgress;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LessonProDaoImpl implements LessonProDao {
    @Autowired
    private SessionFactory sessionFactory;

    private static final String fromLessonProDB = "from LessonProgress ";
    private static final String fromAttdDB = "from Attendance ";
    private static final String searchByOrderId = "where oid = :oid";
    private static final String searchByLessonProId = "where lessonProId = :lessonProId";
    private static final String searchByUserId = "where uid = :uid";
    private static final String searchByCollegeId = "where cid = :cid";
    private static final String searchByClassIdState = "where classId = :classId and state=1";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }
    public List<LessonProgress> getByOrderId(int oid) {
        Query query = getCurrentSession().createQuery(fromLessonProDB +searchByOrderId).setParameter("oid",oid);
        return query.list();
    }

    public List<LessonProgress> getByUidState(String uid,int state) {
        Query query;
        if(state>=0){
            query = getCurrentSession().createQuery(fromLessonProDB +searchByUserId+" and state = :state")
                    .setParameter("uid",uid).setParameter("state",state);
        }else{
            query = getCurrentSession().createQuery(fromLessonProDB +searchByUserId).setParameter("uid",uid);
        }
        return query.list();
    }

    public List<LessonProgress> getByCollegeId(int cid) {
        Query query = getCurrentSession().createQuery(fromLessonProDB +searchByCollegeId).setParameter("cid",cid);
        return query.list();
    }

    public List<LessonProgress> getByOidClassIdOrder(Object[] oids, int classId, String order) {
        String sql = fromLessonProDB+"where oid in (:oids)";
        if(classId>=0)
            sql+=" and classId ="+classId;
        if(order!=null)
            sql+=" order by "+order;
        Query query = getCurrentSession().createQuery(sql).setParameterList("oids",oids);
        return query.list();
    }

    public void saveAttendance(Attendance attendance) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.save(attendance);
        tx.commit();
    }

    public List<Attendance> getAttdByUidType(String uid, int type) {
        Query query = getCurrentSession().createQuery(fromAttdDB +searchByUserId+" and type =:type order by lessonDate ASC")
                .setParameter("uid",uid).setParameter("type",type);
        return query.list();
    }

    public List<Attendance> getAttdByLessonProIdType(int lessonProId,int type) {
        Query query = getCurrentSession().createQuery(fromAttdDB +searchByLessonProId+" and type =:type order by lessonDate ASC")
                .setParameter("lessonProId",lessonProId).setParameter("type",type);
        return query.list();
    }

    public List<LessonProgress> getByClassIdNo(int classId, int classNo) {
        Query query;
        if(classNo<0){
            query = getCurrentSession().createQuery(fromLessonProDB + searchByClassIdState).setParameter("classId",classId);
        }else{
            query = getCurrentSession().createQuery(fromLessonProDB + searchByClassIdState +" and classNo =:classNo")
                    .setParameter("classId",classId).setParameter("classNo",classNo);
        }

        return query.list();
    }

    public LessonProgress get(Integer id) {
        return getCurrentSession().get(LessonProgress.class,id);
    }

    public void persist(LessonProgress entity) {

    }

    public Integer save(LessonProgress entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        Integer id = (Integer) session.save(entity);
        tx.commit();

        return id;
    }

    public void saveOrUpdate(LessonProgress entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.saveOrUpdate(entity);
        tx.commit();
    }

    public void delete(Integer id) {

    }

    public void flush() {

    }
}
