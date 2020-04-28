package com.kingwan.repository;

import com.kingwan.entity.Borrow;

import java.util.List;

/**
 * Created by kingwan on 2020/4/21.
 */
public interface BorrowRepository {
    public List<Borrow> showAll();

    public List<Borrow> recordSearch(Borrow borrow);

    public int delForId(int id);
}
