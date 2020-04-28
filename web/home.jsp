<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/11
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty hotBooks}">
    <c:redirect url="/book?task=showBooks"></c:redirect>
</c:if>
<html>
<head>
    <meta charset="utf-8">
    <title>国科图书管理系统 by kingwan</title>
    <link rel="stylesheet" href="css/style1.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="css/xadmin.css" type="text/css" media="all">
    <link rel="stylesheet" href="css/font.css" type="text/css" media="all">
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <script src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        //图片滚动 调用方法 imgscroll({speed: 30,amount: 1,dir: "up"});
        $.fn.imgscroll = function(o){
            var defaults = {
                speed: 40,
                amount: 0,
                width: 1,
                dir: "left"
            };
            o = $.extend(defaults, o);

            return this.each(function(){
                var _li = $("li", this);
                _li.parent().parent().css({overflow: "hidden", position: "relative"}); //div
                _li.parent().css({margin: "0", padding: "0", overflow: "hidden", position: "relative", "list-style": "none"}); //ul
                _li.css({position: "relative", overflow: "hidden"}); //li
                if(o.dir == "left") _li.css({float: "left"});

                //初始大小
                var _li_size = 0;
                for(var i=0; i<_li.size(); i++)
                    _li_size += o.dir == "left" ? _li.eq(i).outerWidth(true) : _li.eq(i).outerHeight(true);

                //循环所需要的元素
                if(o.dir == "left") _li.parent().css({width: (_li_size*3)+"px"});
                _li.parent().empty().append(_li.clone()).append(_li.clone()).append(_li.clone());
                _li = $("li", this);

                //滚动
                var _li_scroll = 0;
                function goto(){
                    _li_scroll += o.width;
                    if(_li_scroll > _li_size)
                    {
                        _li_scroll = 0;
                        _li.parent().css(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll });
                        _li_scroll += o.width;
                    }
                    _li.parent().animate(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll }, o.amount);
                }

                //开始
                var move = setInterval(function(){ goto(); }, o.speed);
                _li.parent().hover(function(){
                    clearInterval(move);
                },function(){
                    clearInterval(move);
                    move = setInterval(function(){ goto(); }, o.speed);
                });
            });
        };
        //友情链接下拉框跳转弹出新窗口
        function frlink(selObj){
            window.open(selObj.options[selObj.selectedIndex].value);}
    </script>
</head>

<body>
<div id="hearder2" class="clearfix">
    <div class="logo">
        <img src="images/libraryLogo1.png">
    </div>
    <div class="logo-name">图书管理中心</div>
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
<!-- index1-div1 -->
<div id="index1-div1" class="clearfix">
    <div class="index1-left675">
        <div class="title-box">项目简介<a href="detail-project.jsp" class="title-more" title="查看更多"><img src="images/12.gif"></a></div>
        <p><img src="images/project.png" align="left">本项目为图书管理系统前台项目，采用servlet+jsp技术，实现对游客和读者的书籍服务功能，是一个简单的j2ee项目，对于初级学习j2ee的同学来说，具有参考意义...<a href="detail-project.jsp">查看更多...</a></p>
    </div>
    <div class="index1-right300">
        <div class="title-box">通知公告<a href="message.jsp" class="title-more" title="查看更多"><img src="images/12.gif"></a></div>
        <ul>
            <li><a href="message.jsp">通知公告:置顶消息</a><span>2020-04-25</span></li>
            <li><a href="message.jsp">通知公告:您借阅的书籍《三体》未归还...</a><span>2020-04-26</span></li>
            <li><a href="message.jsp">通知公告：待完善功能</a><span>2020-04-23</span></li>
        </ul>
    </div>
</div>
<!-- index1-div2 -->
<div id="index1-div2" class="clearfix">
    <div class="index1-left675">
        <div class="search-box1">
            <form name="form1" action="/book?task=queryForKey" method="post">
                <input type="text" name="textfield" id="textfield" class="input-text" placeholder="图书搜索关键词" style="font-size: 1.875rem; color: gray;">
                <input type="image" src="images/search1.png" class="input-submit" onclick="document.form1.submit" style="height: 78px"/>
            </form>
        </div>
        <!-- slider -->
        <div class="index1-pic-gun">
            <div class="title-box">热门借阅</div>
            <div class="index1-scrollleft clearfix">
                <ul>
                    <c:forEach items="${hotBooks}" var="book">
                        <li>
                            <a href="/book?task=bookDet&id=${book.id}"><img alt="${book.name}" src="images/${book.photo}"/></a>
                            <span>${book.name}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <script type="text/javascript">
                $(document).ready(function(){

                    $(".index1-scrollleft").imgscroll({
                        speed: 40,    //图片滚动速度
                        amount: 0,    //图片滚动过渡时间
                        width: 1,     //图片滚动步数
                        dir: "left"   // "left" 或 "up" 向左或向上滚动
                    });

                });
            </script>
        </div>
        <!-- slider end -->
    </div>
    <div class="index1-right300">
        <div class="index1-list-menu">
            <div class="title-box">应用服务</div>
            <ul>
                <li><a class="layui-btn" href="personal.jsp">个人中心</a></li>
                <li><a class="layui-btn" href="showHot.jsp">好书推荐</a></li>
                <li><a class="layui-btn" id="pop" >借阅须知</a></li>
                <li><a class="layui-btn" href="message.jsp">通知消息</a></li>
                <li><a class="layui-btn" id="wait">待开发功能</a></li>
            </ul>
        </div>
    </div>
</div>
<!-- div5 -->
<div id="div6">Copyright &copy; 2020 design by kingwan 关于作者：<a href="https://qinwant.github.io/" target="_blank">kingwan的技术博客</a></div>
<script>
    layui.use(['layer'], function(){ //独立版的layer无需执行这一句
        $ = layui.$;
        var layer = layui.layer; //独立版的layer无需执行这一句
        $("#pop").click(function(){
            layer.open({
                type: 1
                ,title: false //不显示标题栏
                ,closeBtn: false
                ,area: '500px;'
                ,shade: 0.8
                ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                ,btn: ['我已了解']
                ,btnAlign: 'c'
                ,moveType: 1 //拖拽模式，0或者1
                ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">亲爱的读者用户：<br>您好！<br><br>为了营造良好的借阅氛围，请遵守借阅公约！<br><br>1、请及时归还借阅书籍<br>2、对于屡次不归还书籍者会进行封号处理！<br><br>希望我们此后在书籍的海洋里徜徉 ^_^</div>'

            });
        });
        $("#wait").click(function(){
//            layer.open({
//                type: 1
//                ,content: '<div style="padding: 20px 100px;">待开发功能<br>1、读者留言<br>2、图书评论</div>'
//                ,btn: '我知道了'
//                ,btnAlign: 'c' //按钮居中
//                ,shade: 0.5 //不显示遮罩
//            });
            layer.msg('待开发功能<br>1、读者留言<br>2、图书评论', {
                time: 20000, //20s后自动关闭
                btn: [ '知道了'],
                closeBtn:false
            });
        });
    });
</script>
</body>
</html>

