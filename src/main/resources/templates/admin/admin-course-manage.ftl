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
                        <select id="departmentSelect" lay-filter="departmentSelect">
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
                        <select id="majorSelect" lay-filter="majorSelect">
                            <#--<option value="">请选择一个学院</option>-->
                        </select>
                    </div>
                </div>
                <div class="layui-input-inline">
                    <label class="layui-form-label">班级</label>
                    <div class="layui-input-block">
                        <select id="classSelect" lay-filter="classSelect">
                            <#--<option value="">请选择一个专业</option>-->
                        </select>
                    </div>
                </div>

                <button class="layui-btn js-search" data-type="reload"><i class="layui-icon">&#xe615;</i></button>
            </div>
        </div>

        <select id="majorSelectHidden" hidden>
            <#if majorList??>
                <#list majorList as ml>
                    <option value="${ml.id}" departmentIdHidden="${ml.departmentId}">"${ml.name}"</option>
                </#list>
            </#if>
        </select>

        <select id="classSelectHidden" hidden>
            <#if classList??>
                <#list classList as cl>
                    <option value="${cl.id}" majorIdHidden="${cl.majorId}">"${cl.name}"</option>
                </#list>
            </#if>
        </select>

        <#--<div class="layui-card-body schedule">
            <div class="table" id="classTable"></div>
        </div>-->

        <script>
            window.onload = function () {
                classCourse(1);
                var table = layui.table;
                var form = layui.form;

                layui.use(['form'], function(){
                    form = layui.form;
                    // 监听select切换事件
                    form.on('select(departmentSelect)',function(data){//根据所选学院显示专业
                        var majorList = "";
                        var departmentId = data.value;
                        $('option[departmentIdHidden="' + departmentId + '"]').each(function (i) {
                            majorList += this.outerHTML;
                        });
                        $("#majorSelect").html(majorList);
                        form.render('select');
                    });
                    form.on('select(majorSelect)', function(data){//根据所选专业显示班级
                        var classList = "";
                        var majorId = data.value;
                        $('option[majorIdHidden="' + majorId + '"]').each(function (i) {
                            classList += this.outerHTML;
                        });
                        $("#classSelect").html(classList);
                        form.render('select');
                    });
                });

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