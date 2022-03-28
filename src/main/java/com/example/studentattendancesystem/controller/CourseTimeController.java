package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.model.Class;
import com.example.studentattendancesystem.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/courseTime")
@Controller
public class CourseTimeController {

    @Autowired
    DepartmentService departmentService;

    @Autowired
    MajorService majorService;

    @Autowired
    ClassService classService;

    @Autowired
    CourseTimeService courseTimeService;

    @Autowired
    CourseService courseService;

    @Autowired
    TeacherService teacherService;

    @RequestMapping("/toCourseTimeManage")
    public String toCourseTimeManage(Model model, HttpServletRequest request){
        List<Department> departmentList = departmentService.selectAll();//获取所有学院资料
        List<Major> majorList = majorService.selectAll();
        List<Class> classList = classService.selectAll();
        List<Course> courseList = courseService.selectAll();
        List<Teacher> teacherList = teacherService.selectAll();
        model.addAttribute("departmentList", departmentList);
        model.addAttribute("majorList", majorList);
        model.addAttribute("classList", classList);
        model.addAttribute("courseList", courseList);
        model.addAttribute("teacherList", teacherList);
        model.addAttribute("menuFlag", "toCourseTimeManage");
        return "admin/admin-course-time-manage";
    }

    /*获取所有排课*/
    @RequestMapping("/AllCourseTime")
    @ResponseBody
    public List<CourseTimeDetail> selectAllCourse(){
        List<CourseTime> courseTimeList =  courseTimeService.selectAll();
        List<CourseTimeDetail> courseTimeDetailList  = new ArrayList<>();
        for(int i=0;i<courseTimeList.size();i++){
            courseTimeDetailList.add(getCourseTimeDetail(courseTimeList.get(i)));
        }
        return courseTimeDetailList;
    }

    public CourseTimeDetail getCourseTimeDetail(CourseTime courseTime){
        CourseTimeDetail courseTimeDetail = new CourseTimeDetail();
        courseTimeDetail.setCourseId(courseTime.getCourseId());
        String courseName = courseService.selectCourseById(courseTime.getCourseId()).getName();
        courseTimeDetail.setCourseName(courseName);
        courseTimeDetail.setCourseWeek(courseTime.getCourseWeek());
        courseTimeDetail.setCourseDay(courseTime.getCourseDay());
        courseTimeDetail.setCourseSort(courseTime.getCourseSort());
        courseTimeDetail.setTeacherId(courseTime.getTeacherId());
        courseTimeDetail.setClassId(courseTime.getClassId());
        String className = classService.selectClassById(courseTime.getClassId()).getName();
        courseTimeDetail.setClassName(className);
        courseTimeDetail.setTeacherId(courseTime.getTeacherId());
        String teacherName = teacherService.selectByPrimaryKey(courseTime.getTeacherId()).getName();
        courseTimeDetail.setTeacherName(teacherName);
        return courseTimeDetail;
    }

    @RequestMapping("/addCourseTime")
    @ResponseBody
    public Integer addCourseTime(Long courseId, Long classId, Long teacherId,
                                Integer day,String time,String week){
        String cut = ",";/*分隔符*/
        String[] timeStrArray = time.split(cut);/*字符串按照，分割*/
        String[] weekStrArray = week.split(cut);
        List<Integer> timeArray = new ArrayList<Integer>();
        List<Integer> weekArray = new ArrayList<Integer>();
        for (String timeStr : timeStrArray) {/*转化为数组*/
            timeArray.add(Integer.parseInt(timeStr));
        }
        for (String weekStr : weekStrArray) {
            weekArray.add(Integer.parseInt(weekStr));
        }
        for(int i=0;i<weekArray.size();i++){
            for(int j=0;j<timeArray.size();j++){
                boolean isCourseTimeRepeated =
                courseTimeService.isCourseTimeRepeated(classId,teacherId,day
                        ,timeArray.get(j),weekArray.get(i));
                if(isCourseTimeRepeated){
                    return -1;
                }
            }
        }
        for(int i=0;i<weekArray.size();i++){
            for(int j=0;j<timeArray.size();j++){
                CourseTime courseTime = new CourseTime();
                courseTime.setCourseId(courseId);
                courseTime.setClassId(classId);
                courseTime.setTeacherId(teacherId);
                courseTime.setCourseDay(day);
                courseTime.setCourseSort(timeArray.get(j));
                courseTime.setCourseWeek(weekArray.get(i));
                courseTimeService.addCourseTime(courseTime);
            }
        }
        return 1;
    }

    /*通过教师、班级、课程的ID获取排课*/
    @RequestMapping("/getCourseTimeByAllId")
    @ResponseBody
    public List<CourseTimeDetail> getCourseTimeByAllId(Long courseId,Long teacherId,Long classId){
        List<CourseTime> courseTimeList =  courseTimeService.getCourseTimeByAllId(courseId,teacherId,classId);
        List<CourseTimeDetail> courseTimeDetailList  = new ArrayList<>();
        for(int i=0;i<courseTimeList.size();i++){
            courseTimeDetailList.add(getCourseTimeDetail(courseTimeList.get(i)));
        }
        return courseTimeDetailList;
    }

    @RequestMapping("/editCourseTime")
    @ResponseBody
    public Integer editCourseTime(Long courseId, Long classId, Long teacherId,
                                 Integer day,String time,String week){
        deleteCourseTime(courseId,classId,teacherId);/*删除之前排课后重新添加*/
        return addCourseTime(courseId,classId,teacherId,day,time,week);
    }

    @RequestMapping("/deleteCourseTime")
    @ResponseBody
    public Integer deleteCourseTime(Long courseId, Long classId, Long teacherId){
        int result = courseTimeService.deleteCourseTime(courseId,classId,teacherId);
        System.out.println(result);
        return result;
    }
}
