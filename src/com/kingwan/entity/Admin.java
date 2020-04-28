package com.kingwan.entity;

/**
 * 管理员实体类
 * Created by kingwan on 2020/4/11.
 */
public class Admin {
    private Integer id;
    private String adminName;//管理员姓名
    private String adminTel;//管理员电话
    private String adminMail;//管理员邮箱
    private String adminPassword;//管理员密码

    public Admin() {
    }

    public Admin(Integer id, String adminName, String adminTel, String adminMail, String adminPassword) {
        this.id = id;
        this.adminName = adminName;
        this.adminTel = adminTel;
        this.adminMail = adminMail;
        this.adminPassword = adminPassword;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminTel() {
        return adminTel;
    }

    public void setAdminTel(String adminTel) {
        this.adminTel = adminTel;
    }

    public String getAdminMail() {
        return adminMail;
    }

    public void setAdminMail(String adminMail) {
        this.adminMail = adminMail;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", adminName='" + adminName + '\'' +
                ", adminTel='" + adminTel + '\'' +
                ", adminMail='" + adminMail + '\'' +
                ", adminPassword='" + adminPassword + '\'' +
                '}';
    }
}
