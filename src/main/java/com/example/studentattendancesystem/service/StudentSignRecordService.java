package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.model.StudentSignRecord;
import com.example.studentattendancesystem.mapper.StudentSignRecordMapper;
@Service
public class StudentSignRecordService{

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

}
