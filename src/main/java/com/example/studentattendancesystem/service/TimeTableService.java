package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.TimeTableMapper;
import com.example.studentattendancesystem.model.TimeTable;

@Service
public class TimeTableService {

    @Resource
    private TimeTableMapper timeTableMapper;


    public int insert(TimeTable record) {
        return timeTableMapper.insert(record);
    }


    public int insertSelective(TimeTable record) {
        return timeTableMapper.insertSelective(record);
    }

}

