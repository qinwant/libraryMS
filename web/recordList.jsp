<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/21
  Time: 23:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="x-admin-sm">

<head>
    <meta charset="UTF-8">
    <title>国科图书后台-基于X-admin2.2-layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <script src="js/jquery-1.8.3.min.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
        $(function(){

            /*初始化*/
            var counter = 0; /*计数器*/
            var pageStart = 0; /*offset*/
            var pageSize = 8; /*size*/

            /*首次加载*/
            getData(pageStart, pageSize);

            /*监听加载更多*/
            $(document).on('click', '.js-load-more', function(){
                counter ++;
                pageStart = counter * pageSize;
                getData(pageStart, pageSize);
            });


        });
        function getData(offset,size){
//            alert("开始加载")
            $.ajax({
                url:'/borrow',
                type:'post',
                data:{
                    "task":"showAll"
                },
                dataType:"json",
                success:function (msg) {
//                    alert(msg);
                    var borrowList = eval(msg);
                    var sum = borrowList.length;
                    //                    alert(bookList);
                    var html = "";
                    //页面拼接
                    if(sum - offset < size ){
                        size = sum - offset;
                    }
                    for (var i = offset; i < (offset+size); i++) {
                        html += "<tr>"
                        html += "<td>"
                        html += "<input type='checkbox' name='' lay-skin='primary'></td>"
                        html += "<td>"+borrowList[i].bookId+"</td>"
                        html += "<td>"+borrowList[i].bookName+"</td>"
                        html += "<td>"+borrowList[i].readerName+"</td>"
                        html += "<td>"+borrowList[i].readerTel+"</td>"
                        var borrowlongtime =  borrowList[i].borrowTime;
                        var borrowdate = new Date(borrowlongtime);
                        var borrowtime = borrowdate.toLocaleString();
                        html += "<td>"+borrowtime+"</td>"
//                        html += "<td>"+borrowList[i].borrowTime+"</td>"
                        var returnlongtime =  borrowList[i].returnTimePre;
                        var returndate = new Date(returnlongtime);
                        var returntime = returndate.toLocaleString();
                        html += "<td>"+returntime+"</td>"
//                        html += "<td>"+borrowList[i].returnTimePre+"</td>"
                        html += "<td>"+(borrowList[i].isReturn=='yes'?'是':'否')+"</td>"
                        html += "<td>"+(borrowList[i].isRenew=='yes'?'是':'否')+"</td>"
                        html += "<td class='td-manage'>"
                        html += "<a title='删除' onclick='member_del(this,&apos;"+borrowList[i].id+"&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe640;</i></a>"
                        html += "<a title='发送归还提醒' onclick='member_remind(this,&apos;"+borrowList[i].bookName+"&apos;,&apos;"+borrowList[i].returnTimePre+"&apos;,&apos;"+borrowList[i].readerTel+"&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe642;</i></a>"
                        html += "</td>"
                        html += "</tr>"

                    }
                    $(".recordMsg").append(html);
                    /*隐藏more按钮*/
                    if ( (offset + size) >= sum){
                        $(".js-load-more").hide();
                    }else{
                        $(".js-load-more").show();
                    }

                },
                error: function(xhr, type){
                    alert('Ajax error!');
                },
            })
        }
        /*日期格式化*/

    </script>

</head>
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
        /*display:none;!*默认不显示，ajax调用成功后才决定显示与否*!*/
    }
</style>
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">演示</a>
                <a>
                    <cite>导航元素</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
    </a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">

        <div class="layui-col-md12">

            <div class="layui-card">
                <div class="layui-card-body ">
                    <div class="layui-collapse" lay-filter="test">
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">条件筛选<i class="layui-icon layui-colla-icon"></i></h2>
                            <div class="layui-colla-content">
                                <form class="layui-form" action="/borrow?task=recordSearch" method="post" name="recordForm">
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">图书ID</label>
                                            <div class="layui-input-inline" style="width: 100px;">
                                                <input type="text" name="bookId" placeholder="" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">图书名</label>
                                            <div class="layui-input-inline" style="width: 100px;">
                                                <input type="text" name="bookName" placeholder="" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">读者姓名</label>
                                            <div class="layui-input-inline" style="width: 100px;">
                                                <input type="text" name="readerName" placeholder="" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">读者电话</label>
                                            <div class="layui-input-inline" style="width: 100px;">
                                                <input type="text" name="readerTel" placeholder="" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">复选框</label>
                                        <div class="layui-input-block">
                                            <input type="checkbox" name="isReturn" value="yes" title="已归还">
                                            <input type="checkbox" name="isBorrow" value="yes" title="未归还" >
                                            <input type="checkbox" name="isRenew" value="yes" title="续借">
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit="" lay-filter="" onclick="document.recordForm.submit">立即提交</button>
                                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()">
                        <i class="layui-icon"></i>
                        批量删除
                    </button>
                </div>
                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name="" lay-skin="primary"></th>
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
                        <tbody class="recordMsg">

                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body ">
                    <div class="page">
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

/*用户-删除*/
function member_del(obj, id) {
    layer.confirm('确认要删除吗？',
        function(index) {
            //发异步删除数据
            $.ajax({
                url:"/borrow",
                data:{
                    "task":"delRecord",
                    "id":id,
                },
                type:"post",
                dataType:"text",
                success:function (msg) {
                    console.log("记录删除："+msg)
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
    console.log("书名："+name+"读者电话："+phone+"归还时间"+time+"管理员电话"+'${sessionScope.adminCurrent.adminTel}')
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
