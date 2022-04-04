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
        <#include "../common/header-student.ftl"/>

        <div class="layui-card-body" id="sign">
            <form class="layui-form" action="">
                <div class="layui-form-item" id="day" week="${week}" day="${day}">
                    今天为第${week}周<br>第${day}天
                </div>
            </form>
            <div hidden>
                <#list  0..9 as i>
                    <div id="sort${i}">${sort[i]}</div>
                </#list>
            </div>
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
                        <th>节数</th>
                        <th>课程名</th>
                        <th>授课教师</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if (courseDetailList)?? &&((courseDetailList)?size>0)>
                        <#--<#list courseDetailList as rl>
                            <tr>
                                <td>${rl.courseSort}</td>
                                <td>${rl.name}</td>
                                <td>${rl.teacherName}</td>
                            </tr>
                        </#list>-->
                        <#list 0..9 as i>
                            <#if (courseDetailList[i])??>
                                <tr courseId="">
                                    <td>第${courseDetailList[i].courseSort!''}节</td>
                                    <td>${courseDetailList[i].name!''}</td>
                                    <td>${courseDetailList[i].teacherName!''}</td>
                                    <td id="course${i+1}operate"
                                        courseId="${courseDetailList[i].id!''}"
                                        sort="${courseDetailList[i].courseSort!''}"></td>
                                </tr>
                            <#else>
                                <tr>
                                    <td>第${i+1}节</td>
                                    <td>无课</td>
                                    <td>无</td>
                                    <td></td>
                                </tr>
                            </#if>
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

            $(document).ready(function () {
                var date = new Date();/*测试时间戳：12点：1648785600000*/
                var time = date.toString().split(" ")[4];
                var daySchedule = [];
                daySchedule.push("08:30:00");
                daySchedule.push("09:20:00");
                daySchedule.push("10:15:00");
                daySchedule.push("11:05:00");
                daySchedule.push("14:00:00");
                daySchedule.push("14:50:00");
                daySchedule.push("15:45:00");
                daySchedule.push("16:35:00");
                daySchedule.push("18:30:00");
                daySchedule.push("19:20:00");
                daySchedule.push("20:05:00");
                var opHTML = "";
                for(var i=0;i<10;i++){
                    opHTML = "";
                    if($("#sort" + i).html() == "1"){
                        opHTML = "<button class='layui-btn layui-btn-sm layui-btn-normal' disabled" +
                            " >已签到</button>";
                    }else if($("#sort" + i).html() == "2") {
                        opHTML = "<button class='layui-btn layui-btn-sm layui-btn-normal' disabled" +
                            " >已申请补签</button>";
                    }else if($("#sort" + i).html() == "3"){
                            opHTML = "<button class='layui-btn layui-btn-sm layui-btn-normal' disabled" +
                                " >已补签</button>";
                    }else if(!timeCompare(time,daySchedule[i])) {/*若时间小于第I节课*/
                        opHTML = "<button class='layui-btn layui-btn-sm layui-btn-normal'" +
                            " onclick=''>未开始</button>";
                    }else{
                        if(timeCompare(time,daySchedule[i]) && !timeCompare(time,daySchedule[i+1])){/*若时间在第I节课*/
                            opHTML = "<button class='layui-btn layui-btn-sm layui-btn-normal'" +
                                " onclick='sign(" + (i+1) + ")'>签到</button>";
                        }else if(timeCompare(time,daySchedule[i+1])){
                            opHTML = "<button class='layui-btn layui-btn-sm layui-btn-normal'" +
                                " onclick='resign(" + (i+1) + ")'>补签</button>";
                        }
                    }
                    $('#course' + (i+1) + 'operate').html(opHTML);
                    var form=layui.form;
                    form.render();
                }
            })

            function timeCompare(t1, t2) {
                var a = '01/10/2007 ' + t1;
                var b = '01/10/2007 ' + t2;
                var d = new Date(a);
                var e = new Date(b);
                if (d > e) {
                    return true;
                } else {
                    return false;
                }
            }

            /*签到*/
            function sign(i){
                var courseId = $('#course' + i + 'operate').attr("courseId");
                var sort = $('#course' + i + 'operate').attr("sort");
                var signTime = new Date();
                var signWeek = $("#day").attr("week");
                var signDay = $("#day").attr("day");
                $.ajax({
                    type:"post",
                    url:"/sign/studentSign",
                    data:{
                        "courseId": courseId,
                        "signTime": signTime,
                        "signWeek": signWeek,
                        "signDay": signDay,
                        "sort": sort
                    },
                    dataType:"json",
                    success:function (res) {
                        if(res == 1){
                            var layer = layui.layer;
                            layer.alert("签到成功！");
                        }
                    }
                })
            }

            /*补签*/
            function resign(i){
                var courseId = $('#course' + i + 'operate').attr("courseId");
                var sort = $('#course' + i + 'operate').attr("sort");
                var signTime = new Date();
                var signWeek = $("#day").attr("week");
                var signDay = $("#day").attr("day");
                $.ajax({
                    type:"post",
                    url:"/sign/studentResign",
                    data:{
                        "courseId": courseId,
                        "signTime": signTime,
                        "signWeek": signWeek,
                        "signDay": signDay,
                        "sort": sort
                    },
                    dataType:"json",
                    success:function (res) {
                        if(res == 1){
                            var layer = layui.layer;
                            layer.alert("申请补签成功！");
                        }
                    }
                })
            }

        </script>
    </body>
</html>