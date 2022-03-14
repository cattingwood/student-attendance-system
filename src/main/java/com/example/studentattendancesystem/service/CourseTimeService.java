package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.CourseTimeMapper;
import com.example.studentattendancesystem.model.CourseTime;

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

}

