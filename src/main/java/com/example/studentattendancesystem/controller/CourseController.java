package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Course;
import com.example.studentattendancesystem.model.CourseDetail;
import com.example.studentattendancesystem.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RequestMapping("/course")
@Controller
public class CourseController {

    @Autowired
    CourseService courseService;

    @RequestMapping("/toTimeTable")
    public String toLogin(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toSchedule");
        return "student/student-schedule";
    }

    @RequestMapping("/toCourseManage")
    public String toCourseManage(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toCourseManage");
        return "admin/admin-course-manage";
    }

    /*获取学生今日课表*/
    @RequestMapping("/todayCourse")
    @ResponseBody
    public List<CourseDetail> selectTodayCourseByStudentId(Long studentId){
        List<Course> courseList =  courseService.selectStudentCourseById(studentId);//获取学生所有课表
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for(int i=0;i<courseList.size();i++){
            if(courseService.getTodayCourseTime(courseList.get(i)) != null){/*若是今天则添加日程*/
                courseDetailList.addAll(courseService.getTodayCourseTime(courseList.get(i)));
            }
        }
        courseDetailList.sort(Comparator.comparing(CourseDetail::getCourseSort));//按照时间重新排序
        return courseDetailList;
    }

    /*获取学生所选周课表*/
    @RequestMapping("/weekCourse")
    @ResponseBody
    public Map<String, Object> selectCourseByWeek(Long studentId,Integer week){
        List<Course> courseList =  courseService.selectStudentCourseById(studentId);//获取学生所有课程
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for(int i=0;i<courseList.size();i++){
            if(courseService.selectStudentCourseByWeek(courseList.get(i),week) != null){/*若是所选周则添加日程*/
                courseDetailList.addAll(courseService.selectStudentCourseByWeek(courseList.get(i),week));
            }
        }
        Map<String, Object> courseDetailListTree = new HashMap<String, Object>();
        for(int i=0;i<courseDetailList.size();i++){
            courseDetailListTree.put(courseDetailList.get(i).getCourseDay() + "-" + courseDetailList.get(i).getCourseSort()
                    , courseDetailList.get(i));
        }
        return courseDetailListTree;
    }

    /*获取班级课表*/
    @RequestMapping("/ClassCourse")
    @ResponseBody
    public List<Course> selectCourseByClass(Long classId){
        List<Course> courseList =  courseService.selectCourseByClass(classId);//获取学生所有课程
        return courseList;
    }

    /*获取专业课表*/
    @RequestMapping("/MajorCourse")
    @ResponseBody
    public List<Course> selectCourseByMajor(Long classId){
        List<Course> courseList =  courseService.selectCourseByClass(classId);//获取专业所有课程
        return courseList;
    }

    /*获取学院课表*/
    @RequestMapping("/DepartmentCourse")
    @ResponseBody
    public List<Course> selectCourseByDepartment(Long classId){
        List<Course> courseList =  courseService.selectCourseByClass(classId);//获取学院所有课程
        return courseList;
    }
}
