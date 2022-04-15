package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.Class;
import com.example.studentattendancesystem.model.Department;
import com.example.studentattendancesystem.model.Major;
import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.model.StudentDetail;
import com.example.studentattendancesystem.service.ClassService;
import com.example.studentattendancesystem.service.DepartmentService;
import com.example.studentattendancesystem.service.MajorService;
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

    @Autowired
    MajorService majorService;

    @RequestMapping("/toStudentManage")
    public String toStudentManage(Model model, HttpServletRequest request){
        List<Department> departmentList = departmentService.selectAll();//获取所有学院资料
        List<Major> majorList = majorService.selectAll();
        List<Class> classList = classService.selectAll();
        model.addAttribute("departmentList", departmentList);
        model.addAttribute("majorList", majorList);
        model.addAttribute("classList", classList);
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

    /*通过ID获取学生*/
    @RequestMapping("/selectStudentById")
    @ResponseBody
    public StudentDetail selectStudentById(Long studentId){
        Student student =  studentService.selectByPrimaryKey(studentId);
        return getStudentDetail(student);
    }

    /*添加学生*/
    @RequestMapping("/addStudent")
    @ResponseBody
    public Integer addStudent(String name,Long account,String pwd,Long classId,Integer year){
        Student student = new Student();
        student.setName(name);
        student.setAccount(account);
        student.setPassword(pwd);
        student.setPeriod(year);
        Class class1 =  classService.selectClassById(classId);
        student.setDepartmentId(class1.getDepartmentId());
        student.setMajorId(class1.getMajorId());
        student.setClassId(classId);
        return studentService.insertSelective(student);
    }

    /*更新学生信息*/
    @RequestMapping("/editStudent")
    @ResponseBody
    public Integer editStudent(Long studentId,String name,Long account,String pwd,Long classId,Integer year){
        Student student = new Student();
        student.setId(studentId);
        student.setName(name);
        student.setAccount(account);
        student.setPassword(pwd);
        student.setPeriod(year);
        Class class1 =  classService.selectClassById(classId);
        student.setDepartmentId(class1.getDepartmentId());
        student.setMajorId(class1.getMajorId());
        student.setClassId(classId);
        return studentService.updateByPrimaryKeySelective(student);
    }

    /*通过ID删除取学生*/
    @RequestMapping("/deleteStudent")
    @ResponseBody
    public Integer deleteStudent(Long studentId){
        return studentService.deleteByPrimaryKey(studentId);
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
        studentDetail.setMajorId(student.getMajorId());
        studentDetail.setMajorName(majorService.selectByPrimaryKey(student.getMajorId()).getName());
        return studentDetail;
    }
}
