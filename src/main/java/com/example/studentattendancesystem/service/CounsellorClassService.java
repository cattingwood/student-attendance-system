package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.model.CounsellorClass;
import com.example.studentattendancesystem.mapper.CounsellorClassMapper;
@Service
public class CounsellorClassService{

    @Resource
    private CounsellorClassMapper counsellorClassMapper;

    
    public int insert(CounsellorClass record) {
        return counsellorClassMapper.insert(record);
    }

    
    public int insertSelective(CounsellorClass record) {
        return counsellorClassMapper.insertSelective(record);
    }

}
