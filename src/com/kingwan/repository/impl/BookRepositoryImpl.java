package com.kingwan.repository.impl;

import com.kingwan.entity.Book;
import com.kingwan.repository.BookRepository;
import com.kingwan.utils.GokJDBCUtil;

import java.util.List;

/**
 * Created by kingwan on 2020/4/14.
 */
public class BookRepositoryImpl implements BookRepository {
    @Override
    public List<Book> showHot() {
        List<Book> books = GokJDBCUtil.queryAll("select * from book where hot='yes'", Book.class);
        return books;
    }

    /**
     * 模糊查询图书
     * @param book
     * @return
     */
    @Override
    public List<Book> showAll() {
        List<Book> books;

        books = GokJDBCUtil.queryAll("select * from book", Book.class);

        return books;
    }

    @Override
    public List<Book> showAllForPage(String string,String key,int startLine, int pageSize) {
        List<Book> books = null;
        if (!string.equals("all")){
             books = GokJDBCUtil.queryAll("select * from book where name like concat('%',?,'%') or author like concat('%',?,'%') limit ?,?", Book.class,key,key, startLine, pageSize);
        }else {
             books = GokJDBCUtil.queryAll("select * from book limit ?,?", Book.class, startLine, pageSize);
        }

        return books;
    }

    @Override
    public List<Book> queryForKey(String key) {
        List<Book> books = GokJDBCUtil.queryAll("select * from book where name like concat('%',?,'%') or author like concat('%',?,'%')", Book.class, key, key);
        return books;
    }

    @Override
    public Book queryForObject(String bookId) {
        int id = Integer.parseInt(bookId);
        Book book = GokJDBCUtil.queryForObject("select * from book where id=?", Book.class, id);
        return book;
    }

    @Override
    public List<Book> showAllForKey(String bookName, String bookCase, String bookAuthor) {
        String sql = "select * from book where 1=1 ";
        if(!bookName.equals("")){
            sql += " and name like '%"+bookName+"%'";
        }else if(!bookCase.equals("")){
            sql += " and bookCase like '%"+bookCase+"%'";
        }else if(!bookAuthor.equals("")){
            sql += " and author like '%"+bookAuthor+"%'";
        }
        List<Book> books = GokJDBCUtil.queryAll(sql, Book.class);
        return books;
    }

    /**
     *
     * @param addBook
     * @return
     */
    @Override
    public int addBook(Book addBook) {
        int update = GokJDBCUtil.update("insert into book(id,name,bookCase,photo,publisher,author,count,borrowed,hot) values(?,?,?,?,?,?,?,0,?)",addBook.getId(), addBook.getName(), addBook.getBookCase(), addBook.getPhoto(), addBook.getPublisher(), addBook.getAuthor(), addBook.getCount(), addBook.getHot());
        return update;
    }

    @Override
    public int delBook(int idDel) {
        return GokJDBCUtil.update("delete from book where id=?",idDel);
    }

    @Override
    public Book updateBookBefore(int idUpdate) {
        Book book = GokJDBCUtil.queryForObject("select * from book where id=?", Book.class, idUpdate);
        return book;
    }

    @Override
    public int updateBook(Book bookUpd) {
        return GokJDBCUtil.update("update book set name=?,bookCase=?,publisher=?,author=?,count=?,hot=? where id=?",bookUpd.getName(),bookUpd.getBookCase(),bookUpd.getPublisher(),bookUpd.getAuthor(),bookUpd.getCount(),bookUpd.getHot(),bookUpd.getId());
    }
}
