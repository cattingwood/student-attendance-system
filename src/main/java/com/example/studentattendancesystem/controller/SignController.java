package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.mapper.TimeTableMapper;
import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.service.CourseService;
import com.example.studentattendancesystem.service.StudentSignRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/sign")
@Controller
public class SignController {

    @Autowired
    CourseController courseController;

    @Autowired
    StudentSignRecordService studentSignRecordService;

    @Autowired
    CourseService courseService;

    @Resource
    private TimeTableMapper timeTableMapper;

    /*前往学生签到页面*/
    @RequestMapping("/toSign")
    public String toLogin(Model model,HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student == null){
            return "login";
        }
        List<CourseDetail> courseDetailList =
                courseController.selectTodayCourseByStudentId(student.getId());//获取学生当日课程
        Date today = new Date();
        TimeTable timeTable = timeTableMapper.selectOne();
        Date beginDate = timeTable.getTermBeginDay();//获取开学日
        int dateDiff = dataDiff(beginDate,today);
        int weekCount = dateDiff/7 +1;
        int dayCount = dateDiff%7;
        List<StudentSignRecord> signList = studentSignRecordService.selectByStudentAndDay(student.getId(),weekCount,dayCount);
        int[] status = new int[10];
        for (int i=0;i<10;i++){
            status[i] = 0;
            for (int j=0;j<signList.size();j++){
                if(signList.get(j).getSort() == i+1 && signList.get(j).getType() == 1){/*签到成功*/
                    status[i] = 1;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == 2){/*补签申请中*/
                    status[i] = 2;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == 1){/*补签申请成功*/
                    status[i] = 3;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == -1){/*补签申请失败*/
                    status[i] = -1;
                }
            }
        }
        model.addAttribute("courseDetailList", courseDetailList);
        model.addAttribute("status", status);
        model.addAttribute("menuFlag", "toSign");
        model.addAttribute("week", weekCount);
        model.addAttribute("day", dayCount);
        return "student/student-sign";
    }

    /*前往学生签到页面*/
    @RequestMapping("/toSignPhone")
    public String toSignPhone(Model model,HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student == null){
            return "login";
        }
        List<CourseDetail> courseDetailList =
                courseController.selectTodayCourseByStudentId(student.getId());//获取学生当日课程
        Date today = new Date();
        TimeTable timeTable = timeTableMapper.selectOne();
        Date beginDate = timeTable.getTermBeginDay();//获取开学日
        int dateDiff = dataDiff(beginDate,today);
        int weekCount = dateDiff/7 +1;
        int dayCount = dateDiff%7;
        List<StudentSignRecord> signList = studentSignRecordService.selectByStudentAndDay(student.getId(),weekCount,dayCount);
        int[] status = new int[10];
        for (int i=0;i<10;i++){
            status[i] = 0;
            for (int j=0;j<signList.size();j++){
                if(signList.get(j).getSort() == i+1 && signList.get(j).getType() == 1){/*签到成功*/
                    status[i] = 1;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == 2){/*补签申请中*/
                    status[i] = 2;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == 1){/*补签申请成功*/
                    status[i] = 3;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == -1){/*补签申请失败*/
                    status[i] = -1;
                }
            }
        }
        model.addAttribute("courseDetailList", courseDetailList);
        model.addAttribute("status", status);
        model.addAttribute("menuFlag", "toSign");
        model.addAttribute("week", weekCount);
        model.addAttribute("day", dayCount);
        return "student/student-sign-phone";
    }

    /*前往学生考勤统计页面*/
    @RequestMapping("/toSignData")
    public String toSignData(Model model,HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student == null){
            return "login";
        }
        List<Course> courseList = courseService.selectStudentCourseById(student.getId());
        model.addAttribute("menuFlag", "toSignData");
        model.addAttribute("courseList", courseList);
        return "student/student-sign-data";
    }

    /*学生签到统计*/
    @RequestMapping("/SignData")
    @ResponseBody
    public Map<String, Object> SignData(HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        Map<String,Object> map2 = studentSignRecordService.selectSignDataByStudentId(student.getId());
        map.put("sign",map2.get("sign"));
        map.put("resign",map2.get("resign"));
        return map;
    }

    /*学生签到统计*/
    @RequestMapping("/getSignDataByCourse")
    @ResponseBody
    public Map<String, Object> getSignDataByCourse(Long courseId,HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        Map<String,Object> map2 = studentSignRecordService.selectSignDataByCourseAndStudent(courseId,student.getId());
        map.put("sign",map2.get("sign"));
        map.put("resign",map2.get("resign"));
        return map;
    }

    /*学生签到*/
    @RequestMapping("/studentSign")
    @ResponseBody
    public int studentSign(Long courseId,Long teacherId,Date signTime,int signWeek,int signDay,int sort,HttpServletRequest request){
        try{
            StudentSignRecord record = new StudentSignRecord();
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("student");
            record.setStudentId(student.getId());
            record.setCourseId(courseId);
            record.setSignTime(signTime);
            record.setType(1);/*1为普通签到*/
            record.setSignWeek(signWeek);
            record.setSignDay(signDay);
            record.setStatus(1);
            record.setSort(sort);
            record.setTeacherId(teacherId);
            studentSignRecordService.insert(record);
        }catch (Exception e){
            System.out.println("签到失败");
        }
        return 1;
    }

    /*学生补签*/
    @RequestMapping("/studentResign")
    @ResponseBody
    public int studentResign(Long courseId,Long teacherId,Date signTime,int signWeek,int signDay,int sort,HttpServletRequest request){
        try{
            StudentSignRecord record = new StudentSignRecord();
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("student");
            record.setStudentId(student.getId());
            record.setCourseId(courseId);
            record.setSignTime(signTime);
            record.setType(2);/*2为补签*/
            record.setSignWeek(signWeek);
            record.setSignDay(signDay);
            record.setStatus(2);
            record.setSort(sort);
            record.setTeacherId(teacherId);
            studentSignRecordService.insert(record);
        }catch (Exception e){
            System.out.println("补签申请失败");
        }
        return 1;
    }

    /*学生补签处理页面*/
    @RequestMapping("/toTeacherResign")
    public String toTeacherResign(Model model,HttpServletRequest request){
        try{
            HttpSession session = request.getSession();
            Teacher teacher = (Teacher) session.getAttribute("teacher");
            List<StudentSignRecordDetail> studentResignDetailRecord = studentSignRecordService.selectResignDetailByTeacherId(teacher.getId());
            model.addAttribute("resignRecord",studentResignDetailRecord);
            model.addAttribute("menuFlag","toTeacherResign");
        }catch (Exception e){
            System.out.println("教师补签查寻失败");
        }
        return "teacher/teacher-sign";
    }

    /*补签处理*/
    @RequestMapping("/ResignDeal")
    @ResponseBody
    public int ResignDeal(Long signId,int status,HttpServletRequest request){
        try{
            StudentSignRecord record = studentSignRecordService.selectByPrimaryKey(signId);
            if(status == 1){/*同意补签*/
                record.setStatus(1);
                studentSignRecordService.updateByPrimaryKey(record);
            }else if(status == 2){/*拒绝补签*/
                record.setStatus(-1);
                studentSignRecordService.updateByPrimaryKey(record);
            }
        }catch (Exception e){
            System.out.println("补签处理失败");
            return 0;
        }
        return 1;
    }

    public int dataDiff(Date beginDate,Date endDate){
        Long starTime=beginDate.getTime();
        Long endTime=endDate.getTime();
        Long num=endTime-starTime;//时间戳相差的毫秒数
        int dayCount = (int) Math.ceil(num/24/60/60/1000) + 1;
        return dayCount;
    }

}
