package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.Major;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MajorMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Major record);

    int insertSelective(Major record);

    Major selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Major record);

    int updateByPrimaryKey(Major record);

    List<Major> selectAll();

    List<Major> selectByDepartment(Integer id);
}