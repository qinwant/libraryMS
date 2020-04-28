package com.kingwan.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.kingwan.entity.Borrow;
import com.kingwan.service.BorrowService;
import com.kingwan.service.impl.BorrowServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by kingwan on 2020/4/21.
 */
@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BorrowService borrowService = new BorrowServiceImpl();
        Borrow borrow = null;
        String task = req.getParameter("task");
        switch (task){
            case "showAll"://显示所有借阅记录
                List<Borrow> borrows = borrowService.showAll();
                if(borrows!=null){
//                    Gson json = new Gson();
//                    String string = json.toJson(borrows);
//                    resp.getWriter().print(string);
                    JSON json = new JSONObject();
                    String string = json.toJSONString(borrows);
                    resp.getWriter().print(string);
                }
                break;
            case "recordSearch":
                String bookId = req.getParameter("bookId");
                String bookName = req.getParameter("bookName");
                String readerName = req.getParameter("readerName");
                String readerTel = req.getParameter("readerTel");
                String isReturn = req.getParameter("isReturn");
                String isBorrow = req.getParameter("isBorrow");
                String isRenew = req.getParameter("isRenew");
                //构造借阅记录
                borrow = new Borrow();
                borrow.setBookId(bookId);
                borrow.setBookName(bookName);
                borrow.setReaderName(readerName);
                borrow.setReaderTel(readerTel);
                if(isBorrow!=null&&isReturn!=null){
                    borrow.setIsReturn("");
                }else if(isReturn!=null){
                    borrow.setIsReturn("yes");
                }else if(isBorrow!=null){
                    borrow.setIsReturn("no");
                }
                borrow.setIsRenew(isRenew);
                //查询服务
                List<Borrow> records = borrowService.recordSearch(borrow);
                req.setAttribute("records",records);
                req.getRequestDispatcher("recordSearch.jsp").forward(req,resp);
                break;
            case "delRecord"://删除借书记录
                String id = req.getParameter("id");
                int delFlag = borrowService.delForId(Integer.parseInt(id));
                if(delFlag>0){
                    resp.getWriter().print("删除成功！");
                }else {
                    resp.getWriter().print("删除失败！");
                }
                break;
            default:
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
