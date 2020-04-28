<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</head>

<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="index.jsp">首页</a>
                <a href="index.jsp">演示</a>
                <a>
                    <cite>导航元素</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="window.location.href='adminBookManage.jsp'" title="返回">
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
                <button class="layui-btn" onclick="xadmin.open('添加图书','./book-add.jsp',800,600)">
                    <i class="layui-icon"></i>图书添加</button></div>
            <div class="layui-card-body ">
                <table class="layui-table layui-form">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" name="" lay-skin="primary">
                        </th>
                        <th>书名</th>
                        <th>类型</th>
                        <th>照片</th>
                        <th>出版社</th>
                        <th>作者</th>
                        <th>总数</th>
                        <th>已借</th>
                        <th>库存</th>
                        <th>是否热门图书</th>
                        <th>操作</th></tr>
                    </thead>
                    <tbody class="bookMsg">
                    <c:forEach items="${books}" var="book">
                        <tr>
                            <td>
                                <input type="checkbox" name="" lay-skin="primary"></td>
                            <td>《${book.name}》</td>
                            <td>${book.bookCase}</td>
                            <%--<td>${book.photo}</td>--%>
                            <td><div class="layer-photos"><img src="images/${book.photo eq 'undefined'?'default-reader-head.png':book.photo}" alt="暂无缩略图"></div></td>
                            <td>${book.publisher}</td>
                            <td>${book.author}</td>
                            <td>${book.count}</td>
                            <td>${book.borrowed}</td>
                            <td>${book.count - book.borrowed}</td>
                            <td>${book.hot}</td>
                            <td class="td-manage">
                                <a title="查看" onclick="xadmin.open('编辑','book-edit.jsp?id=${book.id}')" href="javascript:;">
                                    <i class="layui-icon">&#xe63c;</i></a>
                                <a title="删除" onclick="member_del(this,'')" href="javascript:;">
                                    <i class="layui-icon">&#xe640;</i></a>
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


/*用户-删除*/
function member_del(obj, id) {
    layer.confirm('确认要删除吗？',
        function(index) {
            //发异步删除数据
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {
                icon: 1,
                time: 1000
            });
        });
}

function delAll(argument) {

    var data = tableCheck.getData();

    layer.confirm('确认要删除吗？' + data,
        function(index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {
                icon: 1
            });
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
}</script>
</html>

