package com.kingwan.repository;

import com.kingwan.entity.Book;

import java.util.List;

/**
 * Created by kingwan on 2020/4/14.
 */
public interface BookRepository {
    public List<Book> showHot();

    public List<Book> showAll();
    public List<Book> showAllForPage(String string,String key,int startLine,int pageSize);

    public List<Book> queryForKey(String key);

    public Book queryForObject(String bookId);

    public List<Book> showAllForKey(String bookName, String bookCase, String bookAuthor);

    public int addBook(Book addBook);

    public int  delBook(int idDel);

    public Book updateBookBefore(int idUpdate);

    public int updateBook(Book bookUpd);
}
