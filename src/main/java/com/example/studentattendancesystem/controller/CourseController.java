package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Class;
import com.example.studentattendancesystem.model.Course;
import com.example.studentattendancesystem.model.CourseDetail;
import com.example.studentattendancesystem.model.Department;
import com.example.studentattendancesystem.model.Major;
import com.example.studentattendancesystem.service.ClassService;
import com.example.studentattendancesystem.service.CourseService;
import com.example.studentattendancesystem.service.DepartmentService;
import com.example.studentattendancesystem.service.MajorService;
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

    @Autowired
    DepartmentService departmentService;

    @Autowired
    MajorService majorService;

    @Autowired
    ClassService classService;

    @RequestMapping("/toTimeTable")
    public String toTimeTable(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toSchedule");
        return "student/student-schedule";
    }

    @RequestMapping("/toTimeTablePhone")
    public String toTimeTablePhone(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toSchedulePhone");
        return "student/student-schedule-phone";
    }

    @RequestMapping("/toTeacherCourse")
    public String toTeacherCourse(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toTeacherCourse");
        return "teacher/teacher-schedule";
    }

    @RequestMapping("/toTeacherCoursePhone")
    public String toTeacherCoursePhone(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toTeacherCoursePhone");
        return "teacher/teacher-schedule-phone";
    }

    @RequestMapping("/toCourseManage")
    public String toCourseManage(Model model, HttpServletRequest request){
        List<Department> departmentList = departmentService.selectAll();//????????????????????????
        List<Major> majorList = majorService.selectAll();
        List<Class> classList = classService.selectAll();
        model.addAttribute("departmentList", departmentList);
        model.addAttribute("majorList", majorList);
        model.addAttribute("classList", classList);
        model.addAttribute("menuFlag", "toCourseManage");
        return "admin/admin-course-manage";
    }

    /*????????????*/
    @RequestMapping("/addCourse")
    @ResponseBody
    public Integer addCourse(Course course){
        int result =  courseService.addCourse(course);
        return result;
    }

    /*????????????*/
    @RequestMapping("/deleteCourse")
    @ResponseBody
    public Integer deleteCourse(Long courseId){
        int result =  courseService.deleteCourse(courseId);
        return result;
    }

    /*????????????*/
    @RequestMapping("/selectCourseById")
    @ResponseBody
    public Course selectCourseById(Long courseId){
        Course course =  courseService.selectCourseById(courseId);
        return course;
    }

    /*????????????????????????*/
    @RequestMapping("/todayCourse")
    @ResponseBody
    public List<CourseDetail> selectTodayCourseByStudentId(Long studentId){
        List<Course> courseList =  courseService.selectStudentCourseById(studentId);//????????????????????????
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for(int i=0;i<courseList.size();i++){
            if(courseService.getTodayCourseTime(courseList.get(i)) != null){/*???????????????????????????*/
                courseDetailList.addAll(courseService.getTodayCourseTime(courseList.get(i)));
            }
        }
        //courseDetailList.sort(Comparator.comparing(CourseDetail::getCourseSort));//????????????????????????
        List<CourseDetail> SortCourseDetailList = new ArrayList<>();
        for(int i=0;i<10;i++){/*?????????*/
            boolean hasCourse = false;
            for(int j=0;j<courseDetailList.size();j++){
                if(courseDetailList.get(j).getCourseSort() == i+1){
                    SortCourseDetailList.add(i,courseDetailList.get(j));
                    hasCourse = true;
                }
            }
            if(!hasCourse){/*????????????*/
                SortCourseDetailList.add(i,null);
            }
            hasCourse = false;
        }
        return SortCourseDetailList;
    }

    /*???????????????????????????*/
    @RequestMapping("/studentWeekCourse")
    @ResponseBody
    public Map<String, Object> selectCourseByWeek(Long studentId,Integer week){
        List<Course> courseList =  courseService.selectStudentCourseById(studentId);//????????????????????????
        Class studentClass = classService.selectClassByStudentId(studentId);
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for(int i=0;i<courseList.size();i++){
            if(courseService.selectCourseByWeek(courseList.get(i),week,1,studentClass.getId()) != null){/*??????????????????????????????*/
                courseDetailList.addAll(courseService.selectCourseByWeek(courseList.get(i),week,1,studentClass.getId()));
            }
        }
        Map<String, Object> courseDetailListTree = new HashMap<String, Object>();
        for(int i=0;i<courseDetailList.size();i++){
            courseDetailListTree.put(courseDetailList.get(i).getCourseDay() + "-" + courseDetailList.get(i).getCourseSort()
                    , courseDetailList.get(i));
        }
        return courseDetailListTree;
    }

    /*???????????????????????????*/
    @RequestMapping("/teacherWeekCourse")
    @ResponseBody
    public Map<String, Object> selectCourseByTeacher(Long teacherId,Integer week){
        List<Course> courseList =  courseService.selectCourseByTeacher(teacherId);//????????????????????????
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for(int i=0;i<courseList.size();i++){
            if(courseService.selectCourseByWeek(courseList.get(i),week,2,teacherId) != null){/*??????????????????????????????*/
                courseDetailList.addAll(courseService.selectCourseByWeek(courseList.get(i),week,2,teacherId));
            }
        }
        Map<String, Object> courseDetailListTree = new HashMap<String, Object>();
        for(int i=0;i<courseDetailList.size();i++){
            courseDetailListTree.put(courseDetailList.get(i).getCourseDay() + "-" + courseDetailList.get(i).getCourseSort()
                    , courseDetailList.get(i));
        }
        return courseDetailListTree;
    }

    /*??????????????????*/
    @RequestMapping("/ClassCourse")
    @ResponseBody
    public List<Course> selectCourseByClass(Long classId){
        List<Course> courseList =  courseService.selectCourseByClass(classId);//????????????????????????

        return courseList;
    }

    /*??????????????????*/
    @RequestMapping("/MajorCourse")
    @ResponseBody
    public List<Course> selectCourseByMajor(Integer majorId){
        List<Course> courseList =  courseService.selectCourseByMajor(majorId);//????????????????????????
        return courseList;
    }

    /*??????????????????*/
    @RequestMapping("/DepartmentCourse")
    @ResponseBody
    public List<Course> selectCourseByDepartment(Integer departmentId){
        List<Course> courseList =  courseService.selectCourseByDepartment(departmentId);//????????????????????????
        return courseList;
    }

    /*??????????????????*/
    @RequestMapping("/AllCourse")
    @ResponseBody
    public List<Course> selectAllCourse(){
        List<Course> courseList =  courseService.selectAll();
        return courseList;
    }


}
