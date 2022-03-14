<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>课表管理</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/schedule.css">
    </head>
    <div style="background-color: #F1F1F1;">
        <#include "../common/header-admin.ftl"/>

        <div class="layui-card-body" id="filter">
            <div class="layui-form layui-col-md12 x-so">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: auto;">学院</label>
                    <div class="layui-input-inline">
                        <select name="department">
                            <#if departmentList??>
                                <#list departmentList as dl>
                                    <option value="${dl.id}">${dl.name}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <div class="layui-input-inline">
                    <label class="layui-form-label">专业</label>
                    <div class="layui-input-inline">
                        <select name="major">
                            <option value="1">请先选择学院</option>
                        </select>
                    </div>
                </div>
                <div class="layui-input-inline">
                    <label class="layui-form-label">班级</label>
                    <div class="layui-input-block">
                        <select id="class" lay-filter="class">
                        </select>
                    </div>
                </div>

                <button class="layui-btn js-search" data-type="reload"><i class="layui-icon">&#xe615;</i></button>
            </div>
        </div>


        <#--<div class="layui-card-body schedule">
            <div class="table" id="classTable"></div>
        </div>-->

        <select id="major" hidden>
            <#if majorList??>
                <#list majorList as ml>
                    <option value="${ml.id}" name="${ml.name}" departmentId="${ml.departmentId}"></option>
                </#list>
            </#if>
        </select>

        <script>
            var majorList;
            var classList;
            window.onload = function () {
                classCourse(1);
                var table = layui.table;
                majorList = '${majorList}';
                classList = '${classList}';

                table.render({
                    elem: '#demo'
                    ,height: 315
                    ,url: '/class/ClassCourse'
                    ,page: true //开启分页
                    ,cols: [[ //表头
                        {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                        ,{field: 'className', title: '课程名'}
                        ,{field: 'teacherName', title: '授课教师'}
                    ]]
                });

                layui.use(['form', 'laydate', 'element', 'upload'], function(){
                    form = layui.form;
                    var laydate = layui.laydate;
                    var element = layui.element;
                    var upload = layui.upload;
                    // 监听机械select切换事件
                    form.on('select(department)', function(data){
                        loadClassSelectData('department',data.value);
                    });
                    form.on('select(major)', function(data){

                    });
                });

            }



            $(function () {
                layui.use('form',function () {
                    var form = layui.form;
                    form.on('submit(search)',function (data) {
                        var week = $('#week').val();
                        weekCourse(week);
                    })
                })
            })

            /*检测下拉框选择*/

            function loadClassSelectData(type,id){
                console.log(type);
                console.log(id);
            }

            /*根据班级查找课程并显示*/
            function classCourse(classId) {
                $.ajax({
                    type: "post",
                    url: "/course/ClassCourse",
                    dataType: "json",
                    data: {
                        classId: classId
                    },
                    success: function (data) {
                        var courseList = data;
                        var classTableHtml = "";
                        for (var i = 0; i < 5; i++) {
                            classTableHtml += "<div class=\"table layui-col-md2\">" +
                                "            <div class=\"layui-row grid\">";

                            classTableHtml += "<div class=\"layui-col-md12\">\n" +
                                "                    <div class=\"grid2 layui-bg-green\">\n" +
                                "                        星期" + i + "\n" +
                                "                    </div>\n" +
                                "                </div>";
                            for (var j = 1; j <= 8; j++) {
                                var course = courseList[i /*+ "-" + j*/];
                                if (course != null) {
                                    classTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\">" +
                                        course.name +
                                        "                    </div>" +
                                        "                </div>";
                                } else {
                                    classTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\">" +
                                        "无" +
                                        "                    </div>" +
                                        "                </div>";
                                }
                            }
                            classTableHtml += "</div>" +
                                "        </div>";

                        }
                        $("#classTable").html(classTableHtml);
                        $(".course").css("border-width", "1px");
                        $(".course").css("border-style", "solid");
                        $(".course").css("border-color", "#e2e2e2");
                    }
                })
            }

        </script>
    </body>
</html>