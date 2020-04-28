<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/27
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>MarkDown</title>
    <script type="text/javascript" src="./js/showdown.min.js"></script>
</head>
<style>
    /* body {
      font-family: "Helvetica Neue", Helvetica, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif;
     font-size: 16px;
      line-height: 1.42857143;
      color: #333;
      background-color: #fff;
    } */
    ul li {
        line-height: 24px;
    }
    blockquote {
        border-left:#eee solid 5px;
        padding-left:20px;
    }
    code {
        /* color:#D34B62; */
        /* background: #F9F2F4; */
        font-weight: bold;
        color:#E6162D;
        background: #F9F2F4;
    }
</style>
<body>
<div>
    <textarea id="content" style="height:400px;width:600px;display:none;" onkeyup="compile()">
# 国科J2EE项目-图书管理系统

#### 前言说明
1. 作者：[kingwan](https://qinwant.github.io/)
2. 项目制作耗时：3周

#### 项目开发说明

1. 运行及开发环境
   - `MySQL8.0`+`Tomcat9.0`+`IDEA`
2. 数据库说明
   - 连接账号：root
   - 连接密码：toor
   - 已配置c3p0连接池，请根据计算机性能自行设置参数
3. web技术说明
   - 前端技术：`html`、`css`、`jQuery`、`JavaScript`、`layui`
   - 后端技术：`servlet`、`jsp`
   - 数据处理：`json`

#### 项目功能说明

###### 前台功能

1. 游客
   - 热门书籍浏览
   - 图书搜索
   - 登陆、注册
   - 公告查看 *未完成*
2. 读者用户
   - 登陆、注册（唯一性校验）、注销
   - 个人信息查看、修改
   - 书籍借阅、归还、续借
   - 借阅记录浏览、删除
   - 消息接收

###### 后台功能

1. 管理员登陆、注册、注销
2. 图书系统信息总览**数据可视化**
3. 读者管理
   - 读者信息添加、修改、删除
   - 按手机号查询读者
   - 读者信息导出Excel或CSV
   - 读者权限封禁管理
4. 图书管理
   - 图书录入、修改、删除
   - 按图书信息模糊查询
   - 图书借阅信息管理
5. 管理员管理
   - 功能暂未开发

	</textarea>
    <div id="result"></div>

</div>
<script type="text/javascript">
    var text = document.getElementById("content").value;
    var converter = new showdown.Converter();
    var html = converter.makeHtml(text);
    document.getElementById("result").innerHTML = html;
</script>
</body>
</html>
