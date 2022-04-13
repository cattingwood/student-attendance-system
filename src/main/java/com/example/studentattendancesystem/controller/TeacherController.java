package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Teacher;
import com.example.studentattendancesystem.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RequestMapping("/teacher")
@Controller
public class TeacherController {

    @Autowired
    TeacherService teacherService;

    @RequestMapping("/toTeacherManage")
    public String toTeacherManage(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toTeacherManage");
        return "admin/admin-teacher-manage";
    }

    /*获取所有课表*/
    @RequestMapping("/AllCourse")
    @ResponseBody
    public List<Teacher> selectAllCourse(){
        List<Teacher> teacherList =  teacherService.selectAll();
        return teacherList;
    }

}
