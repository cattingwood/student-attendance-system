<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>考勤信息管理</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/schedule.css">
        <script src="https://eqcn.ajz.miesnfu.com/wp-content/plugins/wp-3d-pony/live2dw/lib/L2Dwidget.min.js"></script>
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-admin.ftl"/>
        <div class="layui-card-body" id="timeFilter">
            <div class="layui-form">

                <button class="layui-btn js-search" onclick="searchSignRecord()"><i class="layui-icon">&#xe615;</i></button>
            </div>
        </div>

        <div class="layui-card-body schedule">
            <div class="table" id="signDataTable"></div>
        </div>


        <script>
            function searchSignRecord() {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#signDataTable'
                        ,height: 450
                        ,url: '/sign/AllSignData' //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": '成功', //解析提示文本
                                "count": res.total, //解析数据长度
                                "data": res //解析数据列表
                            };
                        }
                        ,page: true //开启分页
                        ,cols: [[ //表头
                            {field: 'id', title: 'ID', width:100, sort: true, fixed: 'left'}
                            ,{field: 'studentName', title: '学生名', width:200}
                            ,{field: 'courseName', title: '课程名', width:100}
                            ,{field: 'signTime', title: '签到时间', width:100}
                            ,{field: 'type', title: '类型', width:100,
                                templet: function (res) {
                                    if(res.type == 1){
                                        return "签到";
                                    }else if(res.type == 2){
                                        return "补签";
                                    }else if(res.type == 3){
                                        return "请假";
                                    }
                                }}
                            ,{field: 'status', title: '状态', width:200}
                            ,{field: 'teacherName', title: '教师名', width:200}
                            , {field: '',width: 200, title: '操作',
                                templet: function (res) {
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourseTimeWindow('" + res.courseId + "','" + res.teacherId + "','" + res.classId + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>编辑</button> &nbsp;&nbsp;";
                                    ops +="<button class=\"layui-btn-normal layui-btn layui-btn-xs\" title=\"删除\" onclick=\"deleteCourse('" + res.courseName + "','" + res.teacherName + "','" + res.className + "','" + res.courseId + "','" + res.teacherId + "','" + res.classId + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe619;</i>删除</button>";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }
        </script>

    </body>
</html>