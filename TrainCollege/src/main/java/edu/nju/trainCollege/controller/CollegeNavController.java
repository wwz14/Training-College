package edu.nju.trainCollege.controller;

import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.CollegeService;
import edu.nju.trainCollege.service.StudentService;
import edu.nju.trainCollege.tools.LevelDiscount;
import edu.nju.trainCollege.tools.NumberTool;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@SessionAttributes({"student","college"})
@RequestMapping("college/")
public class CollegeNavController {

    @Autowired
    private CollegeService collegeService;

    @Autowired
    private StudentService studentService;

    @RequestMapping("homepage")
    public String homepage(HttpServletRequest request, ModelMap model){
        int cid = ((College)request.getSession().getAttribute("college")).getId();
        List<PayRecord> payRecords =collegeService.getPayRecordByCollegeid(cid);
        if(payRecords!=null&&payRecords.size()>5){
            model.addAttribute("paymentList",payRecords.subList(0,5));
        }else{
            model.addAttribute("paymentList",payRecords);
        }

        model.addAttribute("datas",collegeService.getHomepageData(cid));

        return "/college/homepage";
    }

    @RequestMapping(value = "all_lessons",method = RequestMethod.GET)
    public String allLessonView(){
        return "/college/all_lessons";
    }

    @RequestMapping(value = "release_lessons",method = RequestMethod.GET)
    public String releaseLessonView(){
        return "/college/release_lessons";
    }

    @RequestMapping(value = "unrelease_lessons",method = RequestMethod.GET)
    public String unreleaseLessonView(){
        return "/college/unrelease_lessons";
    }

    @RequestMapping(value = "begin_lessons",method = RequestMethod.GET)
    public String beginLessonView(){
        return "/college/begin_lessons";
    }

    @RequestMapping(value = "payment_chart",method = RequestMethod.GET)
    public String paymentChartView(HttpServletRequest request, ModelMap model){
        int year;
        if(request.getParameter("year")!=null){
            year = Integer.parseInt(request.getParameter("year"));
        }else{
            year = Calendar.getInstance().get(Calendar.YEAR);
        }
        model.addAttribute("year",year);
        return "/college/money_charts";
    }

    @RequestMapping(value = "get_inout_data",method = RequestMethod.POST)
    @ResponseBody
    public int[] getChartData(HttpServletRequest request){
        int year = Integer.parseInt(request.getParameter("year"));
        int cid = ((College)request.getSession().getAttribute("college")).getId();
        return collegeService.getPaymentByYear(cid,year);
    }

    @RequestMapping(value = "get_lessons_by_state",method = RequestMethod.POST)
    @ResponseBody
    public MyData getLessonsByState(HttpServletRequest request){
        int state = Integer.parseInt(request.getParameter("state"));
        int cid = ((College)request.getSession().getAttribute("college")).getId();
        return new MyData(collegeService.getLessonByStateCid(cid,state));
    }

    @RequestMapping(value = "profile",method = RequestMethod.GET)
    public String profileView(){
        return "/college/profile";
    }

    @RequestMapping(value = "profile_save",method = RequestMethod.POST)
    public String profileSave(HttpServletRequest request,ModelMap model){
        College college = (College) request.getSession().getAttribute("college");
        college.setTeacher(request.getParameter("teacher"));
        college.setLocation(request.getParameter("location"));
        college.setOther(request.getParameter("other"));
        college.setPhone(request.getParameter("phone"));
        college.setPhone(request.getParameter("name"));
        college.setState(0);
        collegeService.saveCollege(college);
        return "redirect:/logout";
    }

    @RequestMapping(value = "show_order",method = RequestMethod.GET)
    public String showOrderView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("oid")==null){
            return "redirect:/college/all_orders";
        }

        Orders orders = studentService.getOrderById(Integer.parseInt(request.getParameter("oid")));

        int lid = orders.getLid();
        model.addAttribute("lesson",studentService.getLessonByLid(lid));

        Student user = collegeService.getStudentById(orders.getUid());

        List<LessonProgress> progresses = studentService.getLessonProByOid(orders.getId());
        model.addAttribute("progresses",progresses).addAttribute("student",user);

        List<NormalStudent> students = new LinkedList<NormalStudent>();
        List<String> types = new LinkedList<String>();
        for(LessonProgress lp:progresses){
            String uid = lp.getUid();
            students.add(studentService.getStudentById(uid));
            int classId = lp.getClassId();
            if(classId==0)
                types.add("待分配");
            else
                types.add(studentService.getClassesById(classId).getName());
        }
        model.addAttribute("types",types);
        model.addAttribute("order",orders);
        model.addAttribute("NMstudents",students);
        model.addAttribute("discount", 10
                *LevelDiscount.getDiscount(user.getExpr()));

        return "/college/show_order";
    }

    @RequestMapping(value = "retrieve_orders",method = RequestMethod.GET)
    public String retrieveOrdersView(){
        return "/college/retrieve_orders";
    }

    @RequestMapping(value = "pay_orders",method = RequestMethod.GET)
    public String payOrdersView(){
        return "/college/pay_orders";
    }

    @RequestMapping(value = "all_orders",method = RequestMethod.GET)
    public String allOrdersView(){
        return "/college/all_orders";
    }

    @RequestMapping(value = "get_order_by_state",method = RequestMethod.POST)
    @ResponseBody
    public MyData getOrderByState(HttpServletRequest request){
        int state = Integer.parseInt(request.getParameter("state"));
        int cid = ((College)request.getSession().getAttribute("college")).getId();
        return new MyData(collegeService.getOrderByCidState(cid,state));
    }

    @RequestMapping(value = "bank_card_on",method = RequestMethod.POST)
    @ResponseBody
    public void bankCard(HttpServletRequest request){
        College college = (College) request.getSession().getAttribute("college");
        college.setCardNo(request.getParameter("cardNo"));
        collegeService.saveCollege(college);
    }

    @RequestMapping(value = "pwd_save",method = RequestMethod.POST)
    @ResponseBody
    public boolean savePwd(HttpServletRequest request){
        College college = (College) request.getSession().getAttribute("college");
        if(request.getParameter("old").equals(college.getPassword())){
            college.setPassword(request.getParameter("password"));
            collegeService.saveCollege(college);
            return true;
        }else
            return false;
    }

    @RequestMapping(value = "check_bank_card",method = RequestMethod.POST)
    @ResponseBody
    public boolean checkBankCard(HttpServletRequest request){
        return collegeService.checkCard(request.getParameter("cardNo"),request.getParameter("password"));
    }

    @RequestMapping(value = "enroll_lesson",method = RequestMethod.GET)
    public String enrollLessonView(HttpServletRequest request,ModelMap model){
        int cid = ((College)request.getSession().getAttribute("college")).getId();
        model.addAttribute("lessonList",collegeService.getLessonByStateCid(cid,1));
        return "/college/enroll_lesson";
    }

    @RequestMapping(value = "payment",method = RequestMethod.GET)
    public String paymentView(HttpServletRequest request,ModelMap model){
        int cid = ((College)request.getSession().getAttribute("college")).getId();
        model.addAttribute("paymentList",collegeService.getPayRecordByCollegeid(cid));
        return "/college/payment";
    }

    @RequestMapping(value = "enroll_offline",method = RequestMethod.POST)
    public String enrollWithClass(HttpServletRequest request){
        Orders orders = new Orders();
        orders.setLid(Integer.parseInt(request.getParameter("lid")));
        LessonProgress lp = new LessonProgress();

        if(request.getParameter("type").equals("1")){
//                是会员
            int uid = studentService.getStudentByEmail(request.getParameter("id")).getId();
            lp.setUid(Integer.toString(uid));
            orders.setUid(uid);
        }else{
            NormalStudent ns = studentService.getNmStudent(request.getParameter("id"),request.getParameter("phone"));
            lp.setUid("x"+ns.getId());
            orders.setUid(0);
        }
        orders.setCid(((College) request.getSession().getAttribute("college")).getId());
        lp.setClassId(Integer.parseInt(request.getParameter("classId")));
        lp.setCid(orders.getCid());

//        try {
            collegeService.enrollLesson(orders,lp);
            return "redirect:/college/homepage";
//        }catch (ServiceException ex){
//            return "redirect:/college/error?reason="+ex.getMessage();
//        }
    }

}
