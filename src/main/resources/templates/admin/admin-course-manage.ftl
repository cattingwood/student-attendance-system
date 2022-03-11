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
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-admin.ftl"/>

        <div class="layui-card-body" id="filter">
            <div class="layui-form layui-col-md12 x-so">
                <div class="layui-input-inline">
                    <select id="department" lay-filter="department">
                        <option value="0">请选择学院</option>
                        <#if companys??>
                            <#list companys as com>
                                <option value="${com.appId}">${com.nickName!''}</option>
                            </#list>
                        </#if>
                    </select>
                </div>

                <div class="layui-input-inline">
                    <label class="layui-form-label">学院</label>
                    <div class="layui-input-block">
                        <select id="department" name="department">
                            <option value="2">计信学院</option>
                            <option value="1">工程学院</option>
                            <option value="0">医学院</option>
                        </select>
                    </div>
                </div>
                <div class="layui-input-inline" style="margin-left: 10px;">
                    <label class="layui-form-label">号码</label>
                    <div class="layui-input-block">
                        <input type="text" name="number" id="number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-input-inline" style="margin-left: 10px;">
                    <label class="layui-form-label">openId</label>
                    <div class="layui-input-block">
                        <input type="text" name="openId" id="openId" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <button class="layui-btn js-search" data-type="reload"><i class="layui-icon">&#xe615;</i></button>
            </div>
        </div>


        <div class="layui-card-body schedule">
            <div class="table" id="classTable"></div>
        </div>

        <script>
            window.onload = function () {
                classCourse(1);
                var table = layui.table;

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


            /*根据周数查找课程并显示*/
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
                        var timeTableHtml = "";
                        for (var i = 0; i < 5; i++) {
                            timeTableHtml += "<div class=\"table layui-col-md2\">" +
                                "            <div class=\"layui-row grid\">";

                            timeTableHtml += "<div class=\"layui-col-md12\">\n" +
                                "                    <div class=\"grid2 layui-bg-green\">\n" +
                                "                        星期" + i + "\n" +
                                "                    </div>\n" +
                                "                </div>";
                            for (var j = 1; j <= 8; j++) {
                                var course = courseList[i /*+ "-" + j*/];
                                if (course != null) {
                                    timeTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\">" +
                                        course.name +
                                        "                    </div>" +
                                        "                </div>";
                                } else {
                                    timeTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\">" +
                                        "无" +
                                        "                    </div>" +
                                        "                </div>";
                                }
                            }
                            timeTableHtml += "</div>" +
                                "        </div>";

                        }
                        $("#timeTable").html(timeTableHtml);
                        $(".course").css("border-width", "1px");
                        $(".course").css("border-style", "solid");
                        $(".course").css("border-color", "#e2e2e2");
                    }
                })
            }

        </script>
    </body>
</html>