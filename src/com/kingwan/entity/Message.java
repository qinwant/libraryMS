package com.kingwan.entity;

import java.util.Date;

/**
 * Created by kingwan on 2020/4/26.
 */
public class Message {
    private Integer id;
    private String adminTel;
    private String readerTel;
    private String bookName;
    private String isRead;
    private Date returnTime;

    public Message() {
    }

    public Message(Integer id, String adminTel, String readerTel, String bookName, String isRead, Date returnTime) {
        this.id = id;
        this.adminTel = adminTel;
        this.readerTel = readerTel;
        this.bookName = bookName;
        this.isRead = isRead;
        this.returnTime = returnTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAdminTel() {
        return adminTel;
    }

    public void setAdminTel(String adminTel) {
        this.adminTel = adminTel;
    }

    public String getReaderTel() {
        return readerTel;
    }

    public void setReaderTel(String readerTel) {
        this.readerTel = readerTel;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getIsRead() {
        return isRead;
    }

    public void setIsRead(String isRead) {
        this.isRead = isRead;
    }

    public Date getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(Date returnTime) {
        this.returnTime = returnTime;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", adminTel='" + adminTel + '\'' +
                ", readerTel='" + readerTel + '\'' +
                ", bookName='" + bookName + '\'' +
                ", isRead='" + isRead + '\'' +
                ", returnTime=" + returnTime +
                '}';
    }
}
