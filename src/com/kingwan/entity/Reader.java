package com.kingwan.entity;

/**
 * Created by kingwan on 2020/4/11.
 */
public class Reader {
    private Integer id;
    private String name;
    private String tel;
    private String mail;
    private String password;
    private String status;
    private String photo;
    private String sex;
    private Integer age;
    private String message;

    public Reader() {
    }

    public Reader(Integer id, String name, String tel, String mail, String password, String status, String photo, String sex, Integer age, String message) {
        this.id = id;
        this.name = name;
        this.tel = tel;
        this.mail = mail;
        this.password = password;
        this.status = status;
        this.photo = photo;
        this.sex = sex;
        this.age = age;
        this.message = message;
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Reader{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", tel='" + tel + '\'' +
                ", mail='" + mail + '\'' +
                ", password='" + password + '\'' +
                ", status='" + status + '\'' +
                ", photo='" + photo + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                ", message='" + message + '\'' +
                '}';
    }
}
