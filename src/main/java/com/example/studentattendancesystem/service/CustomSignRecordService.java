package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.model.CustomSignRecord;
import com.example.studentattendancesystem.mapper.CustomSignRecordMapper;
@Service
public class CustomSignRecordService{

    @Resource
    private CustomSignRecordMapper customSignRecordMapper;

    
    public int insert(CustomSignRecord record) {
        return customSignRecordMapper.insert(record);
    }

    
    public int insertSelective(CustomSignRecord record) {
        return customSignRecordMapper.insertSelective(record);
    }

}
