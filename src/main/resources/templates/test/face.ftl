<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生签到统计</title>
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
</head>
<body>


<div>
    <div>111</div>
    <div id="signData"></div>
</div>

<script>
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById("signData"));
        myChart.clear();

        // 指定图表的配置项和数据
        /*var option = {
            title: {
                text: '第一个 ECharts 实例'
            },
            tooltip: {},
            legend: {
                data:['销量']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };*/

        var option = {
            xAxis: {
                name: '日期',
                type: 'category',
                data: ["123",
                      "123",
                "123",
                "123",
                "123",
                "123"]
            },
            yAxis: {
                name:'访问量'
            },
            series: [{

                data: [123,
                    123,
                    123,
                    123,
                    123,
                    123,
                    123,
                    123,
                    123],
                type: 'bar'
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option,true);
</script>
</body>
</html>