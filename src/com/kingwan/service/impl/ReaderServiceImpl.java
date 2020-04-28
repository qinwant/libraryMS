package com.kingwan.service.impl;

import com.kingwan.entity.Borrow;
import com.kingwan.entity.Message;
import com.kingwan.entity.Reader;
import com.kingwan.repository.ReaderRepository;
import com.kingwan.repository.impl.ReaderRepositoryImpl;
import com.kingwan.service.ReaderService;

import java.util.List;

/**
 * Created by kingwan on 2020/4/12.
 */
public class ReaderServiceImpl implements ReaderService {
    ReaderRepository readerRepository = new ReaderRepositoryImpl();
    /**
     * 读者登陆
     * @param reader
     * @return
     */
    @Override
    public Reader login(Reader reader) {
        Reader readerCurrent = readerRepository.login(reader);
        return readerCurrent;
    }

    @Override
    public int registered(Reader reader) {
        int registered = readerRepository.registered(reader);
        return registered;
    }

    @Override
    public int change(Reader reader) {
        int update = readerRepository.change(reader);
        return update;
    }

    /**
     * 书籍借阅
     * @param borrow
     * @return
     */
    @Override
    public int bookBorrow(Borrow borrow,String tel) {
        int update = readerRepository.bookBorrow(borrow,tel);
        return update;
    }

    @Override
    public List<Borrow> recoderBorrow(Reader reader) {
        List<Borrow> borrows = readerRepository.recordBorrow(reader);
        return borrows;
    }

    @Override
    public List<Borrow> bookBorrowed(Reader readerCurrent) {
        List<Borrow> borrowed = readerRepository.bookBorrowed(readerCurrent);
        return borrowed;
    }

    @Override
    public int bookReturn(Reader reader, String bookId, String bookName) {
        int isreturn = readerRepository.bookReturn(reader, bookId, bookName);
        return isreturn;
    }

    @Override
    public List<Reader> showReaders() {
        return readerRepository.showReaders();
    }

    @Override
    public List<Reader> showReadersPage(int page, int limit) {
        return readerRepository.showReadersPage(page,limit);
    }

    @Override
    public int statusChange(int id, String status) {

        return readerRepository.statusChange(id,status);
    }

    @Override
    public int passwordChange(int id, String changePass) {
        return readerRepository.passwordChange(id,changePass);
    }

    @Override
    public int deleteById(int id) {
        return readerRepository.deleteById(id);
    }

    @Override
    public int checkTel(String tel) {
        return readerRepository.checkTel(tel);
    }

    @Override
    public int readerAdd(String teladd, String nameadd, String passadd) {
        return readerRepository.readerAdd(teladd,nameadd,passadd);
    }

    @Override
    public Reader queryByTel(String telquery) {
        return readerRepository.queryById(telquery);
    }

    @Override
    public int bookRenew(String bookRenewId, String readerphone) {
        return readerRepository.bookRenew(bookRenewId,readerphone);
    }

    @Override
    public int recordDel(String delId, String delTel) {
        return readerRepository.recordDel(delId,delTel);
    }

    @Override
    public List<Message> getMssage(String readerCurrentTel) {
        return readerRepository.getMessage(readerCurrentTel);
    }

    @Override
    public int changeMessage(String changeId) {
        return readerRepository.chnageMessage(changeId);
    }
}
