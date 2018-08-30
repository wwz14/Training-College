package edu.nju.trainCollege.dao;

import java.io.Serializable;

public interface BaseDao<T,PK extends Serializable> {

    T get(PK id);

    void persist(T entity);

    PK save(T entity);

    void saveOrUpdate(T entity);

    void delete(PK id);

    void flush();
}
