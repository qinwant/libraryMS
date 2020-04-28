package com.kingwan.entity;

/**
 * Created by kingwan on 2020/4/24.
 */
public class Info {
    private Long books;//图书总数
    private Long readers;//读者总数
    private Long admins;//管理员总数
    private Long borrows;//累计借阅
    private Long renews;//累计续借

    public Info() {
    }

    public Info(Long books, Long readers, Long admins, Long borrows, Long renews) {
        this.books = books;
        this.readers = readers;
        this.admins = admins;
        this.borrows = borrows;
        this.renews = renews;
    }

    public Long getBooks() {
        return books;
    }

    public void setBooks(Long books) {
        this.books = books;
    }

    public Long getReaders() {
        return readers;
    }

    public void setReaders(Long readers) {
        this.readers = readers;
    }

    public Long getAdmins() {
        return admins;
    }

    public void setAdmins(Long admins) {
        this.admins = admins;
    }

    public Long getBorrows() {
        return borrows;
    }

    public void setBorrows(Long borrows) {
        this.borrows = borrows;
    }

    public Long getRenews() {
        return renews;
    }

    public void setRenews(Long renews) {
        this.renews = renews;
    }

    @Override
    public String toString() {
        return "Info{" +
                "books=" + books +
                ", readers=" + readers +
                ", admins=" + admins +
                ", borrows=" + borrows +
                ", renews=" + renews +
                '}';
    }
}
