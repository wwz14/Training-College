package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.Orders;

import java.util.Date;
import java.util.List;

public interface OrderDao extends BaseDao<Orders,Integer> {
    public List<Orders> getByStateUid(int uid, int state);

    public List<Orders> getByStateCid(int cid, int state);

    public List<Orders> getNumByCidYear(int cid, Date start, Date end);

    public List<Integer> getOidByLid(int lid);

    public void checkOrder();
}
