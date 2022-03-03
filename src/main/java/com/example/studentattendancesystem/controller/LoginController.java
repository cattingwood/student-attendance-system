package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequestMapping("/login")
@Controller
public class LoginController {

    @Autowired
    private StudentService studentService;

    @RequestMapping("/toLogin")
    public String toLogin(){
        return "login";
    }

    @RequestMapping("/loginPhone")
    public String loginPhone(){
        return "login-phone";
    }

    /*登录*/
    @RequestMapping("/login")
    @ResponseBody
    public boolean login(String account, String password, String type,HttpServletRequest request){
        if(type.equals("学生")){
            Student student =  studentService.selectByAccount(account);
            if(student == null){
                return false;
            }else if(student.getPassword().equals(password)){
                HttpSession session = request.getSession();
                session.setAttribute("student",student);
                return true;
            }
        }
        return false;
    }



}
