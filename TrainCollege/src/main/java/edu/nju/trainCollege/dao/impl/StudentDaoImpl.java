package edu.nju.trainCollege.dao.impl;

import edu.nju.trainCollege.dao.StudentDao;
import edu.nju.trainCollege.model.NormalStudent;
import edu.nju.trainCollege.model.Student;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.LinkedList;
import java.util.List;

@Repository
public class StudentDaoImpl implements StudentDao {
    @Autowired
    private SessionFactory sessionFactory;

    private static final String searchByEmailPwd = "from Student where email = :email and password = :password";
    private static final String searchByEmail = "from Student where email = :email";
    private static final String searchByNamePhone = "from NormalStudent where username = :username and phone= :phone";

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }


    public Student get(Integer id) {
        return getCurrentSession().get(Student.class,id);
    }

    public void persist(Student entity) {
        getCurrentSession().persist(entity);
    }

    public Integer save(Student entity) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        Integer id = (Integer) session.save(entity);
        tx.commit();

        return id;
    }

    public void saveOrUpdate(Student entity) {
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

    public Student getByEmailPwd(String email, String password) {
        Query query = getCurrentSession().createQuery(searchByEmailPwd).setParameter("email",email).setParameter("password",password);
        if(query.list().size()==0)
            return null;
        else{
            return (Student) query.list().get(0);
        }

    }

    public Student getByEmail(String email) {
        Query query = getCurrentSession().createQuery(searchByEmail).setParameter("email",email);
        if(query.list().size()==0)
            return null;
        else{
            return (Student) query.list().get(0);
        }
    }

    public List<Student> getStudent() {
        Query query = getCurrentSession().createQuery("from Student");
        if(query.list().size()==0)
            return new LinkedList<Student>();
        else{
            return query.list();
        }
    }

    public Integer saveNmStudent(NormalStudent student) {
        Session session = getCurrentSession();
        Transaction tx=session.beginTransaction();
        session.save(student);
        tx.commit();

        return getNmStudentByNamePhone(student.getUsername(),student.getPhone()).getId();
    }

    public NormalStudent getNormalStudent(int id) {
        return getCurrentSession().get(NormalStudent.class,id);
    }

    public NormalStudent getNmStudentByNamePhone(String name, String phone) {
        Query query = getCurrentSession().createQuery(searchByNamePhone).setParameter("username",name)
                .setParameter("phone",phone);
        if(query.list().size()==0)
            return null;
        else{
            return (NormalStudent) query.list().get(0);
        }
    }
}
