package com.kingwan.controller;

import com.kingwan.entity.Admin;
import com.kingwan.entity.Message;
import com.kingwan.service.AdminService;
import com.kingwan.service.impl.AdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * Created by kingwan on 2020/4/12.
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    AdminService adminService = new AdminServiceImpl();
    Admin admin = new Admin();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String task = req.getParameter("task");
        switch (task){
            case "login"://登陆
                //构造admin
                admin = new Admin();
                String em = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";//邮箱正则
                String ph = "^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,5-9]))\\d{8}$"; //java用验证手机号
                String user = req.getParameter("user");
                String pwd = req.getParameter("pwd");
                admin.setAdminPassword(pwd);
                if(user.matches(em)){
                    admin.setAdminMail(user);
                }else if(user.matches(ph)){
                    admin.setAdminTel(user);
                }else {
                    admin.setAdminName(user);
                }
                //登陆校验
                Admin adminCurrent = adminService.login(admin);
                //校验结果
                if(adminCurrent!=null){
                    HttpSession session = req.getSession();
                    session.setAttribute("adminCurrent",adminCurrent);
                    resp.sendRedirect("index.jsp");
                    //req.getRequestDispatcher("index.jsp").forward(req,resp);
                }else {
                    resp.getWriter().write("<script>alert('登陆失败！'); window.location='login.jsp' </script>");
                }
                break;

            case "registered"://注册
                //构造reader
                String phone = req.getParameter("phone");
                String userName =  req.getParameter("user");
                String password = req.getParameter("pwd");
                admin = new Admin();
                admin.setAdminTel(phone);
                admin.setAdminName(userName);
                admin.setAdminPassword(password);
                //注册前校验
                if(adminService.queryByTel(phone)>0){
                    resp.getWriter().write("<script>alert('该手机号已被注册！'); window.location='login_admin.jsp' </script>");
                }else {
                    //插入注册
                    int registered = adminService.registered(admin);
                    if(registered>0){
                        req.getRequestDispatcher("login_admin.jsp").forward(req,resp);
                    }else {
                        resp.getWriter().write("<script>alert('注册失败！'); window.location='login_admin.jsp' </script>");
                    }
                }
                break;
            case "logout"://管理员退出
                HttpSession httpSession = req.getSession();
                httpSession.invalidate();//销毁
                resp.getWriter().print("退出成功！");

                break;
            case "verifyPass"://确认旧密码
                String adminTel = req.getParameter("phone");
                String oldpass = req.getParameter("oldpass");
                if(adminService.verifyPass(adminTel,oldpass)!=null){
                    //密码验证成功
                    resp.getWriter().print("密码验证成功！");
                }else {
                    //密码验证失败
                    resp.getWriter().print("密码验证失败！");
                }
                break;
            case "changeInfo":
                String tel = req.getParameter("adminTel");
                String newpass = req.getParameter("adminPassword");
                String mail = req.getParameter("adminMail");
                String name = req.getParameter("adminName");
                admin = new Admin();
                admin.setAdminTel(tel);
                admin.setAdminPassword(newpass);
                admin.setAdminMail(mail);
                admin.setAdminName(name);
                if(adminService.changInfo(admin)>0){
                    resp.getWriter().print("密码更改成功！");
                }else {
                    resp.getWriter().print("密码更改失败");
                }
                break;
            case "remind"://提醒用户还书
                String bookName = req.getParameter("bookName");
                String returnTime = req.getParameter("returnTime");
                String readerTel = req.getParameter("readerTel");
                String admintel = req.getParameter("adminTel");
                long longtime = Long.parseLong(returnTime);
                Date date = new Date(longtime);
                Message message = new Message();
                message.setBookName(bookName);
                message.setReturnTime(date);
                message.setReaderTel(readerTel);
                message.setAdminTel(admintel);
                if(adminService.remind(message)>0){
                    //提醒成功
                    resp.getWriter().print("提醒成功！");
                }else {
                    //提醒失败
                    resp.getWriter().print("提醒失败！");
                }
                break;
            default:
                System.out.println("测试");
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}

