package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.TeacherMapper;
import com.example.studentattendancesystem.model.Teacher;
@Service
public class TeacherService{

    @Resource
    private TeacherMapper teacherMapper;

    
    public int deleteByPrimaryKey(Long id) {
        return teacherMapper.deleteByPrimaryKey(id);
    }

    
    public int insert(Teacher record) {
        return teacherMapper.insert(record);
    }

    
    public int insertSelective(Teacher record) {
        return teacherMapper.insertSelective(record);
    }

    
    public Teacher selectByPrimaryKey(Long id) {
        return teacherMapper.selectByPrimaryKey(id);
    }

    
    public int updateByPrimaryKeySelective(Teacher record) {
        return teacherMapper.updateByPrimaryKeySelective(record);
    }

    
    public int updateByPrimaryKey(Teacher record) {
        return teacherMapper.updateByPrimaryKey(record);
    }

}
