package edu.nju.trainCollege.controller;

import edu.nju.trainCollege.model.College;
import edu.nju.trainCollege.model.Manager;
import edu.nju.trainCollege.model.MyData;
import edu.nju.trainCollege.model.Student;
import edu.nju.trainCollege.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;

@Controller
@RequestMapping("college_manager/")
@SessionAttributes({"manager"})
public class ManagerController {

    @Autowired
    private ManagerService managerService;

    @RequestMapping(value = "all_students", method = RequestMethod.GET)
    public String all_student(){
        return "/manager/all_students";
    }

    @RequestMapping(value = "college_payment", method = RequestMethod.GET)
    public String collegePayment(){
        return "/manager/college_payment";
    }

    @RequestMapping(value = "college_pay", method = RequestMethod.POST)
    public String payCollege(HttpServletRequest request){
        double proportion = Double.parseDouble(request.getParameter("proportion"));
        managerService.collegePayment(proportion);
        return "redirect:/college_manager/homepage";
    }

    @RequestMapping(value = "website_payment", method = RequestMethod.GET)
    public String websitePayment(HttpServletRequest request,ModelMap model){
        int year;
        if(request.getParameter("year")!=null){
            year = Integer.parseInt(request.getParameter("year"));
        }else{
            year = Calendar.getInstance().get(Calendar.YEAR);
        }

        model.addAttribute("year",year);
        return "manager/website_payment";
    }

    @RequestMapping(value = "college_stats", method = RequestMethod.GET)
    public String collegeStatistic(HttpServletRequest request,ModelMap model){
        int year;
        if(request.getParameter("year")!=null){
            year = Integer.parseInt(request.getParameter("year"));
        }else{
            year = Calendar.getInstance().get(Calendar.YEAR);
        }

        int cid = Integer.parseInt(request.getParameter("cid"));

        model.addAttribute("year",year).addAttribute("cid",cid);
        return "manager/college_statistic";
    }

    @RequestMapping(value = "student_stats", method = RequestMethod.GET)
    public String studentStats(HttpServletRequest request,ModelMap model){
        return "manager/student_statistic";
    }

    @RequestMapping(value = "student_level_data", method = RequestMethod.POST)
    @ResponseBody
    public int[] getStudentLevelData(HttpServletRequest request){

        return managerService.getStudentLevelData();
    }

    @RequestMapping(value = "college_order_num_data", method = RequestMethod.POST)
    @ResponseBody
    public int[] getCollegeOrderNumByYear(HttpServletRequest request){
        int year = Integer.parseInt(request.getParameter("year"));
        int cid = Integer.parseInt(request.getParameter("cid"));

        return managerService.getCollegeOrderByYear(cid,year);
    }

    @RequestMapping(value = "payment_data", method = RequestMethod.POST)
    @ResponseBody
    public int[] getPaymentDataByYear(HttpServletRequest request){
        int year = Integer.parseInt(request.getParameter("year"));

        return managerService.getPaymentByYear(year);
    }

    @RequestMapping(value = "all_pay_college", method = RequestMethod.POST)
    @ResponseBody
    public String getAllPayCollege(){
        return managerService.getAllPayCollege();
    }

    @RequestMapping(value = "all_students", method = RequestMethod.POST)
    @ResponseBody
    public MyData getAllStudent(){
        MyData data = new MyData();
        data.setData(managerService.getAllStudents());
        return data;
    }

    @RequestMapping(value = "get_student", method = RequestMethod.POST)
    @ResponseBody
    public Student getStudentById(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        return managerService.getStudent(id);
    }

    @RequestMapping(value = "all_colleges", method = RequestMethod.GET)
    public String all_college(){
        return "/manager/all_colleges";
    }

    @RequestMapping(value = "all_colleges", method = RequestMethod.POST)
    @ResponseBody
    public MyData getAllColleges(){
        MyData data = new MyData();
        data.setData(managerService.getAllColleges());
        return data;
    }

    @RequestMapping(value = "unchecked_colleges", method = RequestMethod.GET)
    public String unchecked_college(){
        return "/manager/unchecked_colleges";
    }

    @RequestMapping(value = "unchecked_colleges", method = RequestMethod.POST)
    @ResponseBody
    public MyData getUncheckedColleges(){
        MyData data = new MyData();
        data.setData(managerService.getUncheckedColleges());
        return data;
    }

    @RequestMapping(value = "get_college", method = RequestMethod.POST)
    @ResponseBody
    public College getCollegeById(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        return managerService.getCollege(id);
    }

    @RequestMapping(value = "check_college", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkCollegeById(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        return managerService.changeCollegeState(id,1);
    }

    @RequestMapping(value = "dismiss_college", method = RequestMethod.POST)
    @ResponseBody
    public boolean dismissCollegeById(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        return managerService.changeCollegeState(id,2);
    }

    @RequestMapping("index")
    public String index(){
        return "/manager/index";
    }

    @RequestMapping("logout")
    public String logout(SessionStatus status){
        status.setComplete();
        return "redirect:/college_manager/index";
    }

    @RequestMapping("homepage")
    public String homepage(){
        return "/manager/homepage";
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, ModelMap model){
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        Manager manager = managerService.login(name,password);

        if(manager!=null){
//             因为注解，该属性直接添加到session中
            model.addAttribute("manager",manager);
            return "redirect:/college_manager/homepage";

        }else{
            model.addAttribute("error"," * 用户名或密码不正确");
            return "/manager/index";
        }
    }
}
