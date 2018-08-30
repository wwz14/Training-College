package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.OrderDao;
import edu.nju.trainCollege.model.Orders;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Repository
public class OrderDaoImpl implements OrderDao {
    @Autowired
    private SessionFactory sessionFactory;

    private static final String fromDatabase = "from Orders ";
    private static final String searchByUserId = "where uid = :uid";
    private static final String searchByCollegeId = "where cid = :cid";
    private static final String searchByLid = "where lid = :lid";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }

    public List<Orders> getNumByCidYear(int cid, Date start, Date end) {
        Query query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId+
                " and state = 1 and orderTime > :start and orderTime < :end").setParameter("start",start).
                setParameter("end",end).setParameter("cid",cid);

        if(query.list().size()==0)
            return new LinkedList<Orders>();
        else{
            return query.list();
        }
    }

    public List<Integer> getOidByLid(int lid) {
        Query query = getCurrentSession().createQuery("select id "+fromDatabase+searchByLid).setParameter("lid",lid);
        return query.list();
    }

    public void checkOrder() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE,-15);
        Query query = getCurrentSession().createQuery(fromDatabase+"where orderTime<:end and state=0").
                setParameter("end",calendar.getTime());
        List<Orders> orders = query.list();
        for(Orders o:orders){
            o.setState(3);
            this.saveOrUpdate(o);
        }
    }

    public List<Orders> getByStateUid(int uid,int state) {
        Query query;
        if(state>=0){
            query = getCurrentSession().createQuery(fromDatabase+searchByUserId+" and state =:state")
                    .setParameter("uid",uid).setParameter("state",state);
        }else{
            query = getCurrentSession().createQuery(fromDatabase+searchByUserId).setParameter("uid",uid);
        }
        if(query.list().size()==0)
            return new LinkedList<Orders>();
        else{
            return query.list();
        }
    }

    public List<Orders> getByStateCid(int cid, int state) {
        Query query;
        if(state>=0){
            query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId+" and state =:state")
                    .setParameter("cid",cid).setParameter("state",state);
        }else{
            query = getCurrentSession().createQuery(fromDatabase+searchByCollegeId).setParameter("cid",cid);
        }
        if(query.list().size()==0)
            return new LinkedList<Orders>();
        else{
            return query.list();
        }
    }

    public Orders get(Integer id) {
        return getCurrentSession().get(Orders.class,id);
    }

    public void persist(Orders entity) {

    }

    public Integer save(Orders entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.save(entity);
        tx.commit();

        Query query = getCurrentSession().createQuery(fromDatabase+searchByUserId+" order by orderTime DESC")
                .setParameter("uid",entity.getUid());

        if(query.list().size()==0)
            return 0;
        else{
            return ((Orders) query.list().get(0)).getId();
        }
    }

    public void saveOrUpdate(Orders entity) {
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
