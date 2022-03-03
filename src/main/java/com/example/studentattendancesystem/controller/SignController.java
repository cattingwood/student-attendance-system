package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.CourseDetail;
import com.example.studentattendancesystem.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.List;

@RequestMapping("/sign")
@Controller
public class SignController {

    @Autowired
    CourseController courseController;

    @RequestMapping("/toSign")
    public String toLogin(Model model,HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student == null){
            return "login";
        }
        List<CourseDetail> courseDetailList =
                courseController.selectTodayCourseByStudentId(student.getId());//获取学生当日课程
        model.addAttribute("courseDetailList", courseDetailList);
        model.addAttribute("menuFlag", "toSign");
        return "student-sign";
    }



}
