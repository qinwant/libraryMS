<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html class="x-admin-sm">

<head>
    <meta charset="UTF-8">
    <title>国科图书后台-基于X-admin2.2-layui</title>
    <%--kingwan--%>
    <style type="text/css">
        .js-load-more{
            padding:0 15px;
            width:120px;
            height:30px;
            background-color:#D31733;
            color:#fff;
            line-height:30px;
            text-align:center;
            border-radius:5px;
            margin:20px auto;
            border:0 none;
            font-size:16px;
            display:none;/*默认不显示，ajax调用成功后才决定显示与否*/
        }
    </style>
    <%--kingwan--%>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <script type="text/javascript">
        /*用户-删除*/
        function member_del(obj, id) {
            layer.confirm('确认要删除吗？',
                function(index) {
                    //发异步删除数据
                    $.ajax({
                        url:"/borrow?task=delRecord&id="+id,
                        type:"post",
                        dataType:"text",
                        success:function (msg) {

                            console.log(msg+":删除成功")
                        }
                    })
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!', {
                        icon: 1,
                        time: 1000
                    });
                });
        }
        /*用户-提醒还书*/
        function member_remind(obj,name,time,phone) {
            layer.confirm('确认要发送提醒？',
                function(index) {
                    //发异步删除数据
                    $.ajax({
                        url:"/admin?task=remind",
                        data:{
                            "bookName":name,
                            "returnTime":time,
                            "readerTel":phone,
                            "adminTel":'${sessionScope.adminCurrent.adminTel}',
                        },
                        dataType:"text",
                        type:"post",
                        success:function (msg) {
                            console.log("msg:"+msg)

                        }
                    })
                    layer.msg('已提醒!', {
                        icon: 1,
                        time: 1000
                    });
                });
        }
        function a(obj,name,time,phone){

        }

    </script>

</head>

<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="index.jsp">首页</a>
                <a href="">演示</a>
                <a>
                    <cite>导航元素</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="window.location.href='recordList.jsp'" title="返回">
        <i class="layui-icon layui-icon-return" style="line-height:30px"></i>
    </a>

</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()">
                        <i class="layui-icon"></i>批量删除</button>
                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name="" lay-skin="primary">
                            </th>
                            <th>图书ID</th>
                            <th>图书名</th>
                            <th>借阅人</th>
                            <th>联系方式</th>
                            <th>借阅时间</th>
                            <th>归还截止</th>
                            <th>是否归还</th>
                            <th>是否续借</th>
                            <th>操作</th></tr>
                        </thead>
                        <tbody class="recordkMsg">
                        <c:forEach items="${records}" var="record">
                            <tr>
                                <td>
                                    <input type="checkbox" name="" lay-skin="primary"></td>
                                <td>${record.bookId}</td>
                                <td>《${record.bookName}》</td>
                                <td>${record.readerName}</td>
                                <td>${record.readerTel}</td>
                                <td><fmt:formatDate type="both" value="${record.borrowTime}"/></td>
                                <td><fmt:formatDate type="both" value="${record.returnTimePre}"/></td>
                                <c:choose>
                                    <c:when test="${record.isReturn eq 'yes'}">
                                        <td>是</td>
                                    </c:when>
                                    <c:when test="${record.isReturn eq 'no'}">
                                        <td>否</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${record.isReturn}</td>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${record.isRenew eq 'yes'}">
                                        <td>是</td>
                                    </c:when>
                                    <c:when test="${record.isRenew eq 'no'}">
                                        <td>否</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${record.isRenew}</td>
                                    </c:otherwise>
                                </c:choose>
                                <td class="td-manage">
                                    <a title="删除" onclick="member_del(this,${record.id})" href="javascript:;">
                                        <i class="layui-icon">&#xe640;</i></a>
                                    <%--<a title="发送归还提醒" onclick="member_remind(this,${record.bookName},${record.returnTimePre},${record.readerTel})" href="javascript:;">--%>
                                        <%--<i class="layui-icon">&#xe642;</i></a>--%>
                                    <%--<a title="提醒" onclick="member_remind(this,'${record.bookName}','${record.returnTimePre}','${record.readerTel}')" href="javascript:;">--%>
                                        <%--<i class="layui-icon">&#xe642;</i></a>--%>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="js-load-more">加载更多</div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<script>layui.use(['laydate', 'form'],
    function() {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

</script>
</html>

