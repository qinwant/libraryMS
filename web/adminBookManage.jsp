<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        $(function(){

            /*初始化*/
            var counter = 0; /*计数器*/
            var pageStart = 0; /*offset*/
            var pageSize = 4; /*size*/

            /*首次加载*/
            getData(pageStart, pageSize);
//            setInterval("getData(pageStart, pageSize)",2000);
//            $("#bookSearch").click(function () {
//                getData(pageStart, pageSize);
//            })


            /*监听加载更多*/
            $(document).on('click', '.js-load-more', function(){
                counter ++;
                pageStart = counter * pageSize;
                getData(pageStart, pageSize);
            });


        });
        function getData(offset,size){
            $.ajax({
                url:'/book',
                type:'post',
                data:{
                    "task":"showAll"
                },
                dataType:"json",
                success:function (msg) {
//                    alert(msg);
                    var bookList = eval(msg);
                    var sum = bookList.length;
//                    alert(bookList);
                    var html = "";
                    //页面拼接
                    if(sum - offset < size ){
                        size = sum - offset;
                    }
                    for (var i = offset; i < (offset+size); i++) {
                        html += "<tr>"
                        html += "<td>"
                        html += "<input type='checkbox' name='' lay-skin='primary'>"+bookList[i].id+"</td>"
                        html += "<td>《"+bookList[i].name+"》</td>"
                        html += "<td>"+bookList[i].bookCase+"</td>"
                        html += "<td><div class=\'layer-photos\'><img src=\'images/"+(bookList[i].photo==undefined?"default-reader-head.png":bookList[i].photo)+"\' alt=\'暂无缩略图\'></div></td>"
                        html += "<td>"+bookList[i].publisher+"</td>"
                        html += "<td>"+bookList[i].author+"</td>"
                        html += "<td>"+bookList[i].count+"</td>"
                        html += "<td>"+bookList[i].borrowed+"</td>"
                        html += "<td>"+(bookList[i].count-bookList[i].borrowed)+"</td>"
                        html += "<td>"+bookList[i].hot+"</td>"
                        html += "<td class='td-manage'>"
                        html += "<a title='查看' onclick='xadmin.open(&apos;编辑&apos;,&apos;book-edit.jsp?id="+bookList[i].id+"&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe63c;</i></a>"
                        html += "<a title='删除' onclick='member_del(this,&apos;"+bookList[i].id+"&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe640;</i></a>"
                        html += "</td>"
                        html += "</tr>"
                    }
                    $(".bookMsg").append(html);
                    /*隐藏more按钮*/
                    if ( (offset + size) >= sum){
                        $(".js-load-more").hide();
                    }else{
                        $(".js-load-more").show();
                    }

                },
                error: function(xhr, type){
                    alert('Ajax error!');
                }
            })
        }
        /*监听搜索按钮*/
    </script>
</head>

<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">演示</a>
                <a>
                    <cite>导航元素</cite></a>
            </span>
    <%--<a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">--%>
        <%--<i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>--%>
    <%--</a>--%>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" >
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
    </a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5" action="/book?task=showAllForKey" name="form1" method="post">
                        <div class="layui-input-inline layui-show-xs-block" style="display: inline;float: left;">
                            <input class="layui-input" placeholder="图书名" name="bookName" id="bookName">
                        </div>
                        <div class="layui-input-inline layui-show-xs-block" style="display: inline; float: left;">
                            <input class="layui-input" placeholder="图书类型" name="bookCase" id="bookCase">
                        </div>
                        <div class="layui-input-inline layui-show-xs-block" style="display: inline;float: left;">
                            <input class="layui-input" placeholder="作者" name="bookAuthor" id="bookAuthor">
                        </div>
                        <button id = "bookSearch" class="layui-btn" lay-submit="" lay-filter="" onclick="document.form1.submit">
                            <i class="layui-icon">&#xe615;</i>
                        </button>

                </div>
                </form>
            </div>
            <div class="layui-card-header">
                <button class="layui-btn layui-btn-danger" onclick="delAll()">
                    <i class="layui-icon"></i>批量删除</button>
                <button class="layui-btn" onclick="xadmin.open('添加图书','./book-add.jsp',800,600)">
                    <i class="layui-icon"></i>图书添加</button></div>
            <div class="layui-card-body ">
                <table class="layui-table layui-form" lay-size="sm">
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
                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--<input type="checkbox" name="" lay-skin="primary"></td>--%>
                        <%--<td>《数据库管理》</td>--%>
                        <%--<td>类型1</td>--%>
                        <%--<td>16c4a7efce1b9d16274fe5bdf8deb48f8d546460.jpg</td>--%>
                        <%--<td>高等教育出版社</td>--%>
                        <%--<td>王珊</td>--%>
                        <%--<td>9</td>--%>
                        <%--<td>1</td>--%>
                        <%--<td>8</td>--%>
                        <%--<td>是</td>--%>
                        <%--<td class="td-manage">--%>
                            <%--<a title="查看" onclick="xadmin.open('编辑','order-add.jsp')" href="javascript:;">--%>
                                <%--<i class="layui-icon">&#xe63c;</i></a>--%>
                            <%--<a title="删除" onclick="member_del(this,'')" href="javascript:;">--%>
                                <%--<i class="layui-icon">&#xe640;</i></a>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
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

/*用户-停用*/
function member_stop(obj, id) {
    layer.confirm('确认要停用吗？',
        function(index) {

            if ($(obj).attr('title') == '启用') {

                //发异步把用户状态进行更改
                $(obj).attr('title', '停用');
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {
                    icon: 5,
                    time: 1000
                });

            } else {
                $(obj).attr('title', '启用');
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {
                    icon: 5,
                    time: 1000
                });
            }

        });
}

/*用户-删除*/
function member_del(obj, id) {
    layer.confirm('确认要删除吗？',
        function(index) {
            //发异步删除数据
            $.ajax({
                url:"/book?task=delBook&id="+id,
                type:"post",
                data:{
                  "task":"delBook",
                    "id":id,
                },
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
<%--
$(document).on('click','#bookSearch',function () {
            alert("监听listen search");
            /*
            获取各个参数（图书名、图书类型、作者、是否热门）
            */
            var bookname = document.getElementById("bookName").value;
            var bookcase = document.getElementById("bookCase").value;
            var bookauthor = document.getElementById("bookAuthor").value;
            alert(bookname,bookcase,bookauthor);
            $.ajax({
                url:'/book',
                type:'post',
                data:{
                    "task":"showAllForKey",
                    "bookName":bookname,
                    "bookCase":bookcase,
                    "bookAuthor":bookauthor
                },
                dataType:"text",
                success:function (msg) {
                    alert(msg);
                    var bookList = eval(msg);
                    var sum = bookList.length;
                    alert(bookList);
                    var html = "";
                    //页面拼接
                    if(sum - offset < size ){
                        size = sum - offset;
                    }
                    for (var i = offset; i < (offset+size); i++) {
                        html += "<tr>"
                        html += "<td>"
                        html += "<input type='checkbox' name='' lay-skin='primary'></td>"
                        html += "<td>《"+bookList[i].name+"》</td>"
                        html += "<td>"+bookList[i].bookCase+"</td>"
                        html += "<td>"+bookList[i].photo+"</td>"
                        html += "<td>"+bookList[i].publisher+"</td>"
                        html += "<td>"+bookList[i].author+"</td>"
                        html += "<td>"+bookList[i].count+"</td>"
                        html += "<td>"+bookList[i].borrowed+"</td>"
                        html += "<td>"+(bookList[i].count-bookList[i].borrowed)+"</td>"
                        html += "<td>"+bookList[i].hot+"</td>"
                        html += "<td class='td-manage'>"
                        html += "<a title='查看' onclick='xadmin.open(&apos;编辑&apos;,&apos;order-add.html&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe63c;</i></a>"
                        html += "<a title='删除' onclick='member_del(this,&apos;要删除的id&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe640;</i></a>"
                        html += "</td>"
                        html += "</tr>"
                    }
                    $(".bookMsg").append(html);
                    /*隐藏more按钮*/
                    if ( (offset + size) >= sum){
                        $(".js-load-more").hide();
                    }else{
                        $(".js-load-more").show();
                    }

                },
                error: function(xhr, type){
                    alert('Ajax error!');
                }
            })

        })

--%>
</html>

