package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Teacher;
import com.example.studentattendancesystem.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RequestMapping("/teacher")
@Controller
public class TeacherController {

    @Autowired
    TeacherService teacherService;

    @RequestMapping("/toTeacherManage")
    public String toTeacherManage(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toTeacherManage");
        return "admin/admin-teacher-manage";
    }

    /*获取所有教师*/
    @RequestMapping("/allTeacher")
    @ResponseBody
    public List<Teacher> selectAllTeacher(){
        List<Teacher> teacherList =  teacherService.selectAll();
        return teacherList;
    }

    /*通过ID获取教师*/
    @RequestMapping("/selectTeacherById")
    @ResponseBody
    public Teacher selectTeacherById(Long teacherId){
        return teacherService.selectByPrimaryKey(teacherId);
    }



    /*通过ID获取教师*/
    @RequestMapping("/editTeacher")
    @ResponseBody
    public Integer editTeacher(Long teacherId,String name,Long account){
        Teacher teacher = new Teacher();
        teacher.setId(teacherId);
        teacher.setAccount(account);
        teacher.setName(name);
        return teacherService.updateByPrimaryKeySelective(teacher);
    }

    /*通过ID删除教师*/
    @RequestMapping("/deleteTeacher")
    @ResponseBody
    public Integer deleteTeacher(Long teacherId){
        return teacherService.deleteByPrimaryKey(teacherId);
    }

}
