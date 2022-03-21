package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Admin;
import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.model.Teacher;
import com.example.studentattendancesystem.service.AdminService;
import com.example.studentattendancesystem.service.StudentService;
import com.example.studentattendancesystem.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequestMapping("/login")
@Controller
public class LoginController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private AdminService adminService;

    @RequestMapping("/toLogin")
    public String toLogin(){
        return "login";
    }

    @RequestMapping("/toMainPage")
    public String toMainPage(HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student != null){
            return "redirect:/sign/toSign";
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        if(teacher != null){
            return "redirect:/course/toTeacherCourse";
        }
        Admin admin = (Admin) session.getAttribute("admin");
        if(admin != null){
            return "redirect:/course/toCourseManage";/*redirect直接跳转到另一个函数*/
        }
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
        HttpSession session = request.getSession();
        session.removeAttribute("student");//清空sesion防止登录串号
        session.removeAttribute("teacher");
        session.removeAttribute("admin");
        if(type.equals("学生")){
            Student student =  studentService.selectByAccount(Long.parseLong(account));
            if(student == null){
                return false;
            }else if(student.getPassword().equals(password)){
                session.setAttribute("student",student);
                return true;
            }
        }else if(type.equals("老师")){
            Teacher teacher =  teacherService.selectByAccount(Long.parseLong(account));
            if(teacher == null){
                return false;
            }else if(teacher.getPassword().equals(password)){
                session.setAttribute("teacher",teacher);
                return true;
            }
        }else if(type.equals("管理员")){
            Admin admin =  adminService.selectByAccount(Long.parseLong(account));
            if(admin == null){
                return false;
            }else if(admin.getPassword().equals(password)){
                session.setAttribute("admin",admin);
                return true;
            }
        }
        return false;
    }



}
