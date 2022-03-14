package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.MajorMapper;
import com.example.studentattendancesystem.model.Major;

import java.util.List;

@Service
public class MajorService {

    @Resource
    private MajorMapper majorMapper;


    public int deleteByPrimaryKey(Integer id) {
        return majorMapper.deleteByPrimaryKey(id);
    }


    public int insert(Major record) {
        return majorMapper.insert(record);
    }


    public int insertSelective(Major record) {
        return majorMapper.insertSelective(record);
    }


    public Major selectByPrimaryKey(Integer id) {
        return majorMapper.selectByPrimaryKey(id);
    }


    public int updateByPrimaryKeySelective(Major record) {
        return majorMapper.updateByPrimaryKeySelective(record);
    }


    public int updateByPrimaryKey(Major record) {
        return majorMapper.updateByPrimaryKey(record);
    }

    public List<Major> selectAll() {
        return majorMapper.selectAll();
    }
}

