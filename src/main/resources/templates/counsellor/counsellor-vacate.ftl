<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>请假处理</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/sign.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-counsellor.ftl"/>

        <div class="layui-card-body" id="sign">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    学生请假处理
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
                        <th>开始日期</th>
                        <th>结束日期</th>
                        <th>学生名</th>
                        <th>操作</th>
                        <th>申请时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if (vacateRecords)?? &&((vacateRecords)?size>0)>
                        <#list vacateRecords as vr>
                            <tr>
                                <td>第${vr.beginWeek!''}周星期${vr.beginDay!''}第${vr.beginTime!''}节</td>
                                <td>第${vr.endWeek!''}周星期${vr.endDay!''}第${vr.endTime!''}节</td>
                                <td>123</td>
                                <td>
                                    <#if vr.status == 0>
                                        <button class='layui-btn layui-btn-sm layui-btn-normal' onclick="vacate(${vr.id!''},1)">同意请假</button>
                                        <button class='layui-btn layui-btn-sm layui-btn-normal' onclick="vacate(${vr.id!''},2)">拒绝请假</button>
                                    <#elseif vr.status == 1>
                                        已同意假期申请
                                    <#elseif vr.status == -1>
                                        已拒绝假期申请
                                    </#if>
                                </td>
                                <td>${(vr.createTime?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
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


            function vacate(id,type) {
                $.ajax({
                    type:"post",
                    url:"/sign/VacateDeal",
                    data:{
                        "vacateId":id,
                        "status":type
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