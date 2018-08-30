package edu.nju.trainCollege.controller;

import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.StudentService;
import edu.nju.trainCollege.tools.LevelDiscount;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("student/")
@SessionAttributes({"student"})
public class StudentOrderController {
    @Autowired
    private StudentService studentService;


    @RequestMapping(value = "retrieve_order",method = RequestMethod.POST)
    @ResponseBody
    public double retrieveOrder(HttpServletRequest request){
        int oid = Integer.parseInt(request.getParameter("oid"));
        return studentService.retrieve(oid);
    }

    @RequestMapping(value = "pay_order",method = RequestMethod.POST)
    public String payOrder(HttpServletRequest request,ModelMap model){
        int oid = Integer.parseInt(request.getParameter("oid"));

        try {
            studentService.payOrder(oid,request.getParameter("cardNo"),request.getParameter("password"));
            return "redirect:/student/show_order?oid="+oid;
        }catch (ServiceException ex){
            System.out.println(ex.getMessage());
            return "redirect:/student/error?reason="+ex.getMessage();
        }
    }

    @RequestMapping(value = "show_order",method = RequestMethod.GET)
    public String showOrderView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("oid")==null){
            return "redirect:/student/all_orders";
        }

        Orders orders = studentService.getOrderById(Integer.parseInt(request.getParameter("oid")));
        Student user = (Student) request.getSession().getAttribute("student");
//        如果不是登陆用户本人的订单无法查看，如果不是未支付订单，无法查看
        if(orders.getUid()!=user.getId())
            return "redirect:/student/all_orders";
        if(orders.getState()==0)
            return "redirect:/student/show_order_not_pay?oid="+orders.getId();

        int lid = orders.getLid();
        model.addAttribute("lesson",studentService.getLessonByLid(lid));

        List<LessonProgress> progresses = studentService.getLessonProByOid(orders.getId());
        model.addAttribute("progresses",progresses);

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

        return "/student/show_order";
    }

    @RequestMapping(value = "show_order_not_pay",method = RequestMethod.GET)
    public String showOrderNotPayView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("oid")==null){
            return "redirect:/student/all_orders";
        }

        Orders orders = studentService.getOrderById(Integer.parseInt(request.getParameter("oid")));
        Student user = (Student) request.getSession().getAttribute("student");
//        如果不是登陆用户本人的订单无法查看，如果不是未支付订单，无法查看
        if(orders.getUid()!=user.getId())
            return "redirect:/student/all_orders";
        else if(orders.getState()!=0){
            return "redirect:/student/show_order?oid="+orders.getId();
        }
//         如果超过15分钟未提交
        if((new Date().getTime()-orders.getOrderTime().getTime())/1000>2*60) {
            studentService.changeOrderState(orders.getId(),3);
            return "redirect:/student/all_orders";
        }

        int lid = orders.getLid();
        model.addAttribute("lesson",studentService.getLessonByLid(lid));

        List<LessonProgress> progresses = studentService.getLessonProByOid(orders.getId());
        model.addAttribute("progresses",progresses);

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

        return "/student/show_order_not_pay";
    }

    @RequestMapping(value = "enroll_lesson_without",method = RequestMethod.POST)
    public String enrollWithoutClass(HttpServletRequest request){
        int studentNum = Integer.parseInt(request.getParameter("studentNum"));
        Orders orders = new Orders();
        orders.setUid(((Student) request.getSession().getAttribute("student")).getId());
        orders.setLid(Integer.parseInt(request.getParameter("lid")));
        List<LessonProgress> progresses = new ArrayList<LessonProgress>(studentNum);

        for(int i = 1;i<=studentNum;i++){
            LessonProgress lp = new LessonProgress();
            if(request.getParameter("type"+i).equals("1")){
//                是会员
                lp.setUid(Integer.toString(studentService.getStudentByEmail(request.getParameter("id"+i)).getId()));
            }else{
                NormalStudent ns = studentService.getNmStudent(request.getParameter("id"+i),request.getParameter("phone"+i));
                lp.setUid("x"+ns.getId());
            }
            progresses.add(lp);
        }

        try {
            int oid = studentService.enrollLesson(orders,progresses);
            return "redirect:/student/show_order_not_pay?oid="+oid;
        }catch (ServiceException ex){
            return "redirect:/student/error?reason="+ex.getMessage();
        }

    }

    @RequestMapping(value = "enroll_lesson_with_class",method = RequestMethod.POST)
    public String enrollWithClass(HttpServletRequest request){
        int studentNum = Integer.parseInt(request.getParameter("studentNum"));
        Orders orders = new Orders();
        orders.setUid(((Student) request.getSession().getAttribute("student")).getId());
        orders.setLid(Integer.parseInt(request.getParameter("lid")));
        List<LessonProgress> progresses = new ArrayList<LessonProgress>(studentNum);

        for(int i = 1;i<=studentNum;i++){
            LessonProgress lp = new LessonProgress();
            if(request.getParameter("type"+i).equals("1")){
//                是会员
                lp.setUid(Integer.toString(studentService.getStudentByEmail(request.getParameter("id"+i)).getId()));
            }else{
                NormalStudent ns = studentService.getNmStudent(request.getParameter("id"+i),request.getParameter("phone"+i));
                lp.setUid("x"+ns.getId());
            }
            lp.setClassId(Integer.parseInt(request.getParameter("classId"+i)));
            progresses.add(lp);
        }

        try {
            int oid = studentService.enrollLesson(orders,progresses);
            return "redirect:/student/show_order_not_pay?oid="+oid;
        }catch (ServiceException ex){
            return "redirect:/student/error?reason="+ex.getMessage();
        }
    }

    @RequestMapping(value = "enroll_lesson_with_class",method = RequestMethod.GET)
    public String enrollLessonWithClassView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("lid")==null){
            return "redirect:/student/all_lessons";
        }
        int lid = Integer.parseInt(request.getParameter("lid"));
        Lesson lesson = studentService.getLessonByLid(lid);
        model.addAttribute("lesson",lesson);
        model.addAttribute("classList",studentService.getClassesByLid(lid));

        return "student/enroll_lesson_with_class";
    }

    @RequestMapping(value = "enroll_lesson_without",method = RequestMethod.GET)
    public String enrollLessonWithoutView(HttpServletRequest request,ModelMap model){
        if(request.getParameter("lid")==null){
            return "redirect:/student/all_lessons";
        }
        int lid = Integer.parseInt(request.getParameter("lid"));
        Lesson lesson = studentService.getLessonByLid(lid);
        model.addAttribute("lesson",lesson);

        return "student/enroll_lesson_without";
    }

    @RequestMapping(value = "error",method = RequestMethod.GET)
    public String error(HttpServletRequest request,ModelMap model){
        String reason = request.getParameter("reason");
        model.addAttribute("reason",reason);
        return "student/error";
    }
}
