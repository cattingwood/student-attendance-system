<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>评价记录查询</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <script type="text/javascript" src="../js/echarts.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/evaluateManage.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-admin.ftl"/>

        <div class="layui-card-body schedule">
            <div class="table" id="evaluateRecordTable"></div>
        </div>

        <script>
            $(document).ready(function () {
                searchEvaluateRecord();
            })

            function searchEvaluateRecord() {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#evaluateRecordTable'
                        ,height: 450
                        ,url: '/evaluate/AllEvaluateRecord' //数据接口
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
                            {field: 'id', title: 'ID', width:100, sort: true, fixed: 'left'}
                            ,{field: 'score', title: '评分', width:60}
                            ,{field: 'content', title: '评价内容', width:600}
                            ,{field: 'userType', title: '用户类型', width:100}
                            ,{field: 'userId', title: '用户ID', width:100}
                            ,{field: 'userName', title: '用户名', width:100}
                            ,{field: '',width: 200, title: '操作'}
                        ]]
                    });
                });
            }
        </script>


    </body>
</html>