<div id="dg" style="z-index: 9999; position: fixed ! important; right: 50px; bottom: 100px;">
    <table width=""100% style="position: absolute; width:260px; right: 50px; bottom: 100px;">
        <button class="layui-btn layui-btn-radius" onclick="evaluateWindow()" style="">
            <i class="layui-icon">&#xe6b2;</i>评价
        </button>
    </table>
</div>


<div id="evaluate" hidden style="text-align: center">
    <div style="margin: 50px;width: 500px;">
        <form class="layui-form" action="">
            <div id="evaluateStar"></div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <textarea id="evaluateContent" placeholder="你的评价会帮助我们更好改进！" class="layui-textarea"></textarea>
                </div>
            </div>

            <div class="layui-btn"  onclick="evaluateSubmit()">评价</div>
        </form>
    </div>
</div>

<script>
    var score = 5;

    layui.use(['rate'], function(){
        var rate = layui.rate;
        rate.render({
            elem: '#evaluateStar'
            ,value: 5
            ,text: true
            ,setText: function(value){
                this.span.text(value + "分");
            }
            ,choose: function(value){
                score = value;
            }
        })
    });

    $(document).ready(function () {
        $(".layui-icon-rate-solid").css("font-size","2rem");
        $(".layui-icon-rate").css("font-size","2rem");
        $("#evaluateStar span").css("font-size","1.3rem");
    })

    function evaluateSubmit() {
        var evaluateContent = parent.$('#evaluateContent').val();
        $.post("/evaluate/evaluateSubmit", {
            "score": score,
            "evaluateContent": evaluateContent
        }, function (res) {
            if(res == 1){
                layer.close(layer.index);
                layer.alert("评价成功! ");
            }
        });
    }

    function evaluateWindow() {
        var layer = layui.layer;
        layer.open({
            type: 1,
            title: '评价',
            area: ['40%', '50%'],//弹框大小
            content: $("#evaluate"),
            // 打开弹窗的回调函数，用于回显页面数据
            success: function () {
            },
            end: function () {
                $("#evaluate").hide();
            }
        })
    }
</script>