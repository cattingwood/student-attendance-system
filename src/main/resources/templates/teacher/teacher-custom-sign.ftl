<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>自定义考勤</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/customSign.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-teacher.ftl"/>

        <div class="layui-card-body" id="timeFilter">
            <a class="layui-btn layui-btn-primary" onclick="releaseSignWindow()">发布考勤</a>
        </div>

        <div class="layui-card-body" id="sign2">
            <table class="layui-table" id="vacateRecord">
                <colgroup>
                    <col width="200">
                    <col width="200">
                    <col width="200">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>考勤名称</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>考勤班级</th>
                    <th>已签到人数</th>
                </tr>
                </thead>
                <tbody>
                <#if (customSignList)?? &&((customSignList)?size>0)>
                    <#list customSignList as sl>
                        <tr>
                            <td>${sl.signName!''}</td>
                            <td>${sl.beginTime?string("yyyy-MM-dd HH-mm-ss")!''}</td>
                            <td>${sl.endTime?string("yyyy-MM-dd HH-mm-ss")!''}</td>
                            <td>${sl.className!''}</td>
                            <td>${sl.signCount!''}</td>
                        </tr>
                    </#list>
                </#if>
                </tbody>
            </table>
        </div>

        <div id="releaseSign" hidden>
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    <div class="layui-form-item"> <label class="layui-form-label">考勤名称</label>
                        <div class="layui-input-block">
                            <input type="text" id="addSignName" lay-verify="addSignName" autocomplete="off" placeholder="请输入考勤名称" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline"> <label class="layui-form-label">考勤时间范围</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" id="timeRange" placeholder=" - ">
                        </div>
                    </div>
                    <div class="layui-inline"> <label class="layui-form-label">考勤班级</label>
                        <div class="layui-form layui-input-block">
                            <select id="signClass" lay-filter="">
                                <#if classList??>
                                    <#list classList as cl>
                                        <option value="${cl.id}">${cl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="layui-btn"  onclick="releaseSign()">发布考勤</div>
                </form>
            </div>
        </div>

        <script>

            $(document).ready(function () {
                layui.laydate.render({
                    elem: '#timeRange'
                    ,type: 'datetime'
                    ,range: true
                });
            })

            function releaseSignWindow() {
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '新增自定义考勤',
                    area: ['40%', '50%'],//弹框大小
                    content: $("#releaseSign"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                    },
                    end: function () {
                        $("#releaseSign").hide();
                    }
                })
            }

            function releaseSign() {
                var name =  parent.$("#addSignName").val();
                if(name == ""){
                    layer.alert("请输入考勤名! ");
                    return false;

                }
                var time =  parent.$("#timeRange").val();
                if(getByteLen(time) < 15){
                    layer.alert("请选择开始与结束时间");
                    return false;
                }
                var beginTime = new Date(time.slice(0,19));
                var endTime = new Date(time.slice(22));
                var signClassId =  parent.$("#signClass").val();
                $.post("/customSign/releaseSign", {
                    "signName": name,
                    "classId": signClassId,
                    "beginTime": beginTime,
                    "endTime": endTime
                }, function (res) {
                    if(res == 1){
                        layer.close(layer.index);
                        layer.alert("添加成功! ");
                        $("#name").val("");
                    }
                });
            }

            //计算字符长度，返回val的字节长度
            function getByteLen(val) {
                var len = 0;
                for (var i = 0; i < val.length; i++) {
                    if (val[i].match(/[^\x00-\xff]/ig) != null){  //全角
                        len += 2;
                    }
                    else
                        len += 1;
                }
                return len;
            }

        </script>

    </body>
</html>