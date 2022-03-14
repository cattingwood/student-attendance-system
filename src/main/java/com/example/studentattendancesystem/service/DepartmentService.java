package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.DepartmentMapper;
import com.example.studentattendancesystem.model.Department;

import java.util.List;

@Service
public class DepartmentService{

    @Resource
    private DepartmentMapper departmentMapper;

    
    public int deleteByPrimaryKey(Integer id) {
        return departmentMapper.deleteByPrimaryKey(id);
    }

    
    public int insert(Department record) {
        return departmentMapper.insert(record);
    }

    
    public int insertSelective(Department record) {
        return departmentMapper.insertSelective(record);
    }

    
    public Department selectByPrimaryKey(Integer id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    
    public int updateByPrimaryKeySelective(Department record) {
        return departmentMapper.updateByPrimaryKeySelective(record);
    }

    
    public int updateByPrimaryKey(Department record) {
        return departmentMapper.updateByPrimaryKey(record);
    }

    public List<Department> selectAll() {return departmentMapper.selectAll();}
}
