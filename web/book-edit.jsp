<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 15:48
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
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>

</head>

<body>
<%
    String bookid = (String)request.getParameter("id");//直接传递
%>
<script type="text/javascript">
    $(function () {

        var request = new Object();
        request = GetRequest();
        var bookid;
        bookid = request["id"];
        console.log("bookid="+bookid)
        $.ajax({
            url:'/book?task=updateBook&id='+bookid,
            type:'post',
            dataType:'json',
            success:function (data) {
                console.log("data="+data)
                console.log("id=="+data.id)
                $('#addId').val(data.id);  //往input框里传值
                $('#addName').val(data.name);  //往input框里传值
                $('#addBookCase').val(data.bookCase);  //往input框里传值
                $('#addPhoto').val(data.photo);  //往input框里传值
                $('#addPublisher').val(data.publisher);  //往input框里传值
                $('#addAuthor').val(data.author);  //往input框里传值
                $('#addCount').val(data.count);  //往input框里传值
                $('#addHot').val(data.hot);  //往input框里传值
//                $("#addHot").find("option[value='"+data.hot+"']").attr("selected",true);

//                var html = "";
//                html += "<form class='layui-form' method='post' enctype='multipart/form-data'>"
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addId' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>图书ID</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input style='background:#CCCCCC' disabled='true' type='text' id='addId' name='addId'  value="+data.id+" required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addName' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>图书名</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input type='text' id='addName' name='addName' value="+data.name+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addBookCase' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>图书类型</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input type='text' id='addBookCase' name='addBookCase' value="+data.bookCase+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addPhoto' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>图片</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input style='background: #CCCCCC' disabled='true' type='text' id='addPhoto' name='addPhoto'  value="+data.photo+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addPublisher' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>出版社</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input type='text' id='addPublisher' name='addPublisher' value="+data.publisher+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addAuthor' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>作者</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input type='text' id='addAuthor' name='addAuthor' value="+data.author+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addCount' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>数量</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input type='text' id='addCount' name='addCount' value="+data.count+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='addHot' class='layui-form-label'>"
//                html += "<span class='x-red'>*</span>热门</label>"
//                html += "<div class='layui-input-inline'>"
//                html += "<input type='text' id='addHot' name='addHot'  value="+data.hot+"  required='' lay-verify='required' autocomplete='off' class='layui-input'></div>"
//                html += "</div>"
//
//                html += "<div class='layui-form-item'>"
//                html += "<label for='L_repass' class='layui-form-label'></label>"
//                html += "<button class='layui-btn' lay-filter='add' lay-submit='' id='add'>修改</button></div>"
//                html += " </form>"
//
//                $(".layui-row").append(html);
            },
            error : function(data) {
                    alert("error:" + data.responseText);
            }

        })
        layui.use('form', function(){
            var form = layui.form;
            var $ = layui.$;
            form.render('select', 'test2'); //更新 lay-filter="test2" 所在容器内的全部 select 状态

        });


        //获得请求参数
        function GetRequest() {
            var url = location.search; //获取url中"?"符后的字串
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for(var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
                }
            }
            return theRequest;
        }
    })
</script>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form" method="post" id="edit-form" >
            <div class="layui-form-item">
                <label for="addId" class="layui-form-label">
                    <span class="x-red">*</span>图书ID</label>
                <div class="layui-input-inline">
                    <input style='background: #CCCCCC' readonly='readonly' type="text" id="addId" name="addId"  required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addName" class="layui-form-label">
                    <span class="x-red">*</span>图书名</label>
                <div class="layui-input-inline">
                    <input type="text" id="addName" name="addName" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addBookCase" class="layui-form-label">
                    <span class="x-red">*</span>图书类型</label>
                <div class="layui-input-inline">
                    <input type="text" id="addBookCase" name="addBookCase" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addPhoto" class="layui-form-label">
                    <span class="x-red">*</span>图片</label>
                <div class="layui-input-inline">
                    <input style='background: #CCCCCC' disabled='true' type="text" id="addPhoto" name="addPhoto" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addPublisher" class="layui-form-label">
                    <span class="x-red">*</span>出版社</label>
                <div class="layui-input-inline">
                    <input type="text" id="addPublisher" name="addPublisher" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addAuthor" class="layui-form-label">
                    <span class="x-red">*</span>作者</label>
                <div class="layui-input-inline">
                    <input type="text" id="addAuthor" name="addAuthor" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addCount" class="layui-form-label">
                    <span class="x-red">*</span>数量</label>
                <div class="layui-input-inline">
                    <input type="text" id="addCount" name="addCount" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="addHot" class="layui-form-label">
                    <span class="x-red">*</span>热门</label>
                <div class="layui-input-inline">
                    <input type="text" id="addHot" name="addHot" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="add" lay-submit="" id="add">修改</button></div>
        </form>
    </div>
</div>
<script>layui.use(['form', 'layer'],
    function() {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;
        //监听提交
        $("#add").click(function(){
            var name = document.getElementById("addName").value;
//            var bookCase = document.getElementById("addBookCase").value;
//            var publisher = document.getElementById("addPublisher").value;
//            var author = document.getElementById("addAuthor").value;
//            var count = document.getElementById("addCount").value;
//            var hot = document.getElementById("addHot").value;
//            var id = document.getElementById("addId").value;
            $(".layui-form").ajaxSubmit({
                url : "/book?task=updateBookAfter",
                type : "post",
                dataType : 'text',
                success : function(responseText){    // 成功后的回调函数(返回数据由responseText获得)
                    console.log("回调成功："+responseText)
                },
                error : function(responseText) {
                    alert("error:" + responseText);
                }

            });

            layer.alert("修改成功", {
                    icon: 6
                },
                function() {
                    // 获得frame索引
                    var index = parent.layer.getFrameIndex(window.name);
                    //关闭当前frame
                    parent.layer.close(index);
                });

            return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
        })

    });</script>

</body>

</html>
