package com.kingwan.entity;

/**
 * 图书信息实体类
 * Created by kingwan on 2020/4/11.
 */
public class Book {
    private Integer id;
    private String name;//书名
    private String bookCase;//图书类型
    private String photo;//图书封面
    private String publisher;//出版社
    private String author;//作者
    private Integer count;//馆藏总数
    private Integer borrowed;//已借数目
    private String hot;//热门书籍

    public Book() {
    }

    public String getHot() {
        return hot;
    }

    public void setHot(String hot) {
        this.hot = hot;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBookCase() {
        return bookCase;
    }

    public void setBookCase(String bookCase) {
        this.bookCase = bookCase;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getBorrowed() {
        return borrowed;
    }

    public void setBorrowed(Integer borrowed) {
        this.borrowed = borrowed;
    }

    public Book(Integer id, String name, String bookCase, String photo, String publisher, String author, Integer count, Integer borrowed, String hot) {
        this.id = id;
        this.name = name;
        this.bookCase = bookCase;
        this.photo = photo;
        this.publisher = publisher;
        this.author = author;
        this.count = count;
        this.borrowed = borrowed;
        this.hot = hot;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", bookCase='" + bookCase + '\'' +
                ", photo='" + photo + '\'' +
                ", publisher='" + publisher + '\'' +
                ", author='" + author + '\'' +
                ", count=" + count +
                ", borrowed=" + borrowed +
                ", hot='" + hot + '\'' +
                '}';
    }
}
