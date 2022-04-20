package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.CourseTimeMapper;
import com.example.studentattendancesystem.model.CourseTime;

import java.util.List;

@Service
public class CourseTimeService {

    @Resource
    private CourseTimeMapper courseTimeMapper;


    public int insert(CourseTime record) {
        return courseTimeMapper.insert(record);
    }


    public int insertSelective(CourseTime record) {
        return courseTimeMapper.insertSelective(record);
    }

    public List<CourseTime> selectAll() {
        return courseTimeMapper.selectAll();
    }

    public List<CourseTime> getCourseTimeByAllId(Long courseId,Long teacherId,Long classId) {
        return courseTimeMapper.getCourseTimeByAllId(courseId,teacherId,classId);
    }

    public List<CourseTime> getCourseTimeByTime(int beginTime,int endTime,Long studentId) {
        return courseTimeMapper.getCourseTimeByTime(beginTime,endTime,studentId);
    }

    /*判断是否已有排课*/
    public boolean isCourseTimeRepeated(Long classId,Long teacherId,Integer day,Integer time,Integer week){
        List<CourseTime> courseTimeList =
                courseTimeMapper.getSameCourseTime(classId,teacherId,day,time,week);
        if(courseTimeList.size()>0){
            return true;
        }else {
            return false;
        }
    }

    /*添加排课*/
    public int addCourseTime(CourseTime courseTime){
        return courseTimeMapper.insert(courseTime);
    }

    /*删除排课*/
    public int deleteCourseTime(Long courseId, Long classId, Long teacherId){
        return courseTimeMapper.deleteCourseTime(courseId,classId,teacherId);
    }
}

