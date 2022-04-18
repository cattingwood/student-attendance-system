package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.VacateRecordMapper;
import com.example.studentattendancesystem.model.VacateRecord;

import java.util.List;

@Service
public class VacateRecordService {

    @Resource
    private VacateRecordMapper vacateRecordMapper;


    public int deleteByPrimaryKey(Long id) {
        return vacateRecordMapper.deleteByPrimaryKey(id);
    }


    public int insert(VacateRecord record) {
        return vacateRecordMapper.insert(record);
    }


    public int insertSelective(VacateRecord record) {
        return vacateRecordMapper.insertSelective(record);
    }


    public VacateRecord selectByPrimaryKey(Long id) {
        return vacateRecordMapper.selectByPrimaryKey(id);
    }

    public List<VacateRecord> selectByStudentId(Long studentId) {
        return vacateRecordMapper.selectByStudentId(studentId);
    }

    public int updateByPrimaryKeySelective(VacateRecord record) {
        return vacateRecordMapper.updateByPrimaryKeySelective(record);
    }


    public int updateByPrimaryKey(VacateRecord record) {
        return vacateRecordMapper.updateByPrimaryKey(record);
    }

}


