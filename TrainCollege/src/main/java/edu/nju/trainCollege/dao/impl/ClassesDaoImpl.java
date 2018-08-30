package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.ClassesDao;
import edu.nju.trainCollege.model.Classes;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ClassesDaoImpl implements ClassesDao{
    @Autowired
    private SessionFactory sessionFactory;

    private static final String fromDatabase = "from Classes ";
    private static final String searchByLessonId = "where lid = :lid";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }
    public List<Classes> getByLessonId(int lid) {
        Query query = getCurrentSession().createQuery(fromDatabase+searchByLessonId).setParameter("lid",lid);
        return query.list();
    }

    public List<Classes> getByLidOrder(int lid, String order) {
        String sql = fromDatabase+searchByLessonId;
        if(order!=null){
            sql+= " order by "+order;
        }
        Query query = getCurrentSession().createQuery(sql).setParameter("lid",lid);
        return query.list();
    }

    public Classes get(Integer id) {
        return getCurrentSession().get(Classes.class,id);
    }

    public void persist(Classes entity) {

    }

    public Integer save(Classes entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        Integer id = (Integer) session.save(entity);
        tx.commit();

        return id;
    }

    public void saveOrUpdate(Classes entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.saveOrUpdate(entity);
        tx.commit();
    }

    public void delete(Integer id) {
        Classes c = get(id);
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.delete(c);
        tx.commit();
    }

    public void flush() {

    }
}
