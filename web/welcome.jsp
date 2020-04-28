<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>国科图书后台-基于X-admin2.2-layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
        $(function () {
            <%--alert('${infodata}')--%>
            <%--if('${infodata}'==''){--%>
                <%--$.ajax({--%>
                    <%--url:"/info",--%>
                    <%--type:"get",--%>
                    <%--dataType:"json",--%>
                    <%--success:function (msg) {--%>
                        <%--console.log("msg="+msg)--%>
                        <%--location.reload()--%>
                    <%--}--%>

                <%--})--%>

            <%--}--%>
            $.ajax({
                url:"/info",
                type:"get",
                dataType:"json",
                success:function (msg) {
                    console.log("msg="+msg)

                }

            })
            if('${infodata}'==''){
                location.reload()
            }

        })
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <blockquote class="layui-elem-quote">欢迎管理员：
                        <span class="x-red">${sessionScope.adminCurrent.adminName}</span>！<div id="timeShow"></div>
                    </blockquote>
                </div>
            </div>
        </div>
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">数据统计</div>
                <div class="layui-card-body ">
                    <ul class="layui-row layui-col-space10 layui-this x-admin-carousel x-admin-backlog">
                        <li class="layui-col-md2 layui-col-xs6">
                            <a href="javascript:;" class="x-admin-backlog-body">
                                <h3>图书数</h3>
                                <p>
                                    <cite>${infodata.books}</cite></p>
                            </a>
                        </li>
                        <li class="layui-col-md2 layui-col-xs6">
                            <a href="javascript:;" class="x-admin-backlog-body">
                                <h3>读者数</h3>
                                <p>
                                    <cite>${infodata.readers}</cite></p>
                            </a>
                        </li>
                        <li class="layui-col-md2 layui-col-xs6">
                            <a href="javascript:;" class="x-admin-backlog-body">
                                <h3>管理员数</h3>
                                <p>
                                    <cite>${infodata.admins}</cite></p>
                            </a>
                        </li>
                        <li class="layui-col-md2 layui-col-xs6">
                            <a href="javascript:;" class="x-admin-backlog-body">
                                <h3>累计借书次数</h3>
                                <p>
                                    <cite>${infodata.borrows}</cite></p>
                            </a>
                        </li>
                        <li class="layui-col-md2 layui-col-xs6">
                            <a href="javascript:;" class="x-admin-backlog-body">
                                <h3>累计续借次数</h3>
                                <p>
                                    <cite>${infodata.renews}</cite></p>
                            </a>
                        </li>
                        <li class="layui-col-md2 layui-col-xs6 ">
                            <a href="javascript:;" class="x-admin-backlog-body">
                                <h3>待开发</h3>
                                <p>
                                    <cite></cite></p>
                            </a>
                        </li>
                    </ul>

                </div>
                <div class="layui-fluid">
                    <div class="layui-row layui-col-space15">
                        <div class="layui-col-sm12 layui-col-md6">
                            <div class="layui-card">
                                <div class="layui-card-header">图表数据</div>
                                <div class="layui-card-body" style="min-height: 280px;">
                                    <div id="main3" class="layui-col-sm12" style="height: 300px;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</div>
</body>
<script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts.min.js"></script>
<script type="text/javascript">
    var bookCount =  '${infodata.books}';//图书总量
    var bookBorrows = '${infodata.borrows}';//累计借阅
    var readers = '${infodata.readers}';//读者数
    var renewCount = '${infodata.renews}';//累计续借

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main3'));
    // 指定图表的配置项和数据
    var option = {
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['图书总量','累计借阅','读者数','累计续借']
        },
        series : [
            {
                name: '数据统计',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    {value:bookCount, name:'图书总量'},
                    {value:bookBorrows, name:'累计借阅'},
                    {value:readers, name:'读者数'},
                    {value:renewCount, name:'累计续借'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
<script>
    var t=null;
    t=setTimeout(time,1000);   //设置定时器，一秒刷新一次
    function time(){
        clearTimeout(t);  //清楚定时器
        dt=new Date();
        var y=dt.getYear()+1900;
        var m=dt.getMonth()+1;
        var d=dt.getDate();
        var weekday=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
        var day=dt.getDay();
        var h=dt.getHours();
        var min=dt.getMinutes();
        var s=dt.getSeconds();
        if(h<10){
            h="0"+h;
        }
        if(min<10){
            min="0"+min;
        }
        if(s<10){
            s="0"+s;
        }
        document.getElementById("timeShow").innerHTML= y + "年" + m + "月" + d + "日" + weekday[day] + "" + h + ":" + min + ":" + s + "";
        t = setTimeout(time, 1000);
    }
</script>
</html>
