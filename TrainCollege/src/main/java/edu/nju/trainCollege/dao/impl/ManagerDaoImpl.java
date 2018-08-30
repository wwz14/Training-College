package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.ManagerDao;
import edu.nju.trainCollege.model.Manager;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ManagerDaoImpl implements ManagerDao {
    @Autowired
    private SessionFactory sessionFactory;

    private static final String searchByIdPwd = "from Manager where name = :name and password = :password";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }
    public Manager getByNamePwd(String name, String password) {
        Query query = getCurrentSession().createQuery(searchByIdPwd).setParameter("name",name).setParameter("password",password);

        if(query.list().size()==0)
            return null;
        else{
            return (Manager) query.list().get(0);
        }
    }

    public Manager get(Integer id) {
        return null;
    }

    public void persist(Manager entity) {

    }

    public Integer save(Manager entity) {
        return null;
    }

    public void saveOrUpdate(Manager entity) {

    }

    public void delete(Integer id) {

    }

    public void flush() {

    }
}
