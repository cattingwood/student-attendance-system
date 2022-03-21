package com.example.studentattendancesystem.service;

import com.example.studentattendancesystem.mapper.*;
import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.model.Class;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CourseService {


    @Resource
    private CourseMapper courseMapper;

    @Resource
    private ClassMapper classMapper;

    @Resource
    private CourseTimeMapper courseTimeMapper;

    @Resource
    private TimeTableMapper timeTableMapper;

    @Resource
    private TeacherMapper teacherMapper;


    public int addCourse(Course course) {
        return courseMapper.insertSelective(course);
    }

    public int deleteCourse(Long courseId) {
        return courseMapper.deleteCourseById(courseId);
    }

    public int insertSelective(Course record) {
        return courseMapper.insertSelective(record);
    }

    public List<Course> selectStudentCourseById(Long studentId) {
        List<Course> courseList = courseMapper.selectStudentCourseById(studentId);//选出学生所有课程
        return courseList;
    }

    public List<Course> selectCourseByTeacher(Long teacherId) {
        List<Course> courseList = courseMapper.selectCourseByTeacher(teacherId);//选出学生所有课程
        return courseList;
    }

    public List<Course> selectCourseByClass(Long classId) {
        List<Course> courseList = courseMapper.selectCourseByClass(classId);//选出学生所有课程
        return courseList;
    }

    public List<Course> selectCourseByMajor(Integer majorId) {
        List<Course> courseList = courseMapper.selectCourseByMajor(majorId);//选出学生所有课程
        return courseList;
    }

    public List<Course> selectCourseByDepartment(Integer departmentId) {
        List<Course> courseList = courseMapper.selectCourseByDepartment(departmentId);//选出学生所有课程
        return courseList;
    }

    public List<Course> selectAll() {
        return courseMapper.selectAll();//选出学生所有课程
    }

    public List<CourseDetail> selectCourseByWeek(Course course, Integer week,Integer type,Long id) {
        List<CourseTime> courseTime = courseTimeMapper.selectByCourseId(course.getId());//获取该课程的所有上课时间
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for (int i = 0; i < courseTime.size(); i++) {
            if (courseTime.get(i).getCourseWeek() == week) {/*若为所选周 添加到这周课程*/
                if(type == 1 && courseTime.get(i).getClassId() == id){
                    CourseDetail courseDetail = getCourseDetail(course, courseTime.get(i));
                    courseDetailList.add(courseDetail);
                }
                else if(type == 2 && courseTime.get(i).getTeacherId() == id){
                    CourseDetail courseDetail = getCourseDetail(course, courseTime.get(i));
                    courseDetailList.add(courseDetail);
                }
            }
        }
        return courseDetailList;
    }

    /*根据课程与课程时间获取课程细节*/
    public CourseDetail getCourseDetail(Course course, CourseTime courseTime) {
        CourseDetail courseDetail = new CourseDetail();
        courseDetail.setId(course.getId());
        courseDetail.setName(course.getName());
        courseDetail.setCourseWeek(courseTime.getCourseWeek());
        courseDetail.setCourseDay(courseTime.getCourseDay());
        courseDetail.setCourseSort(courseTime.getCourseSort());
        courseDetail.setClassId(courseTime.getClassId());
        Class aClass = classMapper.selectByPrimaryKey(courseTime.getClassId());
        courseDetail.setClassName(aClass.getName());
        return courseDetail;
    }

    public List<CourseDetail> getTodayCourseTime(Course course) {
        TimeTable timeTable = timeTableMapper.selectOne();
        Date beginDate = timeTable.getTermBeginDay();//获取开学日
        List<CourseTime> courseTime = courseTimeMapper.selectByCourseId(course.getId());//获取该课程的所有上课时间
        List<CourseDetail> courseDetailList = new ArrayList<>();
        for (int i = 0; i < courseTime.size(); i++) {
            int dayCount = (courseTime.get(i).getCourseWeek() - 1) * 7
                    + courseTime.get(i).getCourseDay() - 1;/*课程距离开学日多少天*/
            Date courseDate = addAndSubtractDaysByGetTime(beginDate, dayCount);/*计算课程为哪一天*/
            if (isSameDay(courseDate, new Date())) {/*若为今天 添加到今日课程*/
                CourseDetail courseDetail = getCourseDetail(course, courseTime.get(i));
                courseDetailList.add(courseDetail);
            }
        }
        return courseDetailList;
    }

    /*加减日期*/
    public static Date addAndSubtractDaysByGetTime(Date dateTime/*待处理的日期*/, int n/*加减天数*/) {

        //日期格式
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //System.out.println(dd.format(new Date(dateTime.getTime() + n * 24 * 60 * 60 * 1000L)));
        //注意这里一定要转换成Long类型，要不n超过25时会出现范围溢出，从而得不到想要的日期值
        return new Date(dateTime.getTime() + n * 24 * 60 * 60 * 1000L);
    }

    /*是否为同一天*/
    public boolean isSameDay(Date day1, Date day2) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String ds1 = sdf.format(day1);
        String ds2 = sdf.format(day2);
        if (ds1.equals(ds2)) {
            return true;
        } else {
            return false;
        }
    }

}


