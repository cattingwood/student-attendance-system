package com.example.studentattendancesystem.service;

import com.example.studentattendancesystem.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

import com.example.studentattendancesystem.mapper.StudentSignRecordMapper;

import java.util.ArrayList;
import java.util.List;

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

}
