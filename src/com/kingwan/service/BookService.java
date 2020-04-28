package com.kingwan.service;

import com.kingwan.entity.Book;

import java.util.List;

/**
 * Created by kingwan on 2020/4/14.
 */
public interface BookService {
    public List<Book> showHot();//显示热门图书
    public List<Book> showAll();//显示所有图示
    //按关键字显示图书（书名、作者模糊查询）
    public List<Book> showAllForPage(String string ,String key,int startLine,int pageSize);
    public List<Book> queryForKey(String key);//模糊查询

    public Book queryForObject(String bookId);

    public List<Book> showAllForKey(String bookName, String bookCase, String bookAuthor);

    public int addBook(Book addBook);

    public int delBook(int idDel);

    public Book updateBookBefore(int idUpdate);

    public int updateBook(Book bookUpd);
}
