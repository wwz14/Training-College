package edu.nju.trainCollege.dao;

import edu.nju.trainCollege.model.BankCard;
import edu.nju.trainCollege.model.PayRecord;

import java.util.Date;
import java.util.List;

public interface BankDao extends BaseDao<PayRecord,Integer> {

    public PayRecord findByOrderId(int oid);

    public List<PayRecord> findByUid(int uid);

    public List<PayRecord> findByCollegeid(int cid);

    public List<PayRecord> findBetweenDays(Date startDay, Date endDay);

    /**
     * 按照时间顺序，读取所有的结算信息，用户id为0,email为管理员
     * @return
     */
    public List<PayRecord> findByType2();

    public BankCard findByCardIDPwd(String bankCardID, String password);

    /**
     * 更新银行卡余额
     * @param id 银行卡号
     * @param balance 余额变动的差值，可正可负
     */
    public void saveCard(String id, double balance);

}
