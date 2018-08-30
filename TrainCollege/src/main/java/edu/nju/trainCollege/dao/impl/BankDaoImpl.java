package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.BankDao;
import edu.nju.trainCollege.model.BankCard;
import edu.nju.trainCollege.model.PayRecord;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class BankDaoImpl implements BankDao {
    @Autowired
    private SessionFactory sessionFactory;
    private static final String fromCardDb = "from BankCard ";
    private static final String fromRecordDb = "from PayRecord ";
    private static final String searchByIdPwd = "where cardNo = :id and password = :password";
    private static final String searchByOid = "where oid = :oid";
    private static final String searchByUid = "where uid = :uid";
    private static final String searchByCid = "where cid = :cid";
    private static final String searchBetweenDays = "where paytime > :start and paytime < :endday";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }

    public PayRecord findByOrderId(int oid) {
        Query query = getCurrentSession().createQuery(fromRecordDb+searchByOid).setParameter("oid",oid);
        if(query.list().size()==0)
            return null;
        else{
            return (PayRecord) query.list().get(0);
        }
    }

    public List<PayRecord> findByUid(int uid) {
        Query query = getCurrentSession().createQuery(fromRecordDb+searchByUid+" order by paytime DESC").setParameter("uid",uid);
        return query.list();
    }

    public List<PayRecord> findByCollegeid(int cid) {
        Query query = getCurrentSession().createQuery(fromRecordDb+searchByCid+" order by paytime DESC")
                .setParameter("cid",cid);
        return query.list();
    }

    public List<PayRecord> findBetweenDays(Date startDay, Date endDay) {
        Query query = getCurrentSession().createQuery(fromRecordDb+searchBetweenDays+" order by cid")
                .setParameter("start",startDay).setParameter("endday",endDay);
        if(startDay==null)
            query = getCurrentSession().createQuery(fromRecordDb+"where paytime< :endday order by cid")
                    .setParameter("endday",endDay);
        return query.list();
    }

    public List<PayRecord> findByType2() {
        Query query = getCurrentSession().createQuery(fromRecordDb+"where type=2 order by paytime DESC");
        return query.list();
    }

    public BankCard findByCardIDPwd(String bankCardID, String password) {
        Query query = getCurrentSession().createQuery(fromCardDb+searchByIdPwd).setParameter("id",bankCardID)
                .setParameter("password",password);
        if(query.list().size()==0)
            return null;
        else{
            return (BankCard) query.list().get(0);
        }
    }

    public void saveCard(String id, double balance) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        BankCard card = getCurrentSession().get(BankCard.class,id);
        card.setBalance(card.getBalance()+balance);
        session.saveOrUpdate(card);
        tx.commit();
    }

    public PayRecord get(Integer id) {
        return getCurrentSession().get(PayRecord.class,id);
    }

    public void persist(PayRecord entity) {

    }

    public Integer save(PayRecord entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        Integer id = (Integer) session.save(entity);
        tx.commit();

        return id;
    }

    public void saveOrUpdate(PayRecord entity) {
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
