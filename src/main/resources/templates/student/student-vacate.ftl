<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>学生请假</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <script type="text/javascript" src="../js/echarts.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/vacate.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-student.ftl"/>

        <div class="layui-card-body" id="timeFilter">
            <a class="layui-btn layui-btn-primary" onclick="vacateWindow()">请假申请</a>
        </div>

        <div class="layui-card-body record">
            <table class="layui-table" id="vacateRecord">
                <colgroup>
                    <col width="200">
                    <col width="200">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>开始日期</th>
                    <th>结束日期</th>
                    <th>状态</th>
                    <th>申请时间</th>
                </tr>
                </thead>
                <tbody>
                <#if (vacateRecords)?? &&((vacateRecords)?size>0)>
                    <#list vacateRecords as vr>
                        <tr>
                            <td>第${vr.beginWeek!''}周星期${vr.beginDay!''}第${vr.beginTime!''}节</td>
                            <td>第${vr.endWeek!''}周星期${vr.endDay!''}第${vr.endTime!''}节</td>
                            <td>
                                <#if vr.status == 0>
                                    正在处理
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

        <div hidden id="addVacate">
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    开始日期：
                    <div class="layui-form-item">
                        <label class="layui-form-label">第几周</label>
                        <div class="layui-form layui-input-block">
                            <select id="beginWeek"lay-filter="beginWeek">
                                <#list 1..20 as i>
                                    <option value="${i}">${i}</option>
                                </#list>
                            </select>
                        </div>
                        <label class="layui-form-label">第几天</label>
                        <div class="layui-form layui-input-block">
                            <select id="beginDay"lay-filter="beginDay">
                                <#list 1..7 as i>
                                    <option value="${i}">${i}</option>
                                </#list>
                            </select>
                        </div>
                        <label class="layui-form-label">第几节</label>
                        <div class="layui-form layui-input-block">
                            <select id="beginTime"lay-filter="beginTime">
                                <#list 1..10 as i>
                                    <option value="${i}">${i}</option>
                                </#list>
                            </select>
                        </div>
                    </div>


                    结束日期：
                    <div class="layui-form-item">
                        <label class="layui-form-label">第几周</label>
                        <div class="layui-form layui-input-block">
                            <select id="endWeek"lay-filter="endWeek">
                                <#list 1..20 as i>
                                    <option value="${i}">${i}</option>
                                </#list>
                            </select>
                        </div>
                        <label class="layui-form-label">第几天</label>
                        <div class="layui-form layui-input-block">
                            <select id="endDay"lay-filter="endDay">
                                <#list 1..7 as i>
                                    <option value="${i}">${i}</option>
                                </#list>
                            </select>
                        </div>
                        <label class="layui-form-label">第几节</label>
                        <div class="layui-form layui-input-block">
                            <select id="endTime"lay-filter="endTime">
                                <#list 1..10 as i>
                                    <option value="${i}">${i}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="layui-btn"  onclick="addVacate()">申请请假</div>
                </form>
            </div>
        </div>

        <script>
            function vacateWindow() {
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '申请假期',
                    area: ['40%', '70%'],//弹框大小
                    content: $("#addVacate"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                    },
                    end: function () {
                        $("#addVacate").hide();
                    }
                })
            }

            function addVacate() {
                var beginWeek = parent.$('#beginWeek').val();
                var beginDay = parent.$('#beginDay').val();
                var beginTime = parent.$('#beginTime').val();
                var endWeek = parent.$('#endWeek').val();
                var endDay = parent.$('#endDay').val();
                var endTime = parent.$('#endTime').val();
                if(beginWeek>endWeek){
                    layer.alert("开始时间不得大于结束时间! ");
                    return false;
                }else if(beginWeek == endWeek && beginDay >endDay){
                    layer.alert("开始时间不得大于结束时间! ");
                    return false;
                }else if(beginWeek == endWeek && beginDay == endDay && beginTime > endTime){
                    layer.alert("开始时间不得大于结束时间! ");
                    return false;
                }

                $.post("/sign/addVacate", {
                    "beginWeek": beginWeek,
                    "beginDay": beginDay,
                    "beginTime": beginTime,
                    "endWeek": endWeek,
                    "endDay": endDay,
                    "endTime": endTime
                }, function (res) {
                    if(res == 1){
                        layer.close(layer.index);
                        layer.alert("申请假期成功! ");
                    }
                });

            }

            /*查找所有课程并显示*/
            function allVacateRecord() {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#vacateRecord'
                        ,height: 312
                        ,url: '/sign/selectVacateRecordByStudent' //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": '成功', //解析提示文本
                                "count": res.total, //解析数据长度
                                "data": res //解析数据列表
                            };
                        }
                        ,page: true //开启分页
                        ,cols: [[ //表头
                            {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                            ,{field: 'name', title: '课程名', width:200}
                            ,{field: 'isPublic', title: '公共课', width:80,
                                templet:function (res) {
                                    if (res.isPublic === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            ,{field: 'isRequired', title: '必修课', width:80,
                                templet:function (res) {
                                    if (res.isRequired === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            , {field: '',width: 250, title: '操作',
                                templet: function (res) {
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>编辑</button> &nbsp;&nbsp;";
                                    ops +="<button class=\"layui-btn-normal layui-btn layui-btn-xs\" title=\"上架\" onclick=\"deleteCourse('" + res.id + "','" + res.name + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe619;</i>删除</button>";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }

        </script>
    </body>
</html>