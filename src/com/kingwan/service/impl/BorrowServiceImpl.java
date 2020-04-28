package com.kingwan.service.impl;

import com.kingwan.entity.Borrow;
import com.kingwan.repository.BorrowRepository;
import com.kingwan.repository.impl.BorrowRepositoryImpl;
import com.kingwan.service.BorrowService;

import java.util.List;

/**
 * Created by kingwan on 2020/4/21.
 */
public class BorrowServiceImpl implements BorrowService {
    BorrowRepository borrowRepository = new BorrowRepositoryImpl();

    /**
     * 返回所有借阅记录
     * @return
     */
    @Override
    public List<Borrow> showAll() {
        return borrowRepository.showAll();
    }

    @Override
    public List<Borrow> recordSearch(Borrow borrow) {
        return borrowRepository.recordSearch(borrow);
    }

    @Override
    public int delForId(int id) {
        return borrowRepository.delForId(id);
    }
}
