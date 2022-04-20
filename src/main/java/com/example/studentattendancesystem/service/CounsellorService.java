package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.model.Counsellor;
import com.example.studentattendancesystem.mapper.CounsellorMapper;
@Service
public class CounsellorService{

    @Resource
    private CounsellorMapper counsellorMapper;

    
    public int deleteByPrimaryKey(Long id) {
        return counsellorMapper.deleteByPrimaryKey(id);
    }

    
    public int insert(Counsellor record) {
        return counsellorMapper.insert(record);
    }

    
    public int insertSelective(Counsellor record) {
        return counsellorMapper.insertSelective(record);
    }

    
    public Counsellor selectByPrimaryKey(Long id) {
        return counsellorMapper.selectByPrimaryKey(id);
    }

    
    public int updateByPrimaryKeySelective(Counsellor record) {
        return counsellorMapper.updateByPrimaryKeySelective(record);
    }

    
    public int updateByPrimaryKey(Counsellor record) {
        return counsellorMapper.updateByPrimaryKey(record);
    }

    public Counsellor selectByAccount(Long acount) {
        return counsellorMapper.selectByAccount(acount);
    }
}
