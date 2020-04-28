package com.kingwan.repository;

import com.kingwan.entity.Borrow;
import com.kingwan.entity.Message;
import com.kingwan.entity.Reader;

import java.util.List;

/**
 * Created by kingwan on 2020/4/12.
 */
public interface ReaderRepository {
    public Reader login(Reader reader);
    public int registered(Reader reader);

    public int change(Reader reader);

    public int bookBorrow(Borrow borrow,String tel);

    public List<Borrow> recordBorrow(Reader reader);

    public List<Borrow> bookBorrowed(Reader readerCurrent);

    public int bookReturn(Reader reader,String bookId,String bookName);

    public List<Reader> showReaders();

    List<Reader> showReadersPage(int page, int limit);

    public int statusChange(int id, String status);

    public int passwordChange(int id, String changePass);

    public int deleteById(int id);

    int checkTel(String tel);

    int readerAdd(String teladd, String nameadd, String passadd);

    Reader queryById(String telquery);

    public int bookRenew(String bookRenewId, String readerphone);

    int recordDel(String delId, String delTel);

    List<Message> getMessage(String readerCurrentTel);

    int chnageMessage(String changeId);
}
