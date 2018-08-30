package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.CollegeDao;
import edu.nju.trainCollege.model.College;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class CollegeDaoImpl implements CollegeDao {
    @Autowired
    private SessionFactory sessionFactory;

    private static final String searchByIdPwd = "from College where id = :id and password = :password";
    private static final String searchByNamePwd = "from College where name = :name and password = :password";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }
    public College getByIdPwd(int id, String password) {
        Query query = getCurrentSession().createQuery(searchByIdPwd).setParameter("id",id).setParameter("password",password);
        if(query.list().size()==0)
            return null;
        else{
            return (College) query.list().get(0);
        }
    }

    public List<College> getCollegeByState(int state) {
        Query query;
        if(state<0){
             query= getCurrentSession().createQuery("from College");
        }else{
            query= getCurrentSession().createQuery("from College where state =:state").setParameter("state",state);
        }

        return query.list();

    }

    public College get(Integer id) {
        return getCurrentSession().get(College.class,id);
    }

    public void persist(College entity) {
        getCurrentSession().persist(entity);
    }

    public Integer save(College entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.save(entity);
        tx.commit();

        Query query = getCurrentSession().createQuery(searchByNamePwd).setParameter("name",entity.getName()).setParameter("password",entity.getPassword());
        if(query.list().size()==0)
            return 0;
        else{
            return ((College) query.list().get(0)).getId();
        }
    }

    public void saveOrUpdate(College entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.saveOrUpdate(entity);
        tx.commit();
    }

    public void delete(Integer id) {

    }

    public void flush() {
        getCurrentSession().flush();
    }
}
