package org.learncommunity.entity;

import java.util.Date;

public class User {
    private Integer id;

    private String email;

    private String name;

    private String password;

    private String phone;

    private Date brithday;

    private String address;

    private String description;

    private String educationalbackground;

    private String goodat;

    private String photourl;

    private Integer classcnt;

    private Integer topiccnt;

    private Integer replycnt;

    private Integer root;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Date getBrithday() {
        return brithday;
    }

    public void setBrithday(Date brithday) {
        this.brithday = brithday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getEducationalbackground() {
        return educationalbackground;
    }

    public void setEducationalbackground(String educationalbackground) {
        this.educationalbackground = educationalbackground == null ? null : educationalbackground.trim();
    }

    public String getGoodat() {
        return goodat;
    }

    public void setGoodat(String goodat) {
        this.goodat = goodat == null ? null : goodat.trim();
    }

    public String getPhotourl() {
        return photourl;
    }

    public void setPhotourl(String photourl) {
        this.photourl = photourl == null ? null : photourl.trim();
    }

    public Integer getClasscnt() {
        return classcnt;
    }

    public void setClasscnt(Integer classcnt) {
        this.classcnt = classcnt;
    }

    public Integer getTopiccnt() {
        return topiccnt;
    }

    public void setTopiccnt(Integer topiccnt) {
        this.topiccnt = topiccnt;
    }

    public Integer getReplycnt() {
        return replycnt;
    }

    public void setReplycnt(Integer replycnt) {
        this.replycnt = replycnt;
    }

    public Integer getRoot() {
        return root;
    }

    public void setRoot(Integer root) {
        this.root = root;
    }
}