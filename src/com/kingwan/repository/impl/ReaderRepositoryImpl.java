package com.kingwan.repository.impl;

import com.kingwan.entity.Borrow;
import com.kingwan.entity.Message;
import com.kingwan.entity.Reader;
import com.kingwan.repository.ReaderRepository;
import com.kingwan.utils.GokJDBCUtil;

import java.util.Date;
import java.util.List;

/**
 * Created by kingwan on 2020/4/12.
 */
public class ReaderRepositoryImpl implements ReaderRepository {

    @Override
    public Reader login(Reader reader) {
        Reader readerCurrent = null;
        if(reader.getMail()!=null){
            readerCurrent = GokJDBCUtil.queryForObject("select * from reader where mail=? and password=?", Reader.class, reader.getMail(), reader.getPassword());
        }else if(reader.getTel()!=null){
            readerCurrent = GokJDBCUtil.queryForObject("select * from reader where tel=? and password=?", Reader.class, reader.getTel(), reader.getPassword());
        }else {
            readerCurrent = GokJDBCUtil.queryForObject("select * from reader where name=? and password=?", Reader.class, reader.getName(), reader.getPassword());
        }
        return readerCurrent;
    }

    @Override
    public int registered(Reader reader) {
        int update = GokJDBCUtil.update("insert into reader(tel,name,password,status,photo,message) values(?,?,?,'正常','default-reader-head.png','无消息')", reader.getTel(), reader.getName(), reader.getPassword());
        return update;
    }

    @Override
    public int change(Reader reader) {
        int update = GokJDBCUtil.update("update reader set name=? , tel=? , mail=? , photo=? , sex=? ,age=? where id =?", reader.getName(), reader.getTel(), reader.getMail(), reader.getPhoto(), reader.getSex(), reader.getAge(), reader.getId());
        return update;
    }

    @Override
    public int bookBorrow(Borrow borrow,String tel) {
        Reader check = GokJDBCUtil.queryForObject("select * from reader where tel=? and status='正常'",Reader.class,tel);
        if(check==null){
            return 0;
        }
        int update = GokJDBCUtil.update("insert into record_borrow(bookId,bookName,readerTel,readerName,borrowTime,returnTimePre,isReturn,isRenew) values(?,?,?,?,?,?,?,'no')", borrow.getBookId(), borrow.getBookName(), borrow.getReaderTel(), borrow.getReaderName(), borrow.getBorrowTime(), borrow.getReturnTimePre(),"no");
        int bookReduce = GokJDBCUtil.update("update book set borrowed = borrowed+1 where id=?", borrow.getBookId());
        if(bookReduce>0){
            return update;
        }else {
            return 0;
        }

    }

    /**
     * 返回读者借阅记录
     * @param reader
     * @return
     */
    @Override
    public List<Borrow> recordBorrow(Reader reader) {
        List<Borrow> borrows = GokJDBCUtil.queryAll("select * from record_borrow where readerTel=?", Borrow.class,reader.getTel());
        return borrows;
    }

    /**
     * 返回用户已借图书信息（书名、借阅时间、应当归还时间）
     * @param readerCurrent
     * @return
     */
    @Override
    public List<Borrow> bookBorrowed(Reader readerCurrent) {
        List<Borrow> borrowed = GokJDBCUtil.queryAll("select * from record_borrow where readerTel=? and isReturn='no'", Borrow.class, readerCurrent.getTel());
        return borrowed;
    }

    /**
     * 用户还书操作
     * @param reader
     * @param bookId
     * @return
     */
    @Override
    public int bookReturn(Reader reader, String bookId,String bookName) {
        //借阅表更改isReturn
        int update = GokJDBCUtil.update("update record_borrow set isReturn = 'yes' where readerTel=? and bookId=?", reader.getTel(), bookId);
        //归还表更新
        Date date = new Date();
        int update1 = GokJDBCUtil.update("insert into record_return(bookId,bookName,readerName,readerTel,returnTime) values(?,?,?,?,?)", bookId, bookName, reader.getName(), reader.getTel(), date);
        //图书表更新，已借数量减一
        int update2 = GokJDBCUtil.update("update book set borrowed = borrowed-1 where id=?", bookId);
        if(update>0&&update1>0&&update2>0){
            return 1;
        }
        return 0;
    }

    @Override
    public List<Reader> showReaders() {
        List<Reader> readers = GokJDBCUtil.queryAll("select * from reader", Reader.class);
        return readers;
    }

    @Override
    public List<Reader> showReadersPage(int page, int limit) {
        int start = (page-1)*10;
        int end = limit;
        List<Reader> readers = GokJDBCUtil.queryAll("select * from reader limit ?,?", Reader.class,start,end);
        return readers;
    }

    @Override
    public int statusChange(int id, String status) {
        int code = 0;
        if(status.equals("Lock")){//账户锁定
            code = GokJDBCUtil.update("update reader set status='锁定' where id=?",id);
        }else if(status.equals("UnLock")){//账户解锁
            code = GokJDBCUtil.update("update reader set status='正常' where id=?",id);
        }
        return code;
    }

    @Override
    public int passwordChange(int id, String changePass) {
        return GokJDBCUtil.update("update reader set password=? where id=?",changePass,id);
    }

    @Override
    public int deleteById(int id) {
        return GokJDBCUtil.update("delete from reader where id=?",id);
    }

    @Override
    public int checkTel(String tel) {
        Reader reader = GokJDBCUtil.queryForObject("select * from reader where tel=?", Reader.class, tel);
        System.out.println(reader.toString());
        if(reader!=null){
            return 1;
        }else {
            return 0;
        }
    }

    @Override
    public int readerAdd(String teladd, String nameadd, String passadd) {
        return GokJDBCUtil.update("insert into reader(tel,name,password,status,photo) values(?,?,?,'正常','default-reader-head.png')",teladd,nameadd,passadd);
    }

    @Override
    public Reader queryById(String telquery) {
        return GokJDBCUtil.queryForObject("select * from reader where tel=?",Reader.class,telquery);
    }

    @Override
    public int bookRenew(String bookRenewId, String readerphone) {
        return GokJDBCUtil.update("UPDATE record_borrow set isRenew='yes',returnTimePre=date_add(returnTimePre, interval 7 day) where readerTel=? and bookId=?",readerphone,bookRenewId);
    }

    @Override
    public int recordDel(String delId, String delTel) {
        return GokJDBCUtil.update("delete from record_borrow where id=? and readerTel=?",delId,delTel);
    }

    @Override
    public List<Message> getMessage(String readerCurrentTel) {

        return GokJDBCUtil.queryAll("select * from message where readerTel=? order by convert(isRead using GBK) asc",Message.class,readerCurrentTel);
    }

    @Override
    public int chnageMessage(String changeId) {
        return GokJDBCUtil.update("update message set isRead='已读' where id=?",Integer.parseInt(changeId));
    }
}
