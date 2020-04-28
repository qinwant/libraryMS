package com.kingwan.entity;

import java.util.Date;

/**
 * Created by kingwan on 2020/4/11.
 */
public class Borrow {
    private Integer id;
    private String bookId;
    private String readerName;
    private String readerTel;
    private String bookName;
    private Date borrowTime;
    private Date returnTimePre;
    private String isReturn;
    private String isRenew;

    public Borrow() {
    }

    public Borrow(Integer id, String bookId, String readerName, String readerTel, String bookName, Date borrowTime, Date returnTimePre, String isReturn, String isRenew) {
        this.id = id;
        this.bookId = bookId;
        this.readerName = readerName;
        this.readerTel = readerTel;
        this.bookName = bookName;
        this.borrowTime = borrowTime;
        this.returnTimePre = returnTimePre;
        this.isReturn = isReturn;
        this.isRenew = isRenew;
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

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public Date getBorrowTime() {
        return borrowTime;
    }

    public void setBorrowTime(Date borrowTime) {
        this.borrowTime = borrowTime;
    }

    public Date getReturnTimePre() {
        return returnTimePre;
    }

    public void setReturnTimePre(Date returnTimePre) {
        this.returnTimePre = returnTimePre;
    }

    public String getIsReturn() {
        return isReturn;
    }

    public void setIsReturn(String isReturn) {
        this.isReturn = isReturn;
    }

    public void setIsRenew(String isRenew) {
        this.isRenew = isRenew;
    }

    public String getIsRenew() {
        return isRenew;
    }

    @Override
    public String toString() {
        return "Borrow{" +
                "id=" + id +
                ", bookId='" + bookId + '\'' +
                ", readerName='" + readerName + '\'' +
                ", readerTel='" + readerTel + '\'' +
                ", bookName='" + bookName + '\'' +
                ", borrowTime=" + borrowTime +
                ", returnTimePre=" + returnTimePre +
                ", isReturn='" + isReturn + '\'' +
                ", isRenew='" + isRenew + '\'' +
                '}';
    }
}
