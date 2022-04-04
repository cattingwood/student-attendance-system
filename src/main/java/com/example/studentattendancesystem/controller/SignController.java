package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.mapper.TimeTableMapper;
import com.example.studentattendancesystem.model.CourseDetail;
import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.model.StudentSignRecord;
import com.example.studentattendancesystem.model.TimeTable;
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

@RequestMapping("/sign")
@Controller
public class SignController {

    @Autowired
    CourseController courseController;

    @Autowired
    StudentSignRecordService studentSignRecordService;

    @Resource
    private TimeTableMapper timeTableMapper;

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
        int[] sort = new int[10];
        for (int i=0;i<10;i++){
            sort[i] = 0;
            for (int j=0;j<signList.size();j++){
                if(signList.get(j).getSort() == i+1 && signList.get(j).getType() == 1){/*签到成功*/
                    sort[i] = 1;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == 2){/*补签申请中*/
                    sort[i] = 2;
                }else if(signList.get(j).getSort() == i+1
                        && signList.get(j).getType() == 2 && signList.get(j).getStatus() == 1){/*补签申请成功*/
                    sort[i] = 3;
                }
            }
        }
        model.addAttribute("courseDetailList", courseDetailList);
        model.addAttribute("sort", sort);
        model.addAttribute("menuFlag", "toSign");
        model.addAttribute("week", weekCount);
        model.addAttribute("day", dayCount);
        return "student/student-sign";
    }

    @RequestMapping("/studentSign")
    @ResponseBody
    public int studentSign(Long courseId,Date signTime,int signWeek,int signDay,int sort,HttpServletRequest request){
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
            studentSignRecordService.insert(record);
        }catch (Exception e){
            System.out.println("签到失败");
        }
        return 1;
    }

    @RequestMapping("/studentResign")
    @ResponseBody
    public int studentResign(Long courseId,Date signTime,int signWeek,int signDay,int sort,HttpServletRequest request){
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
            studentSignRecordService.insert(record);
        }catch (Exception e){
            System.out.println("补签申请失败");
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
