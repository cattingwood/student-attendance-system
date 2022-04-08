<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>教师补签</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/sign.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-teacher.ftl"/>

        <div class="layui-card-body" id="sign">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    学生补签处理
                </div>
            </form>
        </div>

        <div class="layui-card-body" id="sign2">
            <div class="layui-form">
                <table class="layui-table">
                    <colgroup>
                        <col width="150">
                        <col width="200">
                        <col width="200">
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>课程名</th>
                        <th>学生名</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if (resignRecord)?? &&((resignRecord)?size>0)>
                        <#list resignRecord as rr>
                            <tr>
                                <td>第${rr.signWeek!''}周星期${rr.signDay!''}第${rr.sort!''}节</td>
                                <td>${rr.courseName!''}</td>
                                <td>${rr.studentName!''}</td>
                                <td>
                                    <#if rr.status == 2>
                                        <button class='layui-btn layui-btn-sm layui-btn-normal' onclick="resign(${rr.id!''},1)">同意补签</button>
                                        <button class='layui-btn layui-btn-sm layui-btn-normal' onclick="resign(${rr.id!''},2)">拒绝补签</button>
                                    <#elseif rr.status == 1>
                                        <button class='layui-btn layui-btn-sm layui-btn-normal'>已同意</button>
                                    <#elseif rr.status == -1>
                                        <button class='layui-btn layui-btn-sm layui-btn-normal'>已拒绝</button>
                                    </#if>
                                </td>
                            </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>



        <script>
            window.onload = function () {
            }

            function resign(signId,status) {
                $.ajax({
                    type:"post",
                    url:"/sign/ResignDeal",
                    data:{
                        "signId":signId,
                        "status":status
                    },
                    dataType:"json",
                    success:function (res) {
                        if(res == 1){
                            var layer = layui.layer;
                            layer.alert("处理成功！");
                        }
                    }
                })
            }
        </script>
    </body>
</html>