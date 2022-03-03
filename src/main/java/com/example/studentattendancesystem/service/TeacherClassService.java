package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.TeacherClassMapper;
import com.example.studentattendancesystem.model.TeacherClass;
@Service
public class TeacherClassService{

    @Resource
    private TeacherClassMapper teacherClassMapper;

    
    public int insert(TeacherClass record) {
        return teacherClassMapper.insert(record);
    }

    
    public int insertSelective(TeacherClass record) {
        return teacherClassMapper.insertSelective(record);
    }

}
