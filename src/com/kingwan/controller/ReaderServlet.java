package com.kingwan.controller;

import com.google.gson.Gson;
import com.kingwan.entity.Borrow;
import com.kingwan.entity.Message;
import com.kingwan.entity.Reader;
import com.kingwan.service.ReaderService;
import com.kingwan.service.impl.ReaderServiceImpl;
import com.kingwan.utils.GokJDBCUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by kingwan on 2020/4/12.
 */
@WebServlet("/reader")
public class ReaderServlet extends HttpServlet {
    ReaderService readerService = new ReaderServiceImpl();
    Reader reader = null;
    Reader readerCurrent = null;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String task = req.getParameter("task");
        switch (task){
            case "login"://登陆
                //构造reader
                reader = new Reader();
                String em = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";//邮箱正则
                String ph = "^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,5-9]))\\d{8}$"; //java用验证手机号
                String user = req.getParameter("user");
                String pwd = req.getParameter("pwd");
                reader.setPassword(pwd);
                if(user.matches(em)){
                    reader.setMail(user);
                }else if(user.matches(ph)){
                    reader.setTel(user);
                }else {
                    reader.setName(user);
                }

                //登陆校验
                readerCurrent = readerService.login(reader);
                //校验结果
                if(readerCurrent!=null){
                    HttpSession session = req.getSession();
                    session.setAttribute("readerCurrent",readerCurrent);
                    resp.sendRedirect("home.jsp");
//                    req.getRequestDispatcher("home.jsp").forward(req,resp);
                }else {
                    resp.getWriter().write("<script>alert('登陆失败！'); window.location='login_reader.jsp' </script>");
                }

                break;

            case "registered"://注册

                //构造reader
                String phone = req.getParameter("phone");
                String userName =  req.getParameter("user");
                String password = req.getParameter("pwd");
                reader = new Reader();
                reader.setTel(phone);
                reader.setName(userName);
                reader.setPassword(password);
                //注册前校验
                if(readerService.queryByTel(phone)!=null){
                    resp.getWriter().write("<script>alert('注册失败,手机号已被注册！'); window.location='login_reader.jsp' </script>");
                }else {
                    //插入注册
                    int registered = readerService.registered(reader);
                    if(registered>0){
                        resp.sendRedirect("login_reader.jsp");
                    }else {
                        resp.getWriter().write("<script>alert('注册失败！'); window.location='login_reader.jsp' </script>");
                    }
                }
                break;
            case "logout"://退出
                req.getSession().invalidate();//销毁session
                resp.sendRedirect("home.jsp");
                break;
            case "getMssage"://获取本人消息
                boolean flag = false;
                List<Message> defaultMessage = null;
                if(readerCurrent!=null){
                    String readerCurrentTel = readerCurrent.getTel();
                    List<Message> mssage = readerService.getMssage(readerCurrentTel);
                    if(mssage!=null){
                        req.getSession().setAttribute("myMessage",mssage);
                        flag = true;
                        resp.sendRedirect("message.jsp");
                    }else {
//                        List<Message> defaultMessage = null;
                        defaultMessage = new ArrayList<>();
                        Message messageList = new Message();
                        messageList.setReaderTel("defalut");
                        defaultMessage.add(messageList);
                        req.getSession().setAttribute("myMessage",defaultMessage);
                        resp.getWriter().print("加载");
                    }
                }else{
                    defaultMessage = new ArrayList<>();
                    Message message = new Message();
                    message.setReaderTel("defalut");
//                    defaultMessage.add(new Message().setReaderTel("default"));
                    defaultMessage.add(message);
                    req.getSession().setAttribute("myMessage",defaultMessage);
                    resp.sendRedirect("message.jsp");
                }
                req.getSession().setAttribute("flag",flag);
                break;
            case "changeMessage":
                String str = "";
                String changeid = req.getParameter("id");
                if(readerService.changeMessage(changeid)>0){
                    str = "成功";
                }else {
                    str = "失败";
                }
                String readerCurrentTel = readerCurrent.getTel();
                List<Message> mssage = readerService.getMssage(readerCurrentTel);
                req.getSession().setAttribute("myMessage",mssage);
                resp.getWriter().print(str);
                break;
            case "change"://修改用户个人信息
                String fileName = "";
                //构造reader
                String readerId = "";
                String readerName = "";
                String readerTel = "";
                String readerSex = "";
                String readerAge = "";
                String readerMail = "";
                try {
                    DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
                    ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
                    //通过servletfile解析请求
                    List<FileItem> list = servletFileUpload.parseRequest(req);
                    for (FileItem fileItem : list) {
                        if (fileItem.isFormField()){
                            switch (fileItem.getFieldName()){
                                case "readerId":
                                    readerId = fileItem.getString("UTF-8");
                                    break;
                                case "readerName":
                                    readerName = fileItem.getString("UTF-8");
                                    break;
                                case "readerTel":
                                    readerTel = fileItem.getString("UTF-8");
                                    break;
                                case "readerSex":
                                    readerSex = fileItem.getString("UTF-8");
                                    break;
                                case "readerAge":
                                    readerAge = fileItem.getString("UTF-8");
                                    break;
                                case "readerMail":
                                    readerMail = fileItem.getString("UTF-8");
                                    break;
                            }
                        }else {
                            if(fileItem.getFieldName().equals("readerPic")){
                                fileName = fileItem.getName();
                                if(!fileName.equals("")){
                                    //存到文件夹
                                    InputStream inputStream = fileItem.getInputStream();
                                    String path = req.getServletContext().getRealPath("images/"+fileName);
                                    OutputStream outputStream = new FileOutputStream(path);
                                    int temp = 0;
                                    while ((temp = inputStream.read())!=-1 ){
                                        outputStream.write(temp);
                                    }
                                    outputStream.close();
                                    System.out.println("上传成功");
                                }else {
                                    System.out.println("上传失败");
                                }

                            }
                        }

                    }
                } catch (FileUploadException e) {
                    e.printStackTrace();
                }

                reader = new Reader();
                int id = Integer.parseInt(readerId);
                int age = Integer.parseInt(readerAge);
                reader.setId(id);
                reader.setName(readerName);
                reader.setSex(readerSex);
                reader.setAge(age);
                reader.setTel(readerTel);
                reader.setMail(readerMail);
                reader.setPhoto(fileName);

                int change = readerService.change(reader);
                if(change>0){
                    System.out.println("更新成功");
                    readerCurrent = GokJDBCUtil.queryForObject("select * from reader where id=?",Reader.class,id);
                    HttpSession session = req.getSession();
                    session.setAttribute("readerCurrent",readerCurrent);
                    req.getRequestDispatcher("personal.jsp").forward(req,resp);
                }else {
                    System.out.println("更新失败");
                }

                break;
            case "borrow":
                //判断用户是否登录
                Borrow borrow = null;
                HttpSession session = req.getSession();
                Reader readerCurrent = (Reader) session.getAttribute("readerCurrent");
                if(readerCurrent!=null){
                    String bookId = req.getParameter("bookId");
                    String bookName = req.getParameter("bookName");
                    borrow = new Borrow();
                    borrow.setBookId(bookId);
                    borrow.setBookName(bookName);
                    borrow.setReaderName(readerCurrent.getName());
                    borrow.setReaderTel(readerCurrent.getTel());
                    Date date = new Date();
                    //记录时间
                    Timestamp timestampBorrow = new Timestamp(date.getTime());
                    date.setTime(timestampBorrow.getTime()+(1000*60*60*24*7));
                    Timestamp timestampReturn = new Timestamp(date.getTime());
                    borrow.setBorrowTime(timestampBorrow);
                    borrow.setReturnTimePre(timestampReturn);
                    int borrowFlag = readerService.bookBorrow(borrow,readerCurrent.getTel());
                    if(borrowFlag>0){
                        //借阅成功
                        resp.getWriter().write("<script>alert('借阅成功！'); window.location='book?task=bookDet&id="+bookId+"' </script>");
                    }else {
                        System.out.println("借阅失败");
                        resp.getWriter().write("<script>alert('借阅失败！'); window.location='home.jsp' </script>");
                    }
                }else {
                    //未登录
                    System.out.println("未登录");
                    req.getRequestDispatcher("login_reader.jsp").forward(req,resp);
                }
                break;
            case "return":
                String returnId = req.getParameter("bookId");
                String returnName = req.getParameter("bookName");
                readerService.bookReturn((Reader) req.getSession().getAttribute("readerCurrent"), returnId, returnName);
                List<Borrow> borroweds = readerService.bookBorrowed((Reader) req.getSession().getAttribute("readerCurrent"));
                req.setAttribute("borrowed",borroweds);
                req.getRequestDispatcher("home.jsp").forward(req,resp);
                break;
            case "recordBorrow"://显示借阅记录
                List<Borrow> borrows = readerService.recoderBorrow((Reader) req.getSession().getAttribute("readerCurrent"));
                req.setAttribute("borrows",borrows);
                req.getRequestDispatcher("recordBorrow.jsp").forward(req,resp);
                break;
            case "bookManage"://已借图书管理（续借、归还）
                List<Borrow> borrowed = readerService.bookBorrowed((Reader) req.getSession().getAttribute("readerCurrent"));
                req.setAttribute("borrowed",borrowed);
                req.getRequestDispatcher("bookManage.jsp").forward(req,resp);
//                resp.sendRedirect("bookManage.jsp");
                break;
            case "bookReturn"://图书归还
                String bookReturnId = req.getParameter("id");
                String bookReturnName = req.getParameter("name");
                readerService.bookReturn((Reader) req.getSession().getAttribute("readerCurrent"), bookReturnId, bookReturnName);
                List<Borrow> borrowed1 = readerService.bookBorrowed((Reader) req.getSession().getAttribute("readerCurrent"));
                req.setAttribute("borrowed",borrowed1);
                req.getRequestDispatcher("bookManage.jsp").forward(req,resp);
                break;
            case "bookRenew"://图书续借
                String bookRenewId = req.getParameter("id");//图书id
                String readerphone = ((Reader)req.getSession().getAttribute("readerCurrent")).getTel();
                if(readerService.bookRenew(bookRenewId,readerphone)>0){
                    System.out.println("续借成功！");
                }else {
                    System.out.println("续借失败！");
                }
                List<Borrow> borrowed2 = readerService.bookBorrowed((Reader) req.getSession().getAttribute("readerCurrent"));
                req.setAttribute("borrowed",borrowed2);
//                resp.sendRedirect("bookManage.jsp");
                req.getRequestDispatcher("bookManage.jsp").forward(req,resp);
                break;
            case "recordDel":
                String delid = req.getParameter("id");
                String deltel =req.getParameter("tel");
                if(readerService.recordDel(delid,deltel)>0){
                    System.out.println("删除成功！");
                }else {
                    System.out.println("删除失败！");
                }
                List<Borrow> borrows1 = readerService.recoderBorrow((Reader) req.getSession().getAttribute("readerCurrent"));
                req.setAttribute("borrows",borrows1);
                req.getRequestDispatcher("recordBorrow.jsp").forward(req,resp);

                break;
            case "showReaders"://显示所有读者
                List<Reader> counts = readerService.showReaders();//所有数据
                //分页
                String page = req.getParameter("page");
                String limit = req.getParameter("limit");
                if(page.equals("")||limit.equals("")){
                    page = "1";
                    limit = "10";
                }
                List<Reader> readers = readerService.showReadersPage(Integer.parseInt(page), Integer.parseInt(limit));
                HashMap<String,Object> map = new HashMap<>();
                map.put("count",counts.size());
                map.put("msg","");
                map.put("code", 0);
                map.put("data",readers);
                if(map!=null){
                    Gson gson = new Gson();
                    String json = gson.toJson(map);
                    resp.getWriter().print(json);
                }
                break;
            case "showAll"://显示所有读者，不需要分页
                List<Reader> readerList = readerService.showReaders();//所有数据
                Gson gson = new Gson();
                String string = gson.toJson(readerList);
                resp.getWriter().print(string);
                break;
            case "readerLock":
                String idLock =  req.getParameter("id");
                if(readerService.statusChange(Integer.parseInt(idLock),"Lock")>0){
                    resp.getWriter().print("锁定成功");
                }else {
                    resp.getWriter().print("锁定失败");
                }
                break;
            case "readerUnLock":
                String idUnLock =  req.getParameter("id");
                if(readerService.statusChange(Integer.parseInt(idUnLock),"UnLock")>0){
                    resp.getWriter().print("解锁成功");
                }else {
                    resp.getWriter().print("解锁失败");
                }
                break;
            case "passChange":
                String changeId = req.getParameter("id");
                String changePass = req.getParameter("password");
                if(readerService.passwordChange(Integer.parseInt(changeId),changePass)>0){
                    resp.getWriter().print("密码修改成功！");
                }else {
                    resp.getWriter().print("密码修改失败！");
                }
                break;
            case "deleteById"://根据id删除用户
                String delId = req.getParameter("id");
                if(readerService.deleteById(Integer.parseInt(delId))>0){
                    resp.getWriter().print("用户删除成功！");
                }else {
                    resp.getWriter().print("用户删除失败！");
                }
                break;
            case "verifyTel":
                String tel = req.getParameter("tel");
                if(readerService.checkTel(tel)>0){
                    resp.getWriter().print("exist");
                }else {
                    resp.getWriter().print("noexist");
                }
                break;
            case "readerAdd":
                String teladd = req.getParameter("tel");
                String nameadd = req.getParameter("name");
                String passadd = req.getParameter("pass");
                if(readerService.readerAdd(teladd,nameadd,passadd)>0){
                    resp.getWriter().print("addSuccess");
                }else {
                    resp.getWriter().print("addFail");
                }
                break;
            case "queryByTel":
                String telquery = req.getParameter("tel");
                Reader reader = readerService.queryByTel(telquery);//所有数据
                if(reader!=null){
                    Gson readergson = new Gson();
                    String readerstring = readergson.toJson(reader);
                    resp.getWriter().print(readerstring);
                }else {
                    resp.getWriter().print("{ \"id\":\"暂无此号码的相关数据！请换个号码试试\" }");
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
