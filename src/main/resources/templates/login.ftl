<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>学生考勤系统-登录</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/login.css">
    </head>
    <body class="login-bg">
        <!--若是手机则跳转到手机网页-->
        <script>
            function goPAGE() {
                if ((navigator.userAgent.match(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i))) {
                    window.location.href="/login/loginPhone";
                }
            }
            goPAGE();
        </script>

        <div class="login layui-main">

            <div class="message">学生考勤系统登录</div>

            <form method="post" class="layui-form">
                <input name="account" lay-filter="account" placeholder="账号" type="number" lay-verify="required|number" class="layui-input">
                <input name="password" lay-filter="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        登录方式：
                        <input type="radio" name="type" lay-filter="type" value="学生" title="学生" checked="">
                        <input type="radio" name="type" lay-filter="type"value="老师" title="老师">
                        <input type="radio" name="type" lay-filter="type"value="辅导员" title="辅导员">
                        <input type="radio" name="type" lay-filter="type" value="管理员" title="管理员">
                    </div>
                </div>
                <a class="layui-btn layui-btn-primary"lay-submit lay-filter="login" id="loginBtn">登录</a>
            </form>
        </div>

        <script>
            $(function () {
                layui.use('form',function () {
                    var form = layui.form;
                    form.on('submit(login)',function (data) {
                        $.post("/login/login", data.field, function (res) {
                            if (res) {
                                window.location.href="/login/toMainPage";
                            } else {
                                layer.alert("账号或密码错误！");
                            }
                        });
                    })
                })
            })
        </script>

        <#--鼠标特效光球吸附-->
        <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
        <script>
            $(function(){
                function n(n,e,t){
                    return n.getAttribute(e)||t
                }
                function e(n){
                    return document.getElementsByTagName(n)
                }
                function t(){
                    var t=e("script"),o=t.length,i=t[o-1];
                    return{l:o,z:n(i,"zIndex",-1),o:n(i,"opacity",.6),c:n(i,"color","46,139,87"),n:n(i,"count",150)}
                }
                function o(){
                    a=m.width=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth,
                        c=m.height=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight
                }
                function i(){
                    r.clearRect(0,0,a,c);
                    var n,e,t,o,m,l;
                    s.forEach(function(i,x){
                        for(i.x+=i.xa,i.y+=i.ya,i.xa*=i.x>a||i.x<0?-1:1,i.ya*=i.y>c||i.y<0?-1:1,r.fillRect(i.x-.5,i.y-.5,1,1),e=x+1;e<u.length;e++)n=u[e],
                        null!==n.x&&null!==n.y&&(o=i.x-n.x,m=i.y-n.y,
                            l=o*o+m*m,l<n.max&&(n===y&&l>=n.max/2&&(i.x-=.03*o,i.y-=.03*m),
                            t=(n.max-l)/n.max,r.beginPath(),r.lineWidth=t/2,r.strokeStyle="rgba("+d.c+","+(t+.2)+")",r.moveTo(i.x,i.y),r.lineTo(n.x,n.y),r.stroke()))
                    }),
                        x(i)
                }
                var a,c,u,m=document.createElement("canvas"),d=t(),l="c_n"+d.l,r=m.getContext("2d"),
                    x=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||
                        function(n){
                            window.setTimeout(n,1e3/45)
                        },
                    w=Math.random,y={x:null,y:null,max:2e4};m.id=l,m.style.cssText="position:fixed;top:0;left:0;z-index:"+d.z+";opacity:"+d.o,e("body")[0].appendChild(m),o(),window.onresize=o,
                    window.onmousemove=function(n){
                        n=n||window.event,y.x=n.clientX,y.y=n.clientY
                    },
                    window.onmouseout=function(){
                        y.x=null,y.y=null
                    };
                for(var s=[],f=0;d.n>f;f++){
                    var h=w()*a,g=w()*c,v=2*w()-1,p=2*w()-1;s.push({x:h,y:g,xa:v,ya:p,max:6e3})
                }
                u=s.concat([y]),
                    setTimeout(function(){i()},100)
            });
        </script>
    </body>
</html>