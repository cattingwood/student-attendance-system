package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Admin;
import com.example.studentattendancesystem.model.Counsellor;
import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.model.Teacher;
import com.example.studentattendancesystem.service.AdminService;
import com.example.studentattendancesystem.service.CounsellorService;
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
    private CounsellorService counsellorService;

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
        Counsellor counsellor = (Counsellor) session.getAttribute("counsellor");
        if(counsellor != null){
            return "redirect:/sign/toCounsellorVacate";
        }
        Admin admin = (Admin) session.getAttribute("admin");
        if(admin != null){
            return "redirect:/student/toStudentManage";/*redirect??????????????????????????????*/
        }
        return "login";
    }

    @RequestMapping("/toMainPagePhone")
    public String toMainPagePhone(HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student != null){
            return "redirect:/sign/toSignPhone";
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        if(teacher != null){
            return "redirect:/course/toTeacherCoursePhone";
        }
        return "login";
    }

    @RequestMapping("/loginPhone")
    public String loginPhone(){
        return "login-phone";
    }

    /*??????*/
    @RequestMapping("/login")
    @ResponseBody
    public boolean login(String account, String password, String type,HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("student");//??????sesion??????????????????
        session.removeAttribute("teacher");
        session.removeAttribute("counsellor");
        session.removeAttribute("admin");
        if(type.equals("??????")){
            Student student =  studentService.selectByAccount(Long.parseLong(account));
            if(student == null){
                return false;
            }else if(student.getPassword().equals(password)){
                session.setAttribute("student",student);
                return true;
            }
        }else if(type.equals("??????")){
            Teacher teacher =  teacherService.selectByAccount(Long.parseLong(account));
            if(teacher == null){
                return false;
            }else if(teacher.getPassword().equals(password)){
                session.setAttribute("teacher",teacher);
                return true;
            }
        }else if(type.equals("?????????")){
            Counsellor counsellor =  counsellorService.selectByAccount(Long.parseLong(account));
            if(counsellor == null){
                return false;
            }else if(counsellor.getPassword().equals(password)){
                session.setAttribute("counsellor",counsellor);
                return true;
            }
        }else if(type.equals("?????????")){
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
