<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/14
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<c:if test="${empty myMessage}">--%>
    <%--<c:redirect url="/reader?task=getMssage"></c:redirect>--%>
<%--</c:if>--%>
<html>
<head>
    <meta charset="utf-8">
    <title>国科图书管理系统 by kingwan</title>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
        .wd-button { /* 按钮美化 */
             width: auto;
             height: 40px;
             margin: 5px;
             border-width: 0px; /* 边框宽度 */
             border-radius: 3px; /* 边框半径 */
             background: #1E90FF; /* 背景颜色 */
             cursor: pointer; /* 鼠标移入按钮范围时出现手势 */
             outline: none; /* 不显示轮廓线 */
             font-family: Microsoft YaHei; /* 设置字体 */
             font-size: medium;
             color:#fff9ec; /* 字体颜色 */

         }
        .wd-button:hover { /* 鼠标移入按钮范围时改变颜色 */
            background: #5FB878;
        }

        .yd-button { /* 按钮美化 */
            width: auto;
            height: 40px;
            margin: 5px;
            border-width: 0px; /* 边框宽度 */
            border-radius: 3px; /* 边框半径 */
            background: #9F9F9F; /* 背景颜色 */
            cursor: pointer; /* 鼠标移入按钮范围时出现手势 */
            outline: none; /* 不显示轮廓线 */
            font-family: Microsoft YaHei; /* 设置字体 */

            color:#fff9ec; /* 字体颜色 */

        }
        .yd-button:hover { /* 鼠标移入按钮范围时改变颜色 */
            background: #5FB878;
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
        <h1>邮件消息</h1>
        <div class="content">
            <div style="height: 800px">
                <input class="wd-button" type="button" value="点击刷新" onclick="location.reload()">
                <c:forEach items="${myMessage}" var="message">
                    <div>
                        <c:if test="${message.isRead eq '未读'}">
                            <input class="wd-button" type="button" value="未读消息" >
                            <span>您借阅的书籍《${message.bookName}》，应于<fmt:formatDate type="both" value="${message.returnTime}"/>归还，请及时归还！</span>
                            <input class="wd-button" type="button" value="标为已读" onclick="change(${message.id})">
                        </c:if>
                        <c:if test="${message.isRead eq '已读'}">
                            <input class="yd-button" type="button" value="已读消息" >
                            <span>您借阅的书籍《${message.bookName}》，应于<fmt:formatDate type="both" value="${message.returnTime}"/>归还，请及时归还！</span>
                        </c:if>
                    </div>
                </c:forEach>


            </div>
        </div>
    </div>
    <%--<div>${pageTools}}</div>--%>
</div>

<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>
<script type="text/javascript">
    $(function () {

        var flag = '<%=session.getAttribute("flag")%>';
        console.log("flag:"+flag)
        $.ajax({
            url:"/reader?task=getMssage",
            dataType:"text",
            success:function (msg) {
                console.log("消息加载是否成功："+msg)

            }
        })
        <%--if('<%=session.getAttribute("flag")%>'=='null'){--%>
            <%--$.ajax({--%>
                <%--url:"/reader?task=getMssage",--%>
                <%--dataType:"text",--%>
                <%--success:function (msg) {--%>
                    <%--console.log("消息加载是否成功："+msg)--%>

                <%--}--%>
            <%--})--%>
            <%--location.reload();--%>
        <%--}--%>
    })
    function change(id) {
        $.ajax({
            url:"/reader?task=changeMessage&id="+id,
            dataType:"text",
            success:function (msg) {
                console.log("消息修改是否成功："+msg)
                location.reload();
            }
        })
    }
</script>
</body>
</html>

