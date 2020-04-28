package com.kingwan.controller;

import com.google.gson.Gson;
import com.kingwan.entity.Book;
import com.kingwan.service.BookService;
import com.kingwan.service.impl.BookServiceImpl;
import com.kingwan.utils.PageDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

/**
 * Created by kingwan on 2020/4/14.
 */
@WebServlet("/book")
public class BookServlet extends HttpServlet {
    BookService bookService = new BookServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String task = req.getParameter("task");
        List<Book> booksPage=null;
        String textSearch = "";
        switch (task){
            case "showBook":
                List<Book> hotbooks = bookService.showHot();
                Gson gson = new Gson();
                String hotbook = gson.toJson(hotbooks);
                resp.getWriter().print(hotbook);
                break;
            case "showBooks":
                List<Book> books = bookService.showHot();
                req.getSession().setAttribute("hotBooks",books);
                resp.sendRedirect("home.jsp");
                break;
//            case "showHot"://好书推荐
//                List<Book> hotBooks = bookService.showHot();
//                req.getSession().setAttribute("hotBooks",hotBooks);
//                break;
            case "showAll":
                List<Book> bookList = bookService.showAll();
                if(bookList!=null){
                    Gson json = new Gson();
                    String str = json.toJson(bookList);
                    resp.getWriter().print(str);
                }
//                List<Book> bookList = bookService.showAll();
//                //设置分页
//                PageDAO pageDAO = new PageDAO(req);
//                //设置总记录数
//                pageDAO.setRscount(bookList.size());
//                //设置开始行
//                int startLine = (pageDAO.getCurrentPage()-1)*pageDAO.getPagesize()+1;
//                booksPage = bookService.showAllForPage(startLine, pageDAO.getPagesize());
//                //总页数
//                //展示分页工具条
//                String pageTool = pageDAO.pagetool(PageDAO.BbsImage);
//                req.setAttribute("pageTools",pageTool);
//                req.setAttribute("booksPage",booksPage);
//                req.getRequestDispatcher("showSearch.jsp").forward(req,resp);
                break;
            case "showAllForKey":
                String bookName = req.getParameter("bookName");
                String bookCase = req.getParameter("bookCase");
                String bookAuthor = req.getParameter("bookAuthor");
                List<Book> books1 = bookService.showAllForKey(bookName, bookCase, bookAuthor);
                req.setAttribute("books",books1);
                req.getRequestDispatcher("resultBookSearch.jsp").forward(req,resp);
                break;
            case "queryForKey":
                if(req.getParameter("textfield")!=null){
                    textSearch = req.getParameter("textfield");//搜索关键字
                }
                String string ="";//搜索方式
                if(textSearch!=null){
                    //模糊关键字搜索
                    booksPage = bookService.queryForKey(textSearch);
//                    req.setAttribute("booksPage",booksPage);
//                    req.getRequestDispatcher("showSearch.jsp").forward(req,resp);
                }else {
                    //全搜索
                    string = "all";
//                    booksPage = bookService.showAll();
//                    req.setAttribute("booksPage",booksPage);
                }
                //设置分页
                PageDAO pageDAO = new PageDAO(req);
                //设置总记录数
                pageDAO.setRscount(booksPage.size());
                //设置开始行
                int startLine = (pageDAO.getCurrentPage()-1)*pageDAO.getPagesize();
                booksPage = bookService.showAllForPage(string,textSearch,startLine, pageDAO.getPagesize());
                //总页数
                //展示分页工具条
                String pageTool = pageDAO.pagetool(PageDAO.BbsImage);
                req.setAttribute("pageTools",pageTool);
                req.setAttribute("booksPage",booksPage);
                req.getRequestDispatcher("showSearch.jsp").forward(req,resp);

                break;
            case "bookDet"://图书详细信息展示
                String bookId = req.getParameter("id");
                Book book = bookService.queryForObject(bookId);
                req.setAttribute("book",book);
                req.getRequestDispatcher("bookDetail.jsp").forward(req,resp);
                break;
            case "bookAdd"://图书添加
                String fileName = "";
                String addId ="";
                String addName = "";
                String addBookCase = "";
                String addPhoto = "";
                String addPublisher = "";
                String addAuthor = "";
                String addCount = "";
                String addHot ="";
                try {
                    DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
                    ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
                    //通过servletfile解析请求
                    List<FileItem> list = servletFileUpload.parseRequest(req);
                    for (FileItem fileItem : list) {
                        if (fileItem.isFormField()){
                            System.out.println("参数");
                            switch (fileItem.getFieldName()){
                            case "addId":
                                addId = fileItem.getString("UTF-8");
                                    break;
                            case "addName":
                                addName = fileItem.getString("UTF-8");
                                break;
                            case "addBookCase":
                                addBookCase = fileItem.getString("UTF-8");
                                break;
                            case "addAuthor":
                                addAuthor = fileItem.getString("UTF-8");
                                break;
                            case "addPublisher":
                                addPublisher = fileItem.getString("UTF-8");
                                break;
                            case "addCount":
                                addCount = fileItem.getString("UTF-8");
                                break;
                            case "addHot":
                                addHot = fileItem.getString("UTF-8");
                                break;
                        }
                        }else {
                            if(fileItem.getFieldName().equals("addPhoto")){
                                //获取文件名
                                fileName = fileItem.getName();
//                                //获取后缀名
//                               // String sname = fileName.substring(fileName.lastIndexOf("."));
//                                //时间格式化格式
//                                SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyyMMddHHmmssSSS");
//                                //获取当前时间并作为时间戳
//                                String timeStamp=simpleDateFormat.format(new Date());
//                                //拼接新的文件名
//                                String newFileName =timeStamp+fileName;
                                //存到文件夹
                                InputStream inputStream = fileItem.getInputStream();
                                String path = req.getServletContext().getRealPath("images/"+fileName);
                                OutputStream outputStream = new FileOutputStream(path);
                                int temp = 0;
                                while ((temp = inputStream.read())!=-1 ){
                                    outputStream.write(temp);
                                }
                                outputStream.close();
                                System.out.println("上传图书图片成功");
                            }
                        }

                    }
                } catch (FileUploadException e) {
                    e.printStackTrace();
                }
                //构造添加的图书信息
                Book addBook = new Book();
                addBook.setId(Integer.parseInt(addId));
                addBook.setName(addName);
                addBook.setBookCase(addBookCase);
                addBook.setPhoto(fileName);
                addBook.setPublisher(addPublisher);
                addBook.setAuthor(addAuthor);
                addBook.setCount(Integer.parseInt(addCount));
                addBook.setHot(addHot);

                //操作数据库
                if(bookService.addBook(addBook)>0){
                    System.out.println("添加图书成功");
                    req.getRequestDispatcher("adminBookManage.jsp").forward(req,resp);
                }else {
                    System.out.println("添加图书失败");
                }
            case "delBook": //图书删除
                String idDel = req.getParameter("id");
                if(bookService.delBook(Integer.parseInt(idDel))>0){
                    System.out.println("删除成功！");
                    resp.getWriter().print(idDel);
                }else {
                    System.out.println("删除失败！");
                }
            case "updateBook"://图书修改
                String updateId = req.getParameter("id");
                Book bookBefore = bookService.updateBookBefore(Integer.parseInt(updateId));
                if(bookBefore!=null){
                    Gson json = new Gson();
                    String str = json.toJson(bookBefore);
                    resp.getWriter().print(str);
                }
                break;
            case "updateBookAfter"://确认修改
                String idNew = req.getParameter("addId");
                String nameNew = req.getParameter("addName");
                String bookCaseNew = req.getParameter("addBookCase");
                String publisherNew = req.getParameter("addPublisher");
                String authorNew = req.getParameter("addAuthor");
                String countNew = req.getParameter("addCount");
                String hotNew = req.getParameter("addHot");
                Book bookUpd = new Book();
                bookUpd.setId(Integer.parseInt(idNew));
                bookUpd.setName(nameNew);
                bookUpd.setBookCase(bookCaseNew);
                bookUpd.setPublisher(publisherNew);
                bookUpd.setAuthor(authorNew);
                bookUpd.setCount(Integer.parseInt(countNew));
                bookUpd.setHot(hotNew);
                int updateBook = bookService.updateBook(bookUpd);
                if(updateBook>0){
                    resp.getWriter().print("success!");
                }else {
                    resp.getWriter().print("fail!");
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
