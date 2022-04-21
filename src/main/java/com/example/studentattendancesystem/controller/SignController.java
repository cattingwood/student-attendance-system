package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.mapper.TimeTableMapper;
import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.service.CourseService;
import com.example.studentattendancesystem.service.CourseTimeService;
import com.example.studentattendancesystem.service.StudentSignRecordService;
import com.example.studentattendancesystem.service.VacateRecordService;
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

    @Autowired
    CourseTimeService courseTimeService;

    @Autowired
    VacateRecordService vacateRecordService;

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
        model.addAttribute("menuFlag", "toSignPhone");
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

    /*前往管理员考勤统计页面*/
    @RequestMapping("/toAllSignData")
    public String toAllSignData(Model model,HttpServletRequest request){
        model.addAttribute("menuFlag", "toAllSignData");
        return "admin/admin-sign-data";
    }

    /*前往学生考勤统计页面*/
    @RequestMapping("/toSignDataPhone")
    public String toSignDataPhone(Model model,HttpServletRequest request){
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");
        if(student == null){
            return "login";
        }
        List<Course> courseList = courseService.selectStudentCourseById(student.getId());
        model.addAttribute("menuFlag", "toSignDataPhone");
        model.addAttribute("courseList", courseList);
        return "student/student-sign-data-phone";
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
        map.put("vacate",map2.get("vacate"));
        map.put("absenceCount",map2.get("absenceCount"));
        map.put("allCount",map2.get("allCount"));
        return map;
    }

    /*前往管理员考勤管理页面*/
    @RequestMapping("/toSignDataManage")
    public String toSignDataManage(Model model,HttpServletRequest request){
        model.addAttribute("menuFlag", "toSignDataManage");
        return "admin/admin-sign-data-manage";
    }

    /*学生签到记录管理*/
    @RequestMapping("/AllSignData")
    @ResponseBody
    public List<StudentSignRecordDetail> AllSignData(){
        return studentSignRecordService.selectAll();
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
        map.put("vacate",map2.get("vacate"));
        map.put("absenceCount",map2.get("absenceCount"));
        map.put("allCount",map2.get("allCount"));
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

    /*学生请假页面*/
    @RequestMapping("/toStudentVacate")
    public String toStudentVacate(Model model,HttpServletRequest request){
        try{
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("student");
            List<VacateRecord> vacateRecords = vacateRecordService.selectByStudentId(student.getId());
            model.addAttribute("vacateRecords",vacateRecords);
            model.addAttribute("menuFlag","toStudentVacate");
        }catch (Exception e){
            System.out.println("学生请假查寻失败");
        }
        return "student/student-vacate";
    }

    /*教师查看学生请假页面*/
    @RequestMapping("/toTeacherVacateCheck")
    public String toTeacherVacateCheck(Model model,HttpServletRequest request){
        try{
            HttpSession session = request.getSession();
            Teacher teacher = (Teacher) session.getAttribute("teacher");
            List<StudentSignRecordDetail> studentSignRecords =
                    studentSignRecordService.selectVacateDetailByTeacherId(teacher.getId());
            model.addAttribute("studentSignRecords",studentSignRecords);
            model.addAttribute("menuFlag","toTeacherVacateCheck");
        }catch (Exception e){
            System.out.println("学生请假查寻失败");
        }
        return "teacher/teacher-vacate-check";
    }

    /*申请请假*/
    @RequestMapping("/addVacate")
    @ResponseBody
    public int addVacate(Integer beginWeek,Integer beginDay,Integer beginTime,
                         Integer endWeek,Integer endDay,Integer endTime,HttpServletRequest request){
        try{
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("student");
            VacateRecord vacateRecord = new VacateRecord();
            vacateRecord.setStudentId(student.getId());
            vacateRecord.setBeginWeek(beginWeek);
            vacateRecord.setBeginDay(beginDay);
            vacateRecord.setBeginTime(beginTime);
            vacateRecord.setEndWeek(endWeek);
            vacateRecord.setEndDay(endDay);
            vacateRecord.setEndTime(endTime);
            vacateRecord.setStatus(0);/*1为成功-1为失败0为待确认*/
            return vacateRecordService.insertSelective(vacateRecord);
        }catch (Exception e){
            System.out.println("申请请假失败");
            return 0;
        }
    }

    /*辅导员批准请假页面*/
    @RequestMapping("/toCounsellorVacate")
    public String toCounsellorVacate(Model model,HttpServletRequest request){
        try{
            List<VacateRecord> vacateRecords = vacateRecordService.selectByCounsellorId(1L);
            model.addAttribute("vacateRecords",vacateRecords);
            model.addAttribute("menuFlag","toCounsellorVacate");
        }catch (Exception e){
            System.out.println("学生请假查寻失败");
        }
        return "counsellor/counsellor-vacate";
    }

    /*查询请假记录*/
    @RequestMapping("/selectVacateRecordByStudent")
    @ResponseBody
    public List<VacateRecord> selectVacateRecordByStudent(HttpServletRequest request){
        try{
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("student");
            return  vacateRecordService.selectByStudentId(student.getId());
        }catch (Exception e){
            System.out.println("学生请假查寻失败");
            return null;
        }
    }

    /*请假处理*/
    @RequestMapping("/VacateDeal")
    @ResponseBody
    public int VacateDeal(Long vacateId,int status,HttpServletRequest request){
        try{
            VacateRecord record = vacateRecordService.selectByPrimaryKey(vacateId);
            if(status == 1){/*同意请假*/
                record.setStatus(1);
                vacateRecordService.updateByPrimaryKey(record);
                int BeginWeek = record.getBeginWeek();
                int BeginDay = record.getBeginDay();
                int BeginTime = record.getBeginTime();
                int EndWeek = record.getEndWeek();
                int EndDay = record.getEndDay();
                int EndTime = record.getEndTime();
                int beginTime = BeginWeek*10000 + BeginDay*100 + BeginTime;
                int endTime = EndWeek*10000 + EndDay*100 + EndTime;
                Long studentId = record.getStudentId();
                List<CourseTime> courseTimeList =
                        courseTimeService.getCourseTimeByTime(beginTime,endTime,studentId);
                for(int i=0;i<courseTimeList.size();i++){
                    CourseTime courseTime = courseTimeList.get(i);
                    Date date = new Date();
                    int result =  studentVacate(studentId,courseTime.getCourseId(),courseTime.getTeacherId(),date,
                            courseTime.getCourseWeek(),courseTime.getCourseDay(),courseTime.getCourseSort());
                }
                return 1;
            }else if(status == 2){/*拒绝请假*/
                record.setStatus(-1);
                vacateRecordService.updateByPrimaryKey(record);
            }
        }catch (Exception e){
            System.out.println("补签处理失败");
            return 0;
        }
        return 1;
    }

    public int studentVacate(Long studentId,Long courseId,Long teacherId,Date signTime,int signWeek,int signDay,int sort){
        try{
            StudentSignRecord record = new StudentSignRecord();
            record.setStudentId(studentId);
            record.setCourseId(courseId);
            record.setSignTime(signTime);
            record.setType(3);/*3为请假*/
            record.setSignWeek(signWeek);
            record.setSignDay(signDay);
            record.setStatus(1);
            record.setSort(sort);
            record.setTeacherId(teacherId);
            studentSignRecordService.insert(record);
        }catch (Exception e){
            System.out.println("请假记录失败");
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

    /*学生补签处理页面*/
    @RequestMapping("/toTeacherResignPhone")
    public String toTeacherResignPhone(Model model,HttpServletRequest request){
        try{
            HttpSession session = request.getSession();
            Teacher teacher = (Teacher) session.getAttribute("teacher");
            List<StudentSignRecordDetail> studentResignDetailRecord = studentSignRecordService.selectResignDetailByTeacherId(teacher.getId());
            model.addAttribute("resignRecord",studentResignDetailRecord);
            model.addAttribute("menuFlag","toTeacherResignPhone");
        }catch (Exception e){
            System.out.println("教师补签查寻失败");
        }
        return "teacher/teacher-sign-phone";
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
