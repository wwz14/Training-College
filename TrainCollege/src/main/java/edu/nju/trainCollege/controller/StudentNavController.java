package edu.nju.trainCollege.controller;

import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.StudentService;
import edu.nju.trainCollege.tools.LevelDiscount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("student/")
@SessionAttributes({"student"})
public class StudentNavController {
    @Autowired
    private StudentService studentService;

    @RequestMapping("homepage")
    public String homepage(HttpServletRequest request,ModelMap model){
        int uid = ((Student) request.getSession().getAttribute("student")).getId();
        List<PayRecord> records = studentService.getPayRecordByUid(uid);
        if(records!=null&&records.size()>5){
            model.addAttribute("paymentList",records.subList(0,5));
        }else{
            model.addAttribute("paymentList",records);
        }

        model.addAttribute("datas",studentService.getHomepageData(uid));

        return "/student/homepage";
    }

    @RequestMapping(value = "get_student_by_email",method = RequestMethod.POST)
    @ResponseBody
    public boolean getStudentByEmail(HttpServletRequest request){
        String email = request.getParameter("email");
        return (studentService.getStudentByEmail(email)!=null);
    }

    @RequestMapping(value = "profile",method = RequestMethod.GET)
    public String profileView(HttpServletRequest request,ModelMap model){
        Student student = (Student) request.getSession().getAttribute("student");
        model.addAttribute("level", LevelDiscount.getLevel(student.getExpr()));
        model.addAttribute("discount", 10*LevelDiscount.getDiscount(student.getExpr()));

        return "/student/profile";
    }

    @RequestMapping(value = "profile_save",method = RequestMethod.POST)
    public String profileSave(HttpServletRequest request){
        Student student = (Student) request.getSession().getAttribute("student");
        student.setPhone(request.getParameter("phone"));
        studentService.profileSave(student);
        return "redirect:/student/profile";
    }

    @RequestMapping(value = "pwd_save",method = RequestMethod.POST)
    @ResponseBody
    public boolean pwdSave(HttpServletRequest request){
        Student student = (Student) request.getSession().getAttribute("student");
        if(!request.getParameter("old").equals(student.getPassword())){
            System.out.println(request.getParameter("old"));
            return false;
        }
        student.setPassword(request.getParameter("password"));
        studentService.profileSave(student);
        return true;
    }

    @RequestMapping(value = "show_progress",method = RequestMethod.GET)
    public String showProgressView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("lpid")==null){
            return "redirect:/student/has_pay_progress";
        }
        int lpid = Integer.parseInt(request.getParameter("lpid"));
        model.addAttribute("lpid",lpid);

        model.addAttribute("state",studentService.getAttdNums1(lpid));
        model.addAttribute("grade",studentService.getAttdNums2(lpid));
        return "/student/show_progress";
    }

    @RequestMapping(value = "show_lesson",method = RequestMethod.GET)
    public String showLessonsView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("lid")==null){
            return "redirect:/student/all_lessons";
        }
        int lid = Integer.parseInt(request.getParameter("lid"));
        Lesson lesson = studentService.getLessonByLid(lid);
        model.addAttribute("college",studentService.getCollegeById(lesson.getCid()));
        model.addAttribute("lesson",lesson);
        model.addAttribute("classList",studentService.getClassesByLid(lid));

        return "/student/show_lesson";
    }

    @RequestMapping(value = "payment",method = RequestMethod.GET)
    public String paymentView(HttpServletRequest request,ModelMap model){
        int uid = ((Student) request.getSession().getAttribute("student")).getId();
        model.addAttribute("paymentList",studentService.getPayRecordByUid(uid));
        return "/student/payment";
    }

    @RequestMapping(value = "all_progress",method = RequestMethod.GET)
    public String allProgressView(){
        return "/student/all_progresses";
    }

    @RequestMapping(value = "retrieve_progress",method = RequestMethod.GET)
    public String retrieveProgressView(){
        return "student/retrieve_progress";
    }

    @RequestMapping(value = "has_pay_progress",method = RequestMethod.GET)
    public String haspayProgressView(){
        return "student/has_pay_progress";
    }

    @RequestMapping(value = "all_orders",method = RequestMethod.GET)
    public String allOrdersView(){
        return "/student/all_orders";
    }

    @RequestMapping(value = "retrieve_orders",method = RequestMethod.GET)
    public String retrieveOrdersView(){
        return "student/retrieve_orders";
    }

    @RequestMapping(value = "has_pay_orders",method = RequestMethod.GET)
    public String haspayOrdersView(){
        return "student/has_pay_orders";
    }

    @RequestMapping(value = "not_pay_orders",method = RequestMethod.GET)
    public String notpayOrdersView(){
        return "/student/not_pay_orders";
    }

    @RequestMapping(value = "get_order_by_state",method = RequestMethod.POST)
    @ResponseBody
    public MyData getOrdersByState(HttpServletRequest request){
        int state = Integer.parseInt(request.getParameter("state"));
        int uid = ((Student) request.getSession().getAttribute("student")).getId();
        List<Orders> orders= studentService.getOrdersByStateUid(uid,state);
        if(orders==null)
            orders = new LinkedList<Orders>();
        return new MyData(orders);
    }

    @RequestMapping(value = "get_progress_by_state",method = RequestMethod.POST)
    @ResponseBody
    public MyData getProgressByState(HttpServletRequest request){
        int state = Integer.parseInt(request.getParameter("state"));
        String uid = Integer.toString(((Student) request.getSession().getAttribute("student")).getId());
        return new MyData(studentService.getLessonProByUidState(uid,state));
    }

    @RequestMapping(value = "all_lessons",method = RequestMethod.GET)
    public String allLessonsView(){
        return "/student/all_lessons";
    }

    @RequestMapping(value = "all_lessons",method = RequestMethod.POST)
    @ResponseBody
    public MyData getAllLessons(){
        return new MyData(studentService.getLessons());
    }
}
