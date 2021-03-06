package com.example.studentattendancesystem.controller;


import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.model.Class;
import com.example.studentattendancesystem.service.ClassService;
import com.example.studentattendancesystem.service.CustomSignRecordService;
import com.example.studentattendancesystem.service.CustomSignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@RequestMapping("/customSign")
@Controller
public class CustomSignController {

    @Autowired
    CustomSignService customSignService;

    @Autowired
    CustomSignRecordService customSignRecordService;

    @Autowired
    ClassService classService;

    @RequestMapping("/toTeacherCustomSign")
    public String toTeacherCustomSign(Model model, HttpServletRequest request){
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        List<Class> classList = classService.selectClassByTeacherId(teacher.getId());
        List<CustomSignDetail> customSignList = customSignService.selectByTeacher(teacher.getId());
        model.addAttribute("classList", classList);
        model.addAttribute("customSignList", customSignList);
        model.addAttribute("menuFlag", "toTeacherCustomSign");
        return "teacher/teacher-custom-sign";
    }

    @RequestMapping("/toCounsellorCustomSign")
    public String toCounsellorCustomSign(Model model, HttpServletRequest request){
        HttpSession session = request.getSession();
        Counsellor counsellor = (Counsellor) session.getAttribute("counsellor");
        List<Class> classList = classService.selectClassByCounsellorId(counsellor.getId());
        List<CustomSignDetail> customSignList = customSignService.selectByCounsellor(counsellor.getId());
        model.addAttribute("classList", classList);
        model.addAttribute("customSignList", customSignList);
        model.addAttribute("menuFlag", "toCounsellorCustomSign");
        return "counsellor/counsellor-custom-sign";
    }



    /*????????????*/
    @RequestMapping("/releaseSign")
    @ResponseBody
    public int releaseSign(CustomSign customSign, HttpServletRequest request){
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        Counsellor counsellor = (Counsellor) session.getAttribute("counsellor");
        if(teacher != null){
            customSign.setReleaseType(1);
            customSign.setReleaseId(teacher.getId());
        }
        else if(counsellor != null){
            customSign.setReleaseType(2);
            customSign.setReleaseId(counsellor.getId());
        }
        return customSignService.insert(customSign);
    }

    /*??????*/
    @RequestMapping("/studentSign")
    @ResponseBody
    public int studentSign(Long customSignId,Date signTime,HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        CustomSignRecord record = new CustomSignRecord();
        record.setStudentId(student.getId());
        record.setCustomSignId(customSignId);
        record.setSignTime(signTime);
        return customSignRecordService.insert(record);
    }

}
