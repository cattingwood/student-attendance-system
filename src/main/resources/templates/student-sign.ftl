<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>学生签到</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">

    </head>
    <body>
        <#include "common/header.ftl"/>

        <div class="layui-btn-container">
            <button type="button" class="layui-btn layui-btn-lg" id="signBtn">签到</button>
        </div>

        <div class="layui-form">
            <table class="layui-table">
                <colgroup>
                    <col width="150">
                    <col width="150">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>节数</th>
                    <th>课程名</th>
                    <th>授课教师</th>
                    <th>格言</th>
                </tr>
                </thead>
                <tbody>
                <#if (courseDetailList)?? &&((courseDetailList)?size>0)>
                    <#list courseDetailList as rl>
                        <tr>
                            <td>${rl.courseSort}</td>
                            <td>${rl.name}</td>
                            <td>${rl.teacherName}</td>
                            <td>签到</td>
                        </tr>
                    </#list>
                </#if>
                </tbody>
            </table>
        </div>

        <script>
            window.onload = function () {
                $('#signBtn').click(function () {
                    $.ajax({
                        type:"post",
                        url:"/course/todayCourse",
                        dataType:"json",
                        success:function (data) {
                            console.log(data);
                            window.location.href="/course/toTimeTable";
                        }
                    })
                })
            }
        </script>
    </body>
</html>