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
    <title>国科图书管理系统 by kingwan</title>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <style type="text/css">
        /*#hearder2 { width:1000px; margin:0 auto;}*/
        /*#hearder2 .logo { width:260px; height:90px; float:left;}*/
        /*#hearder2 .logo img { width:200px; height:90px;}*/
        /*#hearder2 .logo-name { width:390px; height:90px; float:left; font-size:18px; font-weight:bold; color:#0aa6d6; line-height:90px; text-align:left;}*/
        /*#hearder2 .form-tools { height:90px; float:right;}*/
        /*#hearder2 .form-tools .tools-link { height:40px; line-height:40px; color:#0aa6d6; text-align:right; font-size:16px; padding-left:35px; background:url(../images/enter.png) left center no-repeat;}*/
        /*#hearder2 .form-tools .tools-link a { color:#0aa6d6; text-decoration:none;}*/
        /*#hearder2 .form-tools .tools-link a:hover { color:#0aa6d6; text-decoration:underline;}*/
        /*#hearder2 .form-tools .search-box { width:100%; height:50px; position:relative;}*/
        /*#hearder2 .form-tools .search-box .input-text { width:130px; height:15px; position:absolute; top:0; right:0; padding:5px 30px 5px 5px; border:1px solid #ccc; border-radius:3px; background:#fff;}*/
        /*#hearder2 .form-tools .search-box .input-submit { width:25px; height:25px; position:absolute; top:0; right:0;border:1px solid #ccc; border-top-right-radius:3px; border-bottom-right-radius:3px;}*/
        /*#menu-box { width:100%; background:#0aa6d6;}*/
        /*#menu-box ul { width:1000px; height:40px; margin:0 auto;}*/
        /*#menu-box ul li { width:111px; height:40px; line-height:40px; float:left; text-align:center; font-size:16px;}*/
        /*#menu-box ul li:hover { background:#0782a8;}*/
        /*#menu-box ul li a{ color:#fff; text-decoration:none; display:block;}*/
        /*!*#detail2-box .tit-80 { height:77px; line-height:60px; color:#fff; font-size:14px; padding:0 20px 20px 75px; background:url(../images/tit-icon.png) 20px 10px no-repeat; background-size:32px;}*!*/
        /*#detail2-box .tit-80 a { color:#fff;}*/

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
        <h1>热门好书推荐</h1>
        <div class="content">
            <div style="height: 800px">
                <c:if test="${empty hotBooks}">
                    <div><h3>没有搜索到相关图书</h3></div>
                </c:if>
                <c:forEach items="${hotBooks}" var="books">
                    <div style="float: left; margin-right: 20px; margin-bottom: 10px" class="flower clearfix tran">
                        <a href="/book?task=bookDet&id=${books.id}" class="clearfix">
                            <dl>
                                <dt>
                                    <span class="abl"></span>
                                    <img src="images/${books.photo}" style="width: 100px; height: 100px; margin: 10px;" />
                                    <span class="abr"></span>
                                </dt>
                                <dd>《${books.name}》</dd>
                                <dd>作者：${books.author}</dd>
                                <dd>
                                    <span>库存：${(books.count-books.borrowed)}</span>
                                </dd>
                            </dl>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <div>${pageTools}}</div>
        </div>
    </div>
    <%--<div>${pageTools}}</div>--%>
</div>

<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>

</body>
</html>

