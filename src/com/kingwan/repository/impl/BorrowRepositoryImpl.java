package com.kingwan.repository.impl;

import com.kingwan.entity.Borrow;
import com.kingwan.repository.BorrowRepository;
import com.kingwan.utils.GokJDBCUtil;

import java.util.List;

/**
 * Created by kingwan on 2020/4/21.
 */
public class BorrowRepositoryImpl implements BorrowRepository {
    @Override
    public List<Borrow> showAll() {
        List<Borrow> borrows = GokJDBCUtil.queryAll("select * from record_borrow", Borrow.class);
        return borrows;
    }

    @Override
    public List<Borrow> recordSearch(Borrow borrow) {
        String sql = "select * from record_borrow where 1=1 ";
        if(!borrow.getBookId().equals("")){
            sql += " and bookId like '%"+borrow.getBookId()+"%'";
        }if(!borrow.getBookName().equals("")){
            sql += " and bookName like '%"+borrow.getBookName()+"%'";
        }if(!borrow.getReaderName().equals("")){
            sql += " and readerName like '%"+borrow.getReaderName()+"%'";
        }if(!borrow.getReaderTel().equals("")){
            sql += " and readerTel like '%"+borrow.getReaderTel()+"%'";
        }if(borrow.getIsReturn()!=null&&!borrow.getIsReturn().equals("")){
            sql += " and isReturn like '%"+borrow.getIsReturn()+"%'";
        }if(borrow.getIsRenew()!=null&&!borrow.getIsRenew().equals("")){
            sql += " and isRenew like '%"+borrow.getIsRenew()+"%'";
        }
        System.out.println(sql);
        List<Borrow> borrows = GokJDBCUtil.queryAll(sql, Borrow.class);
        return borrows;
    }

    @Override
    public int delForId(int id) {
        return GokJDBCUtil.update("delete from record_borrow where id=?",id);
    }
}
