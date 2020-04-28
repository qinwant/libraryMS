<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/9
  Time: 23:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
  <meta charset="UTF-8">
  <title>国科图书后台-基于X-admin2.2-layui</title>
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="stylesheet" href="./css/font.css">
  <link rel="stylesheet" href="./css/xadmin.css">
  <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
  <script src="./lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="./js/xadmin.js"></script>
  <script>
      // 是否开启刷新记忆tab功能
//      var is_remember = false;
  </script>

</head>

<body class="index">
<!-- 顶部开始 -->
<div class="container">
  <div class="logo">
    <a href="./index.html">Gok-admin v2.2</a></div>
  <div class="left_open">
    <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
  </div>
  <ul class="layui-nav right" lay-filter="">
    <li class="layui-nav-item">
      <a href="javascript:;">${sessionScope.adminCurrent.adminName}</a>
      <dl class="layui-nav-child">
        <!-- 二级菜单 -->
        <dd>
          <a onclick="xadmin.open('个人信息','admin-info.jsp')">个人信息</a></dd>
        <dd>
          <button class="layui-btn layui-btn-fluid layui-btn-danger" id="logout">退出</button></dd>
      </dl>
    </li>
    <li class="layui-nav-item to-index">
      <a href="home.jsp">前台首页</a></li>
  </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
  <div id="side-nav">
    <ul id="nav">
      <li>
        <a href="javascript:;">
          <i class="iconfont left-nav-li" lay-tips="会员管理">&#xe6b8;</i>
          <cite>会员管理</cite>
          <i class="iconfont nav_right">&#xe697;</i></a>
        <ul class="sub-menu">
          <li>
            <a onclick="xadmin.add_tab('会员信息','reader-info.jsp')">
              <i class="iconfont">&#xe6a7;</i>
              <cite>会员信息</cite></a>
          </li>
          <li>
            <a onclick="xadmin.add_tab('会员列表(静态表格)','reader-list.jsp')">
              <i class="iconfont">&#xe6a7;</i>
              <cite>会员列表</cite></a>
          </li>
        </ul>
      </li>
      <li>
        <a href="javascript:;">
          <i class="iconfont left-nav-li" lay-tips="图书管理">&#xe723;</i>
          <cite>图书管理</cite>
          <i class="iconfont nav_right">&#xe697;</i></a>
        <ul class="sub-menu">
          <li>
            <a onclick="xadmin.add_tab('图书列表','adminBookManage.jsp')">
              <i class="iconfont">&#xe6a7;</i>
              <cite>图书列表</cite></a>
          </li>
          <li>
            <a onclick="xadmin.add_tab('借阅管理','recordList.jsp')">
              <i class="iconfont">&#xe6a7;</i>
              <cite>借阅信息</cite></a>
          </li>
        </ul>
      </li>
      <li>
        <a href="javascript:;">
          <i class="iconfont left-nav-li" lay-tips="管理员管理">&#xe726;</i>
          <cite>管理员管理</cite>
          <i class="iconfont nav_right">&#xe697;</i></a>
        <ul class="sub-menu">
          <li>
            <a onclick="xadmin.add_tab('管理员列表','weclome.jsp')">
              <i class="iconfont">&#xe6a7;</i>
              <cite>管理员列表(暂未开发)</cite></a>
          </li>
        </ul>
      </li>

    </ul>
  </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
  <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
    <ul class="layui-tab-title">
      <li class="home">
        <i class="layui-icon">&#xe68e;</i>我的桌面</li></ul>
    <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
      <dl>
        <dd data-type="this">关闭当前</dd>
        <dd data-type="other">关闭其它</dd>
        <dd data-type="all">关闭全部</dd></dl>
    </div>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
        <iframe src='welcome.jsp' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
      </div>
    </div>
    <div id="tab_show"></div>
  </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
</body>
<script type="text/javascript">
    layui.use(['layer'],function(){
        $ = layui.$;
        var layer = layui.layer;
        //根据id获取官网中指定的全局数据
        //监听管理员退出操作
        $("#logout").click(function(){
            layer.confirm('您确定退出吗?', {anim:5,shade: [0.7, '#393D49'],icon: 6, title:'退出系统'}, function(index){
                //do something
                $.ajax({
                    url:"/admin?task=logout",
                    type:"post",
                    dataType:"text",
                    success:function (msg) {
                        console.log("msg:"+msg)
                    }
                })
                window.location.href="login.jsp";
                layer.close(index);
            });
        });
    });
</script>
</html>
