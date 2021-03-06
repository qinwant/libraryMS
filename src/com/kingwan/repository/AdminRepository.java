package com.kingwan.repository;

import com.kingwan.entity.Admin;
import com.kingwan.entity.Message;

/**
 * Created by kingwan on 2020/4/12.
 */
public interface AdminRepository {
    public Admin login(Admin admin);
    public int registered(Admin admin);

    Admin verifyPass(String adminTel, String oldpass);

    int changeInfo(Admin admin);

    int queryByTel(String phone);

    int remind(Message message);
}
