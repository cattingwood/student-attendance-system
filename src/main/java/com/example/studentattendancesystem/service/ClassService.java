package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.ClassMapper;
import com.example.studentattendancesystem.model.Class;

import java.util.List;

@Service
public class ClassService {

    @Resource
    private ClassMapper classMapper;


    public int deleteByPrimaryKey(Long id) {
        return classMapper.deleteByPrimaryKey(id);
    }


    public int insert(Class record) {
        return classMapper.insert(record);
    }


    public int insertSelective(Class record) {
        return classMapper.insertSelective(record);
    }


    public Class selectByPrimaryKey(Long id) {
        return classMapper.selectByPrimaryKey(id);
    }


    public int updateByPrimaryKeySelective(Class record) {
        return classMapper.updateByPrimaryKeySelective(record);
    }


    public int updateByPrimaryKey(Class record) {
        return classMapper.updateByPrimaryKey(record);
    }

    public List<Class> selectAll() {
        return classMapper.selectAll();
    }

    public Class selectClassByStudentId(Long studentId) {
        return classMapper.selectClassByStudentId(studentId);
    }

    public Class selectClassById(Long classId){
        return classMapper.selectClassById(classId);
    }
}

