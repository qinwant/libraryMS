package com.kingwan.repository.impl;

import com.kingwan.entity.Admin;
import com.kingwan.entity.Message;
import com.kingwan.repository.AdminRepository;
import com.kingwan.utils.GokJDBCUtil;

/**
 * Created by kingwan on 2020/4/12.
 */
public class AdminRepositoryImpl implements AdminRepository {
    @Override
    public Admin login(Admin admin) {
        Admin adminCurrent = null;
        if(admin.getAdminMail()!=null){
            adminCurrent = GokJDBCUtil.queryForObject("select * from admin where adminMail=? and adminPassword=?", Admin.class,admin.getAdminMail(),admin.getAdminPassword());
        }else if(admin.getAdminTel()!=null){
            adminCurrent = GokJDBCUtil.queryForObject("select * from admin where adminTel=? and adminPassword=?", Admin.class,admin.getAdminTel(),admin.getAdminPassword());
        }else {
            adminCurrent = GokJDBCUtil.queryForObject("select * from admin where adminName=? and adminPassword=?", Admin.class,admin.getAdminName(),admin.getAdminPassword());
        }
        return adminCurrent;
    }

    @Override
    public int registered(Admin admin) {
        int update = GokJDBCUtil.update("insert into admin(adminName,adminTel,adminPassword) values(?,?,?)", admin.getAdminName(), admin.getAdminTel(), admin.getAdminPassword());
        return update;
    }

    @Override
    public Admin verifyPass(String adminTel, String oldpass) {
        return GokJDBCUtil.queryForObject("select * from admin where adminTel=? and adminPassword=?",Admin.class,adminTel,oldpass);
    }

    @Override
    public int changeInfo(Admin admin) {
        return GokJDBCUtil.update("update admin set adminName=?,adminMail=?,adminPassword=? where adminTel=?",admin.getAdminName(),admin.getAdminMail(),admin.getAdminPassword(),admin.getAdminTel());
    }

    @Override
    public int queryByTel(String phone) {
        if(GokJDBCUtil.queryForObject("select * from admin where adminTel=?",Admin.class,phone)!=null){
            return 1;
        }else {
            return 0;
        }

    }

    @Override
    public int remind(Message message) {
        return GokJDBCUtil.update("insert into message(adminTel,readerTel,bookName,returnTime,isRead) values(?,?,?,?,'未读')",message.getAdminTel(),message.getReaderTel(),message.getBookName(),message.getReturnTime());
    }
}
