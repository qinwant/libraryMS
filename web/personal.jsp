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
    <title>国科图书管理系统 by kingwan</title>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <%--<link rel="stylesheet" href="./css/font.css">--%>
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>

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
        <h1>我的信息</h1>
        <div class="content">
            <%--<div class="">--%>
                <%--<div class="">--%>
                    <%--<a class=""><img src="images/${sessionScope.readerCurrent.photo}" /></a>--%>
                <%--</div>--%>
                <%--<form action="/reader?task=change" method="post" enctype="multipart/form-data">--%>
                    <%--<h4>请上传图片</h4>--%>
                    <%--<span id="uploadImg">--%>
					<%--<input type="file" id="filevalue"size="1" name="readerPic" />--%>
					<%--</span>--%>
                    <%--学号<input type="text" name="readerId" value="${readerCurrent.id }" style="display: block"  />--%>
                    <%--姓名<input type="text" value="${readerCurrent.name }" name="readerName" style="display: block"/>--%>
                    <%--电话<input type="text" value="${readerCurrent.tel }" name="readerTel" style="display: block"/>--%>
                    <%--性别<input type="text" value="${readerCurrent.sex }" name="readerSex" style="display: block"/>--%>
                    <%--年龄<input type="text" value="${readerCurrent.age }" name="readerAge" style="display: block"/>--%>
                    <%--邮箱<input type="text" value="${readerCurrent.mail}" name="readerMail" style="display: block"/>--%>
                    <%--<span></span>--%>
                    <%--<input type="submit" value="保存" style="cursor: pointer" />--%>
                <%--</form>--%>
                <div class="layui-form-item">
                    <label class="layui-form-label">头像</label>
                    <div class="layui-input-inline">
                        <img src="images/${sessionScope.readerCurrent.photo}" alt="暂无缩略图！">
                    </div>
                </div>
                <form class="layui-form" name="information" action="/reader?task=change" method="post" enctype="multipart/form-data">
                    <div class="layui-form-item">
                        <label class="layui-form-label">头像</label>
                        <div class="layui-input-inline">
                            <input  type="file" name="readerPic"   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">id</label>
                        <div class="layui-input-inline">
                            <input value="${readerCurrent.id}" readonly="readonly" type="text" name="readerId" required  lay-verify="required"  autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux">*id唯一识别，禁止更改</div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-input-inline">
                            <input value="${readerCurrent.name}" type="text" name="readerName" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">电话</label>
                        <div class="layui-input-inline">
                            <input value="${readerCurrent.tel}" readonly="readonly" type="text" name="readerTel" required lay-verify="required" placeholder="请输入电话" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux">*手机唯一识别，禁止更改</div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">性别</label>
                        <div class="layui-input-inline">
                            <input value="${readerCurrent.sex }" type="text" name="readerSex" required  lay-verify="required" placeholder="请输入性别" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">年龄</label>
                        <div class="layui-input-inline">
                            <input value="${readerCurrent.age}" type="text" name="readerAge" required  lay-verify="required" placeholder="请输入年龄" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-inline">
                            <input value="${readerCurrent.mail}" type="text" name="readerMail" required  lay-verify="required|email" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="document.information.submit">立即修改</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>

                </form>
            <%--</div>--%>
        </div>
    </div>
</div>
<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>
<%--<script>--%>
    <%--//Demo--%>
    <%--layui.use('form', function(){--%>
        <%--var form = layui.form;--%>

        <%--//监听提交--%>
        <%--form.on('submit(formDemo)', function(data){--%>
            <%--layer.msg(JSON.stringify(data.field));--%>
            <%--return false;--%>
        <%--});--%>
    <%--});--%>
<%--</script>--%>
</body>
</html>

