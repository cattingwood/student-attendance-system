package com.example.studentattendancesystem.service;

import com.example.studentattendancesystem.mapper.CourseTimeMapper;
import com.example.studentattendancesystem.mapper.TimeTableMapper;
import com.example.studentattendancesystem.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

import com.example.studentattendancesystem.mapper.StudentSignRecordMapper;

import java.util.*;

@Service
public class StudentSignRecordService{

    @Autowired
    private StudentService studentService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private TeacherService teacherService;

    @Resource
    private StudentSignRecordMapper studentSignRecordMapper;

    @Resource
    private CourseTimeMapper courseTimeMapper;

    @Resource
    private TimeTableMapper timeTableMapper;
    
    public int deleteByPrimaryKey(Long id) {
        return studentSignRecordMapper.deleteByPrimaryKey(id);
    }

    
    public int insert(StudentSignRecord record) {
        return studentSignRecordMapper.insert(record);
    }

    
    public int insertSelective(StudentSignRecord record) {
        return studentSignRecordMapper.insertSelective(record);
    }

    
    public StudentSignRecord selectByPrimaryKey(Long id) {
        return studentSignRecordMapper.selectByPrimaryKey(id);
    }

    
    public int updateByPrimaryKeySelective(StudentSignRecord record) {
        return studentSignRecordMapper.updateByPrimaryKeySelective(record);
    }

    
    public int updateByPrimaryKey(StudentSignRecord record) {
        return studentSignRecordMapper.updateByPrimaryKey(record);
    }

    public List<StudentSignRecord> selectByStudentAndDay(Long studentId, int week, int day) {
        return studentSignRecordMapper.selectByStudentAndDay(studentId,week,day);
    }

    public List<StudentSignRecordDetail> selectResignDetailByTeacherId(Long teacherId) {
        List<StudentSignRecord> records = studentSignRecordMapper.selectResignByTeacherId(teacherId);
        List<StudentSignRecordDetail> recordDetails = new ArrayList<>();
        for (int i=0;i<records.size();i++){
            recordDetails.add(getSignRecordDetail(records.get(i)));
        }
        return recordDetails;
    }

    public List<StudentSignRecordDetail> selectVacateDetailByStudentId(Long studentId) {
        List<StudentSignRecord> records = studentSignRecordMapper.selectVacateDetailByStudentId(studentId);
        List<StudentSignRecordDetail> recordDetails = new ArrayList<>();
        for (int i=0;i<records.size();i++){
            recordDetails.add(getSignRecordDetail(records.get(i)));
        }
        return recordDetails;
    }

    public Map<String,Object> selectSignDataByStudentId(Long studentId) {
        Map<String,Object> map = new HashMap<>();
        int signCount = studentSignRecordMapper.selectSignCountByStudentId(studentId);
        int resignCount = studentSignRecordMapper.selectResignCountByStudentId(studentId);
        Date today = new Date();
        TimeTable timeTable = timeTableMapper.selectOne();
        Date beginDate = timeTable.getTermBeginDay();//获取开学日
        int dateDiff = dataDiff(beginDate,today);
        int weekCount = dateDiff/7 +1;
        int dayCount = dateDiff%7;
        int allCount = courseTimeMapper.selectCourseCountByStudentId(studentId,weekCount,dayCount);
        map.put("sign",signCount);
        map.put("resign",resignCount);
        map.put("absenceCount",allCount-signCount-resignCount);
        map.put("allCount",allCount);
        return map;
    }

    public Map<String,Object> selectSignDataByCourseAndStudent(Long courseId,Long studentId) {
        Map<String,Object> map = new HashMap<>();
        int signCount = studentSignRecordMapper.selectSignCountByCourseAndStudent(courseId,studentId);
        int resignCount = studentSignRecordMapper.selectResignCountByCourseAndStudent(courseId,studentId);
        Date today = new Date();
        TimeTable timeTable = timeTableMapper.selectOne();
        Date beginDate = timeTable.getTermBeginDay();//获取开学日
        int dateDiff = dataDiff(beginDate,today);
        int weekCount = dateDiff/7 +1;
        int dayCount = dateDiff%7;
        int allCount = courseTimeMapper.selectCourseCountByCourseAndStudent(studentId,weekCount,dayCount,courseId);
        map.put("sign",signCount);
        map.put("resign",resignCount);
        map.put("absenceCount",allCount-signCount-resignCount);
        map.put("allCount",allCount);
        return map;
    }

    public StudentSignRecordDetail getSignRecordDetail(StudentSignRecord record){
        StudentSignRecordDetail recordDetail = new StudentSignRecordDetail();
        recordDetail.setId(record.getId());
        Student student = studentService.selectByPrimaryKey(record.getStudentId());
        recordDetail.setStudentId(student.getId());
        recordDetail.setStudentName(student.getName());
        Course course = courseService.selectCourseById(record.getCourseId());
        recordDetail.setCourseId(course.getId());
        recordDetail.setCourseName(course.getName());
        recordDetail.setSignTime(record.getSignTime());
        recordDetail.setType(record.getType());
        recordDetail.setSignWeek(record.getSignWeek());
        recordDetail.setSignDay(record.getSignDay());
        recordDetail.setStatus(record.getStatus());
        recordDetail.setSort(record.getSort());
        Teacher teacher = teacherService.selectByPrimaryKey(record.getTeacherId());
        recordDetail.setTeacherId(teacher.getId());
        recordDetail.setTeacherName(teacher.getName());

        return  recordDetail;
    }

    public int dataDiff(Date beginDate,Date endDate){
        Long starTime=beginDate.getTime();
        Long endTime=endDate.getTime();
        Long num=endTime-starTime;//时间戳相差的毫秒数
        int dayCount = (int) Math.ceil(num/24/60/60/1000) + 1;
        return dayCount;
    }

}
