package edu.nju.trainCollege.tools;

import edu.nju.trainCollege.dao.OrderDao;
import edu.nju.trainCollege.service.CollegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduleTask {

    @Autowired
    private CollegeService collegeService;

    @Autowired
    private OrderDao orderDao;

//     [秒] [分] [小时] [日] [月] [周] [年,可不填]
    @Scheduled(cron = "0 0 0 * * ? ")
    public void autoArrangeClass(){
        collegeService.autoArrangeClass();
    }

    @Scheduled(cron = "0 * * * * ? ")
    public void checkOrderPay(){
        System.out.println("check");
        orderDao.checkOrder();
    }
}
