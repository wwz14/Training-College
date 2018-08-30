package edu.nju.trainCollege.controller;

import edu.nju.trainCollege.model.*;
import edu.nju.trainCollege.service.CollegeService;
import edu.nju.trainCollege.service.StudentService;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@SessionAttributes({"student","college"})
public class MainController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private CollegeService collegeService;

    @RequestMapping(value = "index")
    public String index(ModelMap model){
        model.addAttribute("error","<br>");
        return "index";
    }

    @RequestMapping(value = "print_lesson",method = RequestMethod.GET)
    public String printLesson(HttpServletRequest request,ModelMap model){
        if(request.getParameter("lid")==null){
            return "redirect:/index";
        }
        int lid = Integer.parseInt(request.getParameter("lid"));
        Lesson lesson = studentService.getLessonByLid(lid);
        model.addAttribute("college",studentService.getCollegeById(lesson.getCid()));
        model.addAttribute("lesson",lesson);
        model.addAttribute("classList",collegeService.getClassesByLid(lid));
        model.addAttribute("command","print");
        return "/lesson_print";
    }

    @RequestMapping(value = "download_lesson",method = RequestMethod.GET)
    public String downloadLesson(HttpServletRequest request,ModelMap model){
        if(request.getParameter("lid")==null){
            return "redirect:/index";
        }
        int lid = Integer.parseInt(request.getParameter("lid"));
        Lesson lesson = studentService.getLessonByLid(lid);
        model.addAttribute("college",studentService.getCollegeById(lesson.getCid()));
        model.addAttribute("lesson",lesson);
        model.addAttribute("classList",collegeService.getClassesByLid(lid));
        model.addAttribute("command","download");
        return "/lesson_print";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, ModelMap model){
//        学员登陆
        if(Integer.parseInt(request.getParameter("type"))==0){
            String email = request.getParameter("id");
            String password = request.getParameter("password");
            Student student = studentService.login(email,password);
            if(student!=null){
                if(student.getState()!=1){
                    model.addAttribute("error"," * 该账号未通过邮件认证或已失效");
                    return "index";
                }else{
//                    因为注解，该属性直接添加到session中
                    model.addAttribute("student",student);
                    return "redirect:/student/homepage";
                }

            }else{
                model.addAttribute("error"," * 用户名或密码不正确");
                return "/index";
            }
        }
//        机构登陆
        else {
            String id = request.getParameter("id");
            String password = request.getParameter("password");
            if(id.length()<7){
                model.addAttribute("error","编码长度至少7位");
                return "/index";
            }
            College college = collegeService.login(id,password);
            if(college==null){
                model.addAttribute("error","编号密码错误");
                return "/index";
            }else{
                switch (college.getState()){
                    case 0:
                        model.addAttribute("error","该账号审查中，暂不能登陆");
                        return "/index";
                    case 1:
                        model.addAttribute("college",college);
                        return "redirect:/college/homepage";
                    case 2:
                        model.addAttribute("error","该账号已查封");
                        return "/index";
                    case 3:
                        model.addAttribute("error","该账号已注销，请重新注册");
                        return "/index";
                }
            }
        }
        return "/index";
    }

    @RequestMapping(value = "student/register", method = RequestMethod.GET)
    public String studentRegister(){
        return "student/register";
    }

    @RequestMapping(value = "student/register", method = RequestMethod.POST)
    public String addStudent(HttpServletRequest request, ModelMap model){
        String password = request.getParameter("password1");
        if(!password.equals(request.getParameter("password2"))){
            model.addAttribute("error","密码不一致");
            return "student/register";
        }
        Student student = new Student();
        student.setUsername(request.getParameter("username"));
        student.setEmail(request.getParameter("email"));
        student.setPassword(password);
        student.setState(1);

        if(!studentService.register(student)){
            model.addAttribute("error","邮箱已被注册");
        }else{
            model.addAttribute("error","注册成功，验证邮件已发送至邮箱，请验证后登陆");
        }
        return "student/register";
    }

    @RequestMapping(value = "college/register", method = RequestMethod.GET)
    public String collegeRegister(){
        return "college/register";
    }

    @RequestMapping(value = "college/register", method = RequestMethod.POST)
    public String addCollege(HttpServletRequest request, ModelMap model){
        String password = request.getParameter("password1");
        if(!password.equals(request.getParameter("password2"))){
            model.addAttribute("error","密码不一致");
            return "college/register";
        }
        College college = new College();
        college.setName(request.getParameter("name"));
        college.setTeacher(request.getParameter("teacher"));
        college.setLocation(request.getParameter("location"));
        college.setOther(request.getParameter("other"));
        college.setPhone(request.getParameter("phone"));
        college.setPassword(password);


        String id = collegeService.register(college);
        if(id.length()<7){
            model.addAttribute("error","注册失败，请稍后再试");
        }else{
            model.addAttribute("error","注册成功，您的机构编码为:<b>"+id+"</b>，待管理员验证后方可用编码登陆。");
        }
        return "college/register";
    }

    @RequestMapping(value = "student/delete",method = RequestMethod.POST)
    @ResponseBody
    public void deleteStudent(HttpServletRequest request){
        Student student = (Student) request.getSession().getAttribute("student");
        student.setState(2);
        studentService.profileSave(student);
    }
    @RequestMapping(value = "student/activate", method = RequestMethod.GET)
    public String activateStudent(){
        return "student/activate";
    }

    @RequestMapping(value = "/student/mactivate", method = RequestMethod.POST)
    public String activateStudent(HttpServletRequest request, ModelMap model){
        String email = request.getParameter("email");//获取email
        String validateCode = request.getParameter("validateCode");//激活码
        try {
            studentService.processActivate(email , validateCode);//调用激活方法
            model.addAttribute("message","激活成功").addAttribute("title",":)");
        } catch (ServiceException e) {
            model.addAttribute("message",e.getMessage()).addAttribute("title",":(");
        }

        return "student/activate";
    }

    @RequestMapping(value = "/datadb/attendance_by_lpid_type",method = RequestMethod.POST)
    @ResponseBody
    public List<Attendance> getAttdByIdType(HttpServletRequest request){
        int lpid = Integer.parseInt(request.getParameter("lpid"));
        int type = Integer.parseInt(request.getParameter("type"));
        List<Attendance> attds = collegeService.getAttendanceByLpidType(lpid,type);
        return attds;
    }

    @RequestMapping(value = "/datadb/college_by_cid",method = RequestMethod.POST)
    @ResponseBody
    public College getCollegeById(HttpServletRequest request){
        int cid = Integer.parseInt(request.getParameter("cid"));
        College c = collegeService.getCollegeById(cid);
        c.setPassword(null);
        return c;
    }

    @RequestMapping(value = "/datadb/normal_student_by_id",method = RequestMethod.POST)
    @ResponseBody
    public NormalStudent getNMStudentById(HttpServletRequest request){
        return studentService.getStudentById(request.getParameter("id"));
    }

    @RequestMapping(value = "/datadb/lesson_by_lid",method = RequestMethod.POST)
    @ResponseBody
    public Lesson getLessonById(HttpServletRequest request){
        int lid = Integer.parseInt(request.getParameter("lid"));
        return collegeService.getLessonByLid(lid);
    }

    @RequestMapping(value = "/datadb/class_by_id",method = RequestMethod.POST)
    @ResponseBody
    public Classes getClassById(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        return collegeService.getClassesById(id);
    }

    @RequestMapping(value = "/datadb/classes_by_lid",method = RequestMethod.POST)
    @ResponseBody
    public List<Classes> getClassesByLid(HttpServletRequest request){
        int lid = Integer.parseInt(request.getParameter("lid"));
        return collegeService.getClassesByLid(lid);
    }

    @RequestMapping(value = "/datadb/progresses_by_classId_no",method = RequestMethod.POST)
    @ResponseBody
    public List<LessonProgress> getProgressByClassIdNo(HttpServletRequest request){
        int classId = Integer.parseInt(request.getParameter("classId"));
        int classNo = Integer.parseInt(request.getParameter("classNo"));
        return collegeService.getLessonProByClassIdNo(classId,classNo);
    }

    @RequestMapping(value = "/datadb/mydata/attendance_by_lpid_type",method = RequestMethod.POST)
    @ResponseBody
    public MyData getDataAttdByIdType(HttpServletRequest request){
        int lpid = Integer.parseInt(request.getParameter("lpid"));
        int type = Integer.parseInt(request.getParameter("type"));
        List<Attendance> attds = collegeService.getAttendanceByLpidType(lpid,type);
        return new MyData(attds);
    }

    @RequestMapping(value = "/datadb/mydata/classes_by_lid",method = RequestMethod.POST)
    @ResponseBody
    public MyData getDataClassesByLid(HttpServletRequest request){
        int lid = Integer.parseInt(request.getParameter("lid"));
        return new MyData(collegeService.getClassesByLid(lid));
    }

    @RequestMapping(value = "/datadb/mydata/progresses_by_classId_no",method = RequestMethod.POST)
    @ResponseBody
    public MyData getDataProgressByClassIdNo(HttpServletRequest request){
        int classId = Integer.parseInt(request.getParameter("classId"));
        int classNo = Integer.parseInt(request.getParameter("classNo"));
        return new MyData(collegeService.getLessonProByClassIdNo(classId,classNo));
    }

    @RequestMapping(value = "logout")
    public String logout(SessionStatus status){
        status.setComplete();
        return "redirect:/index";
    }
}
