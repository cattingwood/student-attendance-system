package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.VacateRecord;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VacateRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(VacateRecord record);

    int insertSelective(VacateRecord record);

    VacateRecord selectByPrimaryKey(Long id);

    List<VacateRecord> selectByStudentId(Long studentId);

    int updateByPrimaryKeySelective(VacateRecord record);

    int updateByPrimaryKey(VacateRecord record);
}