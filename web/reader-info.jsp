<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/23
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>国科图书后台-基于X-admin2.2-layui</title>
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
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script src="js/jquery-1.8.3.min.js"></script>
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>

    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <%--实现加载更多分页功能--%>
    <script type="text/javascript">
        $(function(){
            /*初始化*/
            var counter = 0; /*计数器*/
            var pageStart = 0; /*offset*/
            var pageSize = 10; /*size*/

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
            $.ajax({
                url:'/reader',
                type:'post',
                data:{
                    "task":"showAll"
                },
                dataType:"json",
                success:function (msg) {
                    var readerList = eval(msg);
                    var sum = readerList.length;
                    var html = "";
                    //页面拼接
                    if(sum - offset < size ){
                        size = sum - offset;
                    }
                    for (var i = offset; i < (offset+size); i++) {
                        html += "<tr class='info'>"
                        html += "<td>"
                        html += "<input type='checkbox' name='id' value='3'  lay-skin='primary'></td>"
                        html += "<td>"+readerList[i].id+"</td>"
                        html += "<td>"+(readerList[i].name==undefined?"":readerList[i].name)+"</td>"
                        html += "<td>"+(readerList[i].sex==undefined?"":readerList[i].sex)+"</td>"
                        html += "<td>"+(readerList[i].age==undefined?"":readerList[i].age)+"</td>"
                        html += "<td><div class=\'layer-photos\'><img src=\'images/"+(readerList[i].photo==undefined?"":readerList[i].photo)+"\' alt=\'暂无缩略图\'></div></td>"
                        html += "<td>"+(readerList[i].tel==undefined?"":readerList[i].tel)+"</td>"
                        html += "<td>"+(readerList[i].mail==undefined?"":readerList[i].mail)+"</td>"
                        html += "<td>"+(readerList[i].password==undefined?"":readerList[i].password)+"</td>"
                        html += "<td class='td-status'>"
                        if(readerList[i].status == '正常'){
                            html += "<span class='layui-btn layui-btn-normal layui-btn-mini'>已启用</span></td>"
                        }else if(readerList[i].status == '锁定'){
                            html += "<span class='layui-btn layui-btn-disabled layui-btn-mini'>已停用</span></td>"
                        }else {
                            html += "<span class='layui-btn layui-btn-disabled layui-btn-mini'>未设置</span></td>"
                        }
                        html += "<td class='td-manage'>"
                        html += "<a onclick='member_stop(this,&apos;"+readerList[i].id+"&apos;)' href='javascript:;' title="+readerList[i].status+">"
                        html += "<i class='layui-icon'>&#xe601;</i>"
                        html += "</a>"

                        html += "<a title='修改密码' onclick='xadmin.open(&apos;修改密码&apos;,&apos;reader-password.jsp?id="+readerList[i].id+"&oldpass="+readerList[i].password+"&apos;,600,400)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe631;</i></a>"

                        html += "<a title='删除' onclick='member_del(this,&apos;"+readerList[i].id+"&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe640;</i></a>"
                        html += "</td>"
                        html += "</tr>"
                    }
                    $(".readerMsg").append(html);
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
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="userphone"  placeholder="请输入用户手机" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <button class="layui-btn"  lay-submit="" lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
                    <button class="layui-btn" onclick="xadmin.open('添加用户','reader-add.jsp',600,400)"><i class="layui-icon"></i>添加</button>
                </div>
                <div class="layui-card-body layui-table-body layui-table-main">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" lay-filter="checkall" name="" lay-skin="primary">
                            </th>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>性别</th>
                            <th>年龄</th>
                            <th>头像</th>
                            <th>手机</th>
                            <th>邮箱</th>
                            <th>密码</th>
                            <th>状态</th>
                            <th>操作</th></tr>
                        </thead>
                        <tbody class="readerMsg">
                            <%--这里动态添加用户信息--%>
                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body ">
                        <div class="js-load-more">加载更多</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['laydate','form'], function(){
        var laydate = layui.laydate;
        var  form = layui.form;
        //监听搜索框
        form.on('submit(search)',function (data) {
            console.log(data.field);
            $(".readerMsg").empty();//清空读者信息，准备重新加载
            $.ajax({
                url:'/reader',
                type:'post',
                data:{
                    "task":"queryByTel",
                    "tel":data.field.userphone
                },
                dataType:"json",
                success:function (msg) {
                    var reader = eval(msg);
                    var html = "";
                        html += "<tr class='info'>"
                        html += "<td>"
                        html += "<input type='checkbox' name='id' value='3'  lay-skin='primary'></td>"
                        html += "<td>"+reader.id+"</td>"
                        html += "<td>"+(reader.name==undefined?"":reader.name)+"</td>"
                        html += "<td>"+(reader.sex==undefined?"":reader.sex)+"</td>"
                        html += "<td>"+(reader.age==undefined?"":reader.age)+"</td>"
                        html += "<td><div class=\'layer-photos\'><img src=\'images/"+(reader.photo==undefined?"default-reader-head.png":reader.photo)+"\' alt=\'暂无缩略图\'></div></td>"
                        html += "<td>"+(reader.tel==undefined?"":reader.tel)+"</td>"
                        html += "<td>"+(reader.mail==undefined?"":reader.mail)+"</td>"
                        html += "<td>"+(reader.password==undefined?"":reader.password)+"</td>"
                        html += "<td class='td-status'>"
                        if(reader.status == '正常'){
                            html += "<span class='layui-btn layui-btn-normal layui-btn-mini'>已启用</span></td>"
                        }else if(reader.status == '锁定'){
                            html += "<span class='layui-btn layui-btn-disabled layui-btn-mini'>已停用</span></td>"
                        }else {
                            html += "<span class='layui-btn layui-btn-disabled layui-btn-mini'>未设置</span></td>"
                        }
                        html += "<td class='td-manage'>"
                        html += "<a onclick='member_stop(this,&apos;"+reader.id+"&apos;)' href='javascript:;' title="+reader.status+">"
                        html += "<i class='layui-icon'>&#xe601;</i>"
                        html += "</a>"
                        html += "<a title='修改密码' onclick='xadmin.open(&apos;修改密码&apos;,&apos;reader-password.jsp?id="+reader.id+"&oldpass="+reader.password+"&apos;,600,400)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe631;</i></a>"
                        html += "<a title='删除' onclick='member_del(this,&apos;"+reader.id+"&apos;)' href='javascript:;'>"
                        html += "<i class='layui-icon'>&#xe640;</i></a>"
                        html += "</td>"
                        html += "</tr>"
                    $(".readerMsg").append(html);
                    $(".js-load-more").hide();
                }
            })
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        })
        // 监听全选
        form.on('checkbox(checkall)', function(data){
            console.log("全选")
            if(data.elem.checked){
                $('tbody input').prop('checked',true);
            }else{
                $('tbody input').prop('checked',false);
            }
            form.render('checkbox');
        });
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
    function member_stop(obj,id){
        layer.confirm('确认要更改吗？',function(index){

            if($(obj).attr('title')=='正常'){

                //发异步把用户状态进行更改
                $.ajax({
                    url:"/reader",
                    type:"post",
                    data:{
                        "task":"readerLock",
                        "id":id
                    },
                    dataType:"text",
                    success:function (msg) {
                        console.log("msg:"+msg)
                    }
                })


                $(obj).attr('title','锁定')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!',{icon: 5,time:1000});

            }else{
                $.ajax({
                    url:"/reader",
                    type:"post",
                    data:{
                        "task":"readerUnLock",
                        "id":id
                    },
                    dataType:"text",
                    success:function (msg) {
                        console.log("msg:"+msg)
                    }
                })
                $(obj).attr('title','正常')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!',{icon: 5,time:1000});
            }

        });
    }

    /*用户-删除*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $.ajax({
                url:"/reader",
                type:"post",
                data:{
                    "task":"deleteById",
                    "id":id,
                },
                dataType:"text",
                success:function (msg) {
                    console.log("msg="+msg)
                }
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }



    function delAll (argument) {
        var ids = [];

        // 获取选中的id
        $('tbody input').each(function(index, el) {
            if($(this).prop('checked')){
                ids.push($(this).val())
            }
        });

        layer.confirm('确认要删除吗？'+ids.toString(),function(index){
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
</html>