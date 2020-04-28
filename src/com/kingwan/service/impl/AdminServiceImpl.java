package com.kingwan.service.impl;

import com.kingwan.entity.Admin;
import com.kingwan.entity.Message;
import com.kingwan.repository.AdminRepository;
import com.kingwan.repository.impl.AdminRepositoryImpl;
import com.kingwan.service.AdminService;

/**
 * Created by kingwan on 2020/4/12.
 */
public class AdminServiceImpl implements AdminService {
    AdminRepository adminRepository = new AdminRepositoryImpl();
    @Override
    public Admin login(Admin admin) {
        Admin adminCurrent = adminRepository.login(admin);
        return adminCurrent;
    }

    @Override
    public int registered(Admin admin) {
        int registered = adminRepository.registered(admin);
        return registered;
    }

    @Override
    public Admin verifyPass(String adminTel, String oldpass) {
        return adminRepository.verifyPass(adminTel,oldpass);
    }

    @Override
    public int changInfo(Admin admin) {
        return adminRepository.changeInfo(admin);
    }

    @Override
    public int queryByTel(String phone) {
        return adminRepository.queryByTel(phone);
    }

    @Override
    public int remind(Message message) {
        return adminRepository.remind(message);
    }
}
