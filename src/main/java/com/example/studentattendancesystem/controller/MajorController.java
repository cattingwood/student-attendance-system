package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.service.DepartmentService;
import com.example.studentattendancesystem.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequestMapping("/major")
@Controller
public class MajorController {

    @Autowired
    MajorService majorService;

    @Autowired
    DepartmentService departmentService;

    /*前往学生考勤统计页面*/
    @RequestMapping("/toMajorManage")
    public String toMajorManage(Model model, HttpServletRequest request){
        List<Department> departmentList = departmentService.selectAll();
        model.addAttribute("departmentList", departmentList);
        model.addAttribute("menuFlag", "toMajorManage");
        return "admin/admin-major-manage";
    }

    /*查询所有专业*/
    @RequestMapping("/AllMajor")
    @ResponseBody
    public List<MajorDetail> AllMajor(HttpServletRequest request){
        List<Major> majorList = majorService.selectAll();
        List<MajorDetail> majorDetailList = new ArrayList<>();
        for(int i=0;i<majorList.size();i++){
            Major major = majorList.get(i);
            MajorDetail majorDetail = new MajorDetail();
            majorDetail.setId(major.getId());
            majorDetail.setName(major.getName());
            majorDetail.setDepartmentId(major.getDepartmentId());
            majorDetail.setDepartmentName(departmentService.selectByPrimaryKey(major.getDepartmentId()).getName());

            majorDetailList.add(majorDetail);
        }
        return majorDetailList;
    }

    /*查询所有专业*/
    @RequestMapping("/getMajorByDepartment")
    @ResponseBody
    public List<MajorDetail> getMajorByDepartment(Integer id,HttpServletRequest request){
        List<Major> majorList = majorService.selectByDepartment(id);
        List<MajorDetail> majorDetailList = new ArrayList<>();
        for(int i=0;i<majorList.size();i++){
            Major major = majorList.get(i);
            MajorDetail majorDetail = new MajorDetail();
            majorDetail.setId(major.getId());
            majorDetail.setName(major.getName());
            majorDetail.setDepartmentId(major.getDepartmentId());
            majorDetail.setDepartmentName(departmentService.selectByPrimaryKey(major.getDepartmentId()).getName());

            majorDetailList.add(majorDetail);
        }
        return majorDetailList;
    }

}
