package com.human.project_H.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;



public class Board {
    private BigDecimal bid;
    private String custId;
    private String title;
    private String content;
    private Timestamp modTime;
    private int viewCount;
    private int hitCount;
    private int isDeleted;
    private String nickname;

    // 기본 생성자
    public Board() { }

    // 생성자
    public Board(String title, String content, String custId) {
        this.title = title;
        this.content = content;
        this.custId = custId;
    }

    public Board(BigDecimal bid, String custId, String title, String content, Timestamp modTime, int viewCount,
            int hitCount, int isDeleted) {
        this.bid = bid;
        this.custId = custId;
        this.title = title;
        this.content = content;
        this.modTime = modTime;
        this.viewCount = viewCount;
        this.hitCount = hitCount;
        this.isDeleted = isDeleted;
    }

    public Board(BigDecimal bid, String custId, String title, String content, Timestamp modTime, int viewCount,
            int hitCount, int isDeleted, String nickname) {
        this.bid = bid;
        this.custId = custId;
        this.title = title;
        this.content = content;
        this.modTime = modTime;
        this.viewCount = viewCount;
        this.hitCount = hitCount;
        this.isDeleted = isDeleted;
        this.nickname = nickname;
    }

    // getter, setter 메서드
    public BigDecimal getBid() {
        return bid;
    }

    public void setBid(BigDecimal bid) {
        this.bid = bid;
    }

    public String getCustId() {
        return custId;
    }

    public void setCustId(String custId) {
        this.custId = custId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getModTime() {
        return modTime;
    }

    public void setModTime(Timestamp modTime) {
        this.modTime = modTime;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getHitCount() {
        return hitCount;
    }

    public void setHitCount(int hitCount) {
        this.hitCount = hitCount;
    }

    public int getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    // toString 메서드
    @Override
    public String toString() {
        return "Board [bid=" + bid + ", custId=" + custId + ", title=" + title + ", content=" + content + ", modTime="
                + modTime + ", viewCount=" + viewCount + ", hitCount=" + hitCount + ", isDeleted=" + isDeleted
                + ", nickname=" + nickname + "]";
    }
}
