package com.kingwan.service;

import com.kingwan.entity.Borrow;
import com.kingwan.entity.Message;
import com.kingwan.entity.Reader;

import java.util.List;

/**
 * 读者模块
 * 1.读者登陆
 * 2.读者注册
 * 3.读者个人信息修改
 *
 * Created by kingwan on 2020/4/12.
 */
public interface ReaderService {
    public Reader login(Reader reader);
    public int registered(Reader reader);

    public int change(Reader reader);

    public int bookBorrow(Borrow borrow,String tel);

    public List<Borrow> recoderBorrow(Reader reader);

    public List<Borrow> bookBorrowed(Reader readerCurrent);

    public int bookReturn(Reader reader,String bookId,String bookName);

    public List<Reader> showReaders();

    public List<Reader> showReadersPage(int page, int limit);

    public int statusChange(int id, String status);

    public int passwordChange(int id, String changePass);

    public int deleteById(int id);

    public int checkTel(String tel);

    public int readerAdd(String teladd, String nameadd, String passadd);

    Reader queryByTel(String telquery);

    public int bookRenew(String bookRenewId, String readerphone);

    int recordDel(String delId, String delTel);

    public List<Message> getMssage(String readerCurrentTel);

    int changeMessage(String changeId);
}
