package com.kingwan.controller;

import com.google.gson.Gson;
import com.kingwan.entity.Info;
import com.kingwan.utils.GokJDBCUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by kingwan on 2020/4/24.
 */
@WebServlet("/info")
public class InfoServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Info info = GokJDBCUtil.queryForObject("select (select count(*) from book) as books,(select count(*) from reader) as readers,(select count(*) from admin) as admins,(select count(*) from record_borrow) as borrows,(select count(*) from record_borrow where isRenew='yes') as renews", Info.class);
//        Info info = GokJDBCUtil.queryForObject("select count(*) from boos", Info.class);
        HttpSession session = req.getSession();
        session.setAttribute("infodata",info);
        Gson gson = new Gson();
        String string = gson.toJson(info);
//        req.setAttribute("info",info);
        resp.getWriter().print(string);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
