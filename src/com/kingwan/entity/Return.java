package com.kingwan.entity;

import java.util.Date;

/**
 * Created by kingwan on 2020/4/11.
 */
public class Return {
    private Integer id;
    private String bookId;
    private String bookName;
    private String readerName;
    private String readerTel;
    private Date returnTime;

    public Return() {
    }

    public Return(Integer id, String bookId, String bookName, String readerName, String readerTel, Date returnTime) {
        this.id = id;
        this.bookId = bookId;
        this.bookName = bookName;
        this.readerName = readerName;
        this.readerTel = readerTel;
        this.returnTime = returnTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getReaderName() {
        return readerName;
    }

    public void setReaderName(String readerName) {
        this.readerName = readerName;
    }

    public String getReaderTel() {
        return readerTel;
    }

    public void setReaderTel(String readerTel) {
        this.readerTel = readerTel;
    }

    public Date getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(Date returnTime) {
        this.returnTime = returnTime;
    }

    @Override
    public String toString() {
        return "Return{" +
                "id=" + id +
                ", bookId='" + bookId + '\'' +
                ", bookName='" + bookName + '\'' +
                ", readerName='" + readerName + '\'' +
                ", readerTel='" + readerTel + '\'' +
                ", returnTime=" + returnTime +
                '}';
    }
}
