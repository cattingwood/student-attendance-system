<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="initial-scale=0.7,user-scalable=no"/>
        <title>学生请假记录</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/signPhone.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-teacher-phone.ftl"/>

        <div class="layui-card-body" id="sign">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    学生请假记录
                </div>
            </form>
        </div>

        <div class="layui-card-body" id="sign2">
            <div class="layui-form">
                <table class="layui-table">
                    <colgroup>
                        <col width="150">
                        <col width="200">
                        <col width="100">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>请假时间</th>
                        <th>学生名</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if (studentSignRecords)?? &&((studentSignRecords)?size>0)>
                        <#list studentSignRecords as sr>
                            <tr>
                                <td>第${sr.signWeek!''}周星期${sr.signDay!''}第${sr.sort!''}节</td>
                                <td>${sr.studentName!''}</td>
                                <td>
                                    <#if sr.status == 0>
                                        请假处理中
                                    <#elseif sr.status == 1>
                                        已同意假期申请
                                    <#elseif sr.status == -1>
                                        已拒绝假期申请
                                    </#if>
                                </td>
                            </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>


    </body>
    <script>
        window.onload = function () {
            var mo=function(e){e.preventDefault();};
            document.body.style.overflow='hidden';
            document.addEventListener("touchmove",mo,false);
        }
    </script>
</html>