<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/12
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title>国科图书管理系统 by kingwan</title>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <style type="text/css">
        .submit-button { /* 按钮美化 */
            border-width: 0px; /* 边框宽度 */
            border-radius: 3px; /* 边框半径 */
            background: #1E90FF; /* 背景颜色 */
            cursor: pointer; /* 鼠标移入按钮范围时出现手势 */
            outline: none; /* 不显示轮廓线 */
            font-family: Microsoft YaHei; /* 设置字体 */
            color: white; /* 字体颜色 */

        }
        .submit-button:hover { /* 鼠标移入按钮范围时改变颜色 */
            background: #55a532;
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
        <h1>借阅记录</h1>

        <div class="content">
            <div class="layui-card-body ">
                <table class="layui-table layui-form">
                    <thead>
                    <tr>
                        <th>书名</th>
                        <th>借书时间</th>
                        <th>还书截止时间</th>
                        <th>是否归还</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody class="bookMsg">
                    <c:forEach items="${borrows}" var="borrow">
                        <tr>
                            <td>《${borrow.bookName}》</td>
                            <td><fmt:formatDate type="both" value="${borrow.borrowTime}"/></td>
                            <td><fmt:formatDate type="both" value="${borrow.returnTimePre}"/></td>
                            <td>${borrow.isReturn eq 'yes'?'是':'否'}</td>
                            <td>
                                <c:if test="${borrow.isReturn eq 'no'}">
                                    <input style="background: #9F9F9F; " class="submit-button" type="submit" value="未还书籍，无法删除" >
                                </c:if>
                                <c:if test="${borrow.isReturn eq 'yes'}">
                                    <form class="layui-input-inline" action="/reader?task=recordDel&id=${borrow.id}&tel=${borrow.readerTel}" method="post" name="bookReturn">
                                        <input class="submit-button" type="submit" value="删除记录" >
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <%--<div>--%>
                <%--<table>--%>
                    <%--<tr>--%>
                        <%--<th>书名</th>--%>
                        <%--<th>借书时间</th>--%>
                        <%--<th>还书截止时间</th>--%>
                        <%--<th>是否归还</th>--%>
                    <%--</tr>--%>
                    <%--<c:forEach items="${borrows}" var="borrow">--%>
                        <%--<tr>--%>
                            <%--<td>${borrow.bookName}</td>--%>
                            <%--<td>${borrow.borrowTime}</td>--%>
                            <%--<td>${borrow.returnTimePre}</td>--%>
                            <%--<td>${borrow.isReturn}</td>--%>
                            <%--<td><input type="button" value="删除"></td>--%>
                        <%--</tr>--%>
                    <%--</c:forEach>--%>

                <%--</table>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>

</body>
</html>

