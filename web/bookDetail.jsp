<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/14
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8">
    <title>国科图书管理系统</title>
    <link rel="stylesheet" type="text/css" href="css/demo.css"/>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <style type="text/css">
    #detail2-box .tit-80 a { color:#fff;}
        body {
            position: relative;
        }
        .clearfix:after {
            content: "";
            display: block;
            clear: both;
            height: 0;
            line-height: 0;
            visibility: hidden;
        }
        .clearfix {
            zoom: 1;
        }
        .book-info{
            float: inherit; /*设置浮动*/
            display: block;/*设置元素的显示属性 block 元素会被显示为块级元素*/
            /*height: 50px;!*设置元素高度*!*/
            /*width: 50px;!*设置元素宽度*!*/
            border-radius: 10px;/*设置圆角边框*/
            background: antiquewhite;/*设置背景颜色*/
            color: cadetblue;/*设置文本颜色*/
            text-align: center;/*设置文本居中*/
            line-height: 50px;/*设置文本行高*/
            text-decoration: aliceblue;/*设置文本装饰*/
            margin: 5px;/*设置外边距*/
        }

    </style>
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
<div id="detail2-box" class="clearfix">
    <div class="tit-80">图书信息</div>
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
        <h1>图书详情</h1>
        <div class="content">
            <%--图片--%>
            <div id="showbox" style="display: flex;justify-content: center;align-items:center;">
                <img src="images/${book.photo}" width="200" height="260" style="float: left; /*设置浮动*/"/>
            </div>
            <%--图书价格--%>
            <div class="tb-property" >
                <div class="tr-nobdr" >
                    <span class="book-info"><h3>《${book.name}》</h3></span>
                    <span style="float:right" class="book-info"><h3>库存：<em id="count">${book.count}</em></h3></span>
                    <span style="float: right" class="book-info"><h3>被借：<em id="borrowed">${book.borrowed}</em></h3></span>
                </div>
            </div>
                <span></span>
            <%--操作--%>
            <div class="nobdr-btns">
                <form action="/reader?task=borrow&bookId=${book.id}&bookName=${book.name}" method="post" name="formBorrow">
                    <button style="outline:none;border:5px;top: 2px" class="addcart hu" onclick="document.formBorrow.submit"><img src="images/shop3.png" width="25" height="25"/>借阅</button>
                </form>
                <br>
                <form action="/reader?task=return&bookId=${book.id}&bookName=${book.name}" method="post" name="formReturn">
                    <button style="outline:none;border:5px;top: 2px" class="addcart yh" onclick="document.formReturn.submit"><img src="images/return.png" width="25" height="25"/>归还</button>
                </form>
            </div>
            <%--</div>--%>
        </div>
    </div>
</div>

<%--之前的--%>
<!-- detail -->

<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>

</body>
</html>

