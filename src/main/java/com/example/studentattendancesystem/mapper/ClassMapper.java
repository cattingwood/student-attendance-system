package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.Class;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ClassMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Class record);

    int insertSelective(Class record);

    Class selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Class record);

    int updateByPrimaryKey(Class record);

    List<Class> selectAll();
}