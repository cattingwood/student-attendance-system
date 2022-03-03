<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>学生签到</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/sign.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "common/header.ftl"/>

        <div class="layui-card-body" id="sign">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <a class="layui-btn layui-btn-primary"
                       lay-submit lay-filter="search" id="searchBtn">签到</a>
                </div>
            </form>
        </div>

        <div class="layui-card-body">
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
                        }
                    })
                })
            }
        </script>
    </body>
</html>