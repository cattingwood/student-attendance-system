package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.Evaluate;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EvaluateMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Evaluate record);

    int insertSelective(Evaluate record);

    Evaluate selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Evaluate record);

    int updateByPrimaryKey(Evaluate record);
}