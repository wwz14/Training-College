package edu.nju.trainCollege.tools;

import edu.nju.trainCollege.model.College;
import edu.nju.trainCollege.model.Student;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CollegeLoginInterceptor extends HandlerInterceptorAdapter {


    // 应许通过的URL

    private static final String[] IGNORE_URI = {"college/register"};

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = request.getRequestURI();
        boolean flag = false;
        for (String s : IGNORE_URI) {
            if (url.contains(s)) { // 如果是登陆页面的请求 则放过
                flag = true;
                break;
            }}

        if(!flag){
            College college = (College) request.getSession().getAttribute("college");
            if(college == null){ // 检查是否登陆，否则跳回登陆页面
                response.sendRedirect("/index");
                return false;

            }}

        return true;

    }
}
