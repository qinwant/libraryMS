package com.kingwan.service.impl;

import com.kingwan.entity.Book;
import com.kingwan.repository.BookRepository;
import com.kingwan.repository.impl.BookRepositoryImpl;
import com.kingwan.service.BookService;

import java.util.List;

/**
 * Created by kingwan on 2020/4/14.
 */
public class BookServiceImpl implements BookService {
    BookRepository bookRepository = new BookRepositoryImpl();
    @Override
    public List<Book> showHot() {
        List<Book> books = bookRepository.showHot();
        return books;
    }



    @Override
    public List<Book> showAll() {
        List<Book> books = bookRepository.showAll();
        return books;
    }

    @Override
    public List<Book> showAllForPage(String string ,String key, int startLine, int pageSize) {
        List<Book> books = bookRepository.showAllForPage(string,key,startLine, pageSize);
        return books;
    }

    @Override
    public List<Book> queryForKey(String key) {
        List<Book> books = bookRepository.queryForKey(key);
        return books;
    }

    @Override
    public Book queryForObject(String bookId) {
        Book book = bookRepository.queryForObject(bookId);
        return book;
    }

    @Override
    public List<Book> showAllForKey(String bookName, String bookCase, String bookAuthor) {
        List<Book> books = bookRepository.showAllForKey(bookName, bookCase, bookAuthor);
        return books;
    }

    /**
     * 管理员图书添加
     * @param addBook
     * @return
     */
    @Override
    public int addBook(Book addBook) {
        int update = bookRepository.addBook(addBook);
        return update;
    }

    @Override
    public int delBook(int idDel) {
        int delBook = bookRepository.delBook(idDel);
        return delBook;
    }

    @Override
    public Book updateBookBefore(int idUpdate) {
        return bookRepository.updateBookBefore(idUpdate);
    }

    @Override
    public int updateBook(Book bookUpd) {
        return bookRepository.updateBook(bookUpd);
    }
}
