package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.EvaluateMapper;
import com.example.studentattendancesystem.model.Evaluate;
@Service
public class EvaluateService{

    @Resource
    private EvaluateMapper evaluateMapper;

    
    public int deleteByPrimaryKey(Long id) {
        return evaluateMapper.deleteByPrimaryKey(id);
    }

    
    public int insert(Evaluate record) {
        return evaluateMapper.insert(record);
    }

    
    public int insertSelective(Evaluate record) {
        return evaluateMapper.insertSelective(record);
    }

    
    public Evaluate selectByPrimaryKey(Long id) {
        return evaluateMapper.selectByPrimaryKey(id);
    }

    
    public int updateByPrimaryKeySelective(Evaluate record) {
        return evaluateMapper.updateByPrimaryKeySelective(record);
    }

    
    public int updateByPrimaryKey(Evaluate record) {
        return evaluateMapper.updateByPrimaryKey(record);
    }

}
