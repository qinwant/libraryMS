<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>

</head>

<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form" method="post" enctype="multipart/form-data">
            <div class="layui-form-item">
                <label for="addId" class="layui-form-label">
                    <span class="x-red">*</span>图书ID</label>
                <div class="layui-input-inline">
                    <input type="text" id="addId" name="addId" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addName" class="layui-form-label">
                    <span class="x-red">*</span>图书名</label>
                <div class="layui-input-inline">
                    <input type="text" id="addName" name="addName" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addBookCase" class="layui-form-label">
                    <span class="x-red">*</span>图书类型</label>
                <div class="layui-input-inline">
                    <input type="text" id="addBookCase" name="addBookCase" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addPhoto" class="layui-form-label">
                    <span class="x-red">*</span>图片</label>
                <div class="layui-input-inline">
                    <input type="file" id="addPhoto" name="addPhoto" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addPublisher" class="layui-form-label">
                    <span class="x-red">*</span>出版社</label>
                <div class="layui-input-inline">
                    <input type="text" id="addPublisher" name="addPublisher" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addAuthor" class="layui-form-label">
                    <span class="x-red">*</span>作者</label>
                <div class="layui-input-inline">
                    <input type="text" id="addAuthor" name="addAuthor" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addCount" class="layui-form-label">
                    <span class="x-red">*</span>数量</label>
                <div class="layui-input-inline">
                    <input type="text" id="addCount" name="addCount" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addHot" class="layui-form-label">
                    <span class="x-red">*</span>热门</label>
                <div class="layui-input-inline">
                    <select id="addHot" name="addHot" class="valid">
                        <option value="yes">是</option>
                        <option value="no">否</option></select>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="add" lay-submit="" id="add">增加</button></div>
        </form>
    </div>
</div>
<script>layui.use(['form', 'layer'],
    function() {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        // //自定义验证规则
        // form.verify({
        //     nikename: function(value) {
        //         if (value.length < 5) {
        //             return '昵称至少得5个字符啊';
        //         }
        //     },
        //     pass: [/(.+){6,12}$/, '密码必须6到12位'],
        //     repass: function(value) {
        //         if ($('#L_pass').val() != $('#L_repass').val()) {
        //             return '两次密码不一致';
        //         }
        //     }
        // });

//        //监听提交
//        form.on('submit(add)',
//            function(data) {
//                console.log(data);
//                //发异步，把数据提交给php
//                data.preventDefault();//阻止默认提交
//                // 上传设置
//                var options = {
//                    // 规定把请求发送到那个URL
//                    url: "/book?task=bookAdd",
//                    // 请求方式
//                    type: "post",
//                    // 服务器响应的数据类型
//                    dataType: "json",
//                    // 请求成功时执行的回调函数
//                    success: function(data, status, xhr) {
//                        // 图片显示地址
//                        alert("成功")
//                    }
//                };
//
//                $(".layui-form").ajaxSubmit(options);
//
//                layer.alert("增加成功", {
//                        icon: 6
//                    },
//                    function() {
//                        // 获得frame索引
//                        var index = parent.layer.getFrameIndex(window.name);
//                        //关闭当前frame
//                        parent.layer.close(index);
//                    });
//                return false;
//            });
        //监听提交
        $("#add").click(function(){
            $(".layui-form").ajaxSubmit({
                url : "/book?task=bookAdd",
                type : "post",
                dataType : 'json',
                success : function(data) {
                    alert("设置成功！");
                },
                error : function(data) {
//                    alert("error:" + data.responseText);
                }

            });

            layer.alert("增加成功", {
                    icon: 6
                },
                function() {
                    // 获得frame索引
                    var index = parent.layer.getFrameIndex(window.name);
                    //关闭当前frame
                    parent.layer.close(index);
                });

            return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
        })

    });</script>

</body>

</html>
