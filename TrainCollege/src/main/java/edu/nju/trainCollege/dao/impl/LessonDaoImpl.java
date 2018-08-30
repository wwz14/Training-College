package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.LessonDao;
import edu.nju.trainCollege.model.Lesson;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class LessonDaoImpl implements LessonDao {

    @Autowired
    private SessionFactory sessionFactory;

    private static final String fromDatabase = "from Lesson ";
    private static final String searchByCollegeId = "where cid = :cid";
    private static final String searchByName = "where name like :name";
    private static final String searchByType = "where type like :type";
    private static final String searchBetweenDates= "where startDay >= :start and endDay <= :end";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }

    public List<Lesson> getByCollegeId(int cid) {
        Query query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId).setParameter("cid",cid);
        return query.list();
    }

    public List<Lesson> getByState(int state) {
        Query query;
        if(state<0){
            query = getCurrentSession().createQuery(fromDatabase);
        }else if(state>10){
            query = getCurrentSession().createQuery(fromDatabase+"where state <> :state").setParameter("state",0);
        }else{
            query = getCurrentSession().createQuery(fromDatabase+"where state = :state").setParameter("state",state);
        }

        if(query.list().size()==0)
            return null;
        else{
            return query.list();
        }
    }

    public List<Lesson> getByLessonStateCid(int cid,int state) {
        Query query;
        if(state<0){
            query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId).setParameter("cid",cid);
        }else if(state>10){
            query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId+" and state <> :state").setParameter("cid",cid).setParameter("state",0);
        }else{
            query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId+" and state = :state").setParameter("cid",cid).setParameter("state",state);
        }

        return query.list();
    }

    public List<Lesson> getBetweenDays(Date start, Date end){
        Query query = getCurrentSession().createQuery(fromDatabase+"where state=1 and startDay>:start and " +
                "startDay <:end").setParameter("start",start).setParameter("end",end);
        return query.list();
    }

    public Lesson get(Integer id) {
        return getCurrentSession().get(Lesson.class,id);
    }

    public void persist(Lesson entity) {

    }

    public Integer save(Lesson entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.save(entity);
        tx.commit();

        Query query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId+" and name= :name and type= :type" +
                " order by id DESC").setParameter("name",entity.getName()).setParameter("cid",entity.getCid())
                .setParameter("type",entity.getType());;
        if(query.list().size()==0)
            return 0;
        else{
            return ((Lesson) query.list().get(0)).getId();
        }
    }

    public void saveOrUpdate(Lesson entity) {
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
