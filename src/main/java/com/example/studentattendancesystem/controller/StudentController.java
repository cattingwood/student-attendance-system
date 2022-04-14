package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.model.StudentDetail;
import com.example.studentattendancesystem.service.ClassService;
import com.example.studentattendancesystem.service.DepartmentService;
import com.example.studentattendancesystem.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/student")
@Controller
public class StudentController {

    @Autowired
    StudentService studentService;

    @Autowired
    ClassService classService;

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/toStudentManage")
    public String toStudentManage(Model model, HttpServletRequest request){
        model.addAttribute("menuFlag", "toStudentManage");
        return "admin/admin-student-manage";
    }

    /*获取所有学生*/
    @RequestMapping("/allStudent")
    @ResponseBody
    public List<StudentDetail> selectAllStudent(){
        List<Student> studentList =  studentService.selectAll();
        List<StudentDetail> studentDetailList = new ArrayList<>();
        for (int i=0;i<studentList.size();i++){
            studentDetailList.add(getStudentDetail(studentList.get(i)));
        }
        return studentDetailList;
    }

    public StudentDetail getStudentDetail(Student student){
        StudentDetail studentDetail = new StudentDetail();
        studentDetail.setId(student.getId());
        studentDetail.setAccount(student.getAccount());
        studentDetail.setName(student.getName());
        studentDetail.setPassword(student.getPassword());
        studentDetail.setDepartmentId(student.getDepartmentId());
        studentDetail.setDepartmentName(departmentService.selectByPrimaryKey(student.getDepartmentId()).getName());
        studentDetail.setClassId(student.getClassId());
        studentDetail.setClassName(classService.selectClassById(student.getClassId()).getName());
        studentDetail.setPeriod(student.getPeriod());
        studentDetail.setMajor(student.getMajor());

        return studentDetail;
    }
}
