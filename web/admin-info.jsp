<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/24
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>国科图书后台-基于X-admin2.2-layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <%--通过session获得管理员信息预先填入表单--%>
        <form class="layui-form">
            <div class="layui-form-item">
                <label for="L_phone" class="layui-form-label">
                    <span class="x-red">*</span>手机号码</label>
                <div class="layui-input-inline">
                    <input style="background: #CCCCCC" disabled="true" type="text" id="L_phone" name="phone" required="" lay-verify="" autocomplete="off" class="layui-input" value="${sessionScope.adminCurrent.adminTel}"></div>
            </div>
            <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">
                    <span class="x-red">*</span>邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_email" name="email" required="" lay-verify="email" autocomplete="off" class="layui-input" value="${sessionScope.adminCurrent.adminMail}"></div>
            </div>
            <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">
                    <span class="x-red">*</span>昵称</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_username" name="username" required="" lay-verify="nikename" autocomplete="off" class="layui-input" value="${sessionScope.adminCurrent.adminName}"></div>
            </div>
            <div class="layui-form-item">
                <label for="L_oldpass" class="layui-form-label">
                    <span class="x-red">*</span>旧密码</label>
                <div class="layui-input-inline">
                    <input type="password" id="L_oldpass" name="oldpass" required="" lay-verify="oldpass" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">
                    <span class="x-red">*</span>新密码</label>
                <div class="layui-input-inline">
                    <input type="password" id="L_pass" name="pass" required="" lay-verify="pass" autocomplete="off" class="layui-input"></div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div></div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">
                    <span class="x-red">*</span>确认密码</label>
                <div class="layui-input-inline">
                    <input type="password" id="L_repass" name="repass" required="" lay-verify="repass" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="add" lay-submit="">修改</button></div>
        </form>
    </div>
</div>
<script>layui.use(['form', 'layer','jquery'],
    function() {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //自定义验证规则
        form.verify({
            nikename: function(value) {
                if (value.length < 5) {
                    return '昵称至少得5个字符';
                }
            },
            oldpass: function(input) {
                var data = "";
                $.ajax({
                    async:false,//同步请求
                    url:"/admin?task=verifyPass",
                    dataType:"text",
                    type:"post",
                    data:{
                      "phone":${sessionScope.adminCurrent.adminTel},
                      "oldpass":input
                    },
                    success:function (msg) {
                        console.log("msg:"+msg)
                        data = msg;
                    }
                })
                if(data=='密码验证成功！'){

                }else {
                    return '旧密码错误!'
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            repass: function(value) {
                if ($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(add)',
            function(data) {
                console.log(data);
                var adminphone = data.field.phone;
                var adminpass = data.field.pass;
                var adminMail = data.field.email;
                var adminName = data.field.username;
                console.log("手机号："+adminphone+"密码："+adminpass);

                //发异步，把数据提交给Java后台
                $.ajax({
                    url:"/admin",
                    type:"post",
                    dataType:"text",
                    data:{
                        "task":"changeInfo",
                        "adminTel":adminphone,
                        "adminPassword":adminpass,
                        "adminMail":adminMail,
                        "adminName":adminName,
                    },
                    success:function (msg) {
                        console.log("msg:"+msg);
                    }

                })
                layer.alert("修改成功", {
                        icon: 6
                    },
                    function() {
                        //关闭当前frame
                        xadmin.close();

                        // 可以对父窗口进行刷新
                        xadmin.father_reload();
                    });
                return false;
            });

    });</script>
</body>

</html>
