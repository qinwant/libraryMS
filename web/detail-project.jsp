<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/12
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>国科图书管理系统</title>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <%--<link rel="stylesheet" href="./css/font.css">--%>
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <script type="text/javascript" src="./js/showdown.min.js"></script>
</head>

<body>
<div id="hearder2" class="clearfix">
    <div class="logo">
        <img src="images/libraryLogo1.png">
    </div>
    <div class="logo-name">国科图书管理系统 by kingwan</div>
    <div class="form-tools">
        <form id="search" name="search" method="post">
            <c:if test="${empty sessionScope.readerCurrent}">
                <div class="tools-link">
                    <a href="login_reader.jsp" target="_self">读者登录入口</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="login_admin.jsp" target="_self">管理员登录入口</a>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.readerCurrent}">
                <div class="tools-link">
                    <a href="personal.jsp" target="_self">${sessionScope.readerCurrent.name}</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <%--<a href="login_reader.jsp" target="_self">退出</a>--%>
                    <a href="/reader?task=logout" target="_self">退出</a>
                </div>

            </c:if>
        </form>
    </div>
</div>
<div id="menu-box" class="clearfix">
    <ul>
        <li><a href="home.jsp">首页</a></li>
        <li><a href="detail-project.jsp">项目简介</a></li>
    </ul>
</div>
<!-- detail -->
<div id="detail2-box" class="clearfix">
    <div class="tit-80">读者服务</div>
    <div class="tabula-box">
        <div class="max-tit">个人中心</div>
        <ul>
            <li><a href="personal.jsp">个人信息</a></li>
            <li><a href="message.jsp">我的消息</a></li>
            <li><a href="/reader?task=bookManage">图书管理</a></li>
            <li><a href="/reader?task=recordBorrow">借书记录</a></li>

        </ul>
    </div>
    <div class="content-box">
        <h1>项目简介</h1>
        <div>
            <div>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <img src="images/project.png" align="left">
                    <a class="layui-btn" onclick="xadmin.open('项目详情','detail-markdown.jsp','500')" >查看功能详情</a>
                    <a class="layui-btn" href="https://github.com/qinwant/libraryMS" target="_blank" >查看项目源码</a>
                </fieldset>
            </div>
            <div>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <legend>项目开发时间线：大事记</legend>
                </fieldset>
                <ul class="layui-timeline">
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis"></i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">2020.04.30，Gok-libraryMS-2.0 发布。大部分功能已实现，存在未测试Bug</div>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis"></i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">2020.04.26-2020.04.29，模拟数据测试，调bug</div>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis"></i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">2020.04.20-2020.04.25，后台模块功能开发</div>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis"></i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">2020.04.14-2020.04.19，前台模块功能开发</div>
                        </div>
                    </li>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop layui-timeline-axis"></i>
                        <div class="layui-timeline-content layui-text">
                            <div class="layui-timeline-title">更久前，轮子时代。搬运前后台模板资源</div>
                        </div>
                    </li>
                </ul>
            </div>
            </div>
            <%--<p style=""></p>--%>



    </div>
</div>
<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>
</body>
</html>

