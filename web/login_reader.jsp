<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/11
  Time: 22:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="css/login1.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<section id="content">
    <!--头部-->
    <div class="content-header clearfix">
        <a href="javascript:;" class="current">登录</a>
        <a href="javascript:;">注册</a>
    </div>
    <!--内容-->
    <div class="content-body">
        <div class="dom" style="display: block;">
            <form action="/reader?task=login" method="post">
                <div class="s1">
                    <h4>账号</h4>
                    <input name="user" type="text" placeholder="用户名/手机/邮箱">
                </div>
                <div class="s1">
                    <h4>密码</h4>
                    <input name="pwd" type="password" placeholder="请输入密码">
                </div>
                <%--<div class="s2">--%>
                    <%--<input type="checkbox">--%>
                    <%--<span>记住密码</span>--%>
                <%--</div>--%>
                <input type="submit" class="btn" value="登&nbsp;录">
            </form>
            <%--<div class="dom-footer">--%>
                <%--<div class="login-another">--%>
                    <%--<a href="#">找回密码</a>--%>
                    <%--<span>|</span>--%>
                    <%--<span>还没有注册帐号?</span>--%>
                    <%--<a href="#">立即注册</a>--%>
                <%--</div>--%>
                <%--<div class="login-three">--%>
                    <%--<span>使用第三方账号直接登录</span>--%>
                    <%--<div class="login-icon">--%>
                        <%--<a href="#">--%>
                            <%--<img src="images/qq.png" alt="">--%>
                        <%--</a>--%>
                        <%--<a href="#">--%>
                            <%--<img src="images/wechat.png" alt="">--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
        <div class="dom">
            <form action="/reader?task=registered" method="post">
                <div class="s1">
                    <h4>手机号码</h4>
                    <input name="phone" type="text" placeholder="填写你的手机号码作为登录账户">
                </div>
                <div class="s1">
                    <h4>用户名</h4>
                    <input name="user" type="text" placeholder="中、英文均可, 最长20个字符或10个汉字">
                </div>
                <div class="s1">
                    <h4>密码</h4>
                    <input name="pwd" type="password" placeholder="6-30位英文、数字、符号, 区分大小写">
                </div>
                <%--<div class="s1 msg-code">--%>
                    <%--<h4>短信验证码</h4>--%>
                    <%--<input name="msg" type="text" placeholder="填写短信验证码">--%>
                    <%--<input type="button" value="获取短信验证码">--%>
                <%--</div>--%>
                <input type="submit" class="btn" value="注&nbsp;册">
            </form>
            <%--<div class="dom-footer">--%>
                <%--<div class="login-three">--%>
                    <%--<span>使用第三方账号直接登录</span>--%>
                    <%--<div class="login-icon">--%>
                        <%--<a href="#">--%>
                            <%--<img src="images/qq.png" alt="">--%>
                        <%--</a>--%>
                        <%--<a href="#">--%>
                            <%--<img src="images/wechat.png" alt="">--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
</section>
<script>
    window.onload = function () {
        // 1.1 获取需要的标签
        let as = document.getElementsByClassName('content-header')[0].getElementsByTagName('a');
        let contents = document.getElementsByClassName('dom');

        // 1.2 遍历
        for (let i = 0; i < as.length; i++) {
            // 1.2.1 取出单个对象
            let a = as[i];
            a.id = i;

            // 1.2.2 监听鼠标的移动事件
            a.onclick = function () {
                // 让所有的a的class都清除
                for (let j = 0; j < as.length; j++) {
                    as[j].className = '';
                    contents[j].style.display = 'none';
                }

                // 设置当前a的class
                this.className = 'current';
                // 从contents数组中取出对应的标签
                contents[this.id].style.display = 'block';
            }

        }
    }
</script>
</body>
</html>
