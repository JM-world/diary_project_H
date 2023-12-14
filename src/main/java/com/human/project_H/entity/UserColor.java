package com.human.project_H.entity;

import java.time.LocalDateTime;

public class UserColor {
	private int ucid;
	private String custId;
	private int cid;
	private String content;
	private LocalDateTime modTime;
	private int hitCount;
	private int viewCount;
	private int emotion;
	private boolean commitFlag;
	private boolean shareFlag;
	
	private String title;
	private String nickname;
    private User user;  // User 테이블과 연결되는 필드
    private TodayColor todayColor;  // TodayColor 테이블과 연결되는 필드
    
    
	public UserColor() { } 
	
	
	
	public UserColor(String custId, LocalDateTime modTime) {
		this.custId = custId;
		this.modTime = modTime;
	}

	public UserColor(String custId, int cid, String content, boolean commitFlag, boolean shareFlag) {
		this.custId = custId;
		this.cid = cid;
		this.content = content;
		this.commitFlag = commitFlag;
		this.shareFlag = shareFlag;
	}

	public UserColor(int ucid, String custId, int cid, String content, LocalDateTime modTime, int hitCount, int viewCount,
			int emotion, boolean commitFlag, boolean shareFlag) {
		super();
		this.ucid = ucid;
		this.custId = custId;
		this.cid = cid;
		this.content = content;
		this.modTime = modTime;
		this.hitCount = hitCount;
		this.viewCount = viewCount;
		this.emotion = emotion;
		this.commitFlag = commitFlag;
		this.shareFlag = shareFlag;
	}

	public int getUcid() {
		return ucid;
	}

	public void setUcid(int ucid) {
		this.ucid = ucid;
	}

	public String getcustId() {
		return custId;
	}

	public void setcustId(String custId) {
		this.custId = custId;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getModTime() {
		return modTime;
	}

	public void setModTime(LocalDateTime modTime) {
		this.modTime = modTime;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getEmotion() {
		return emotion;
	}

	public void setEmotion(int emotion) {
		this.emotion = emotion;
	}

	public boolean getCommitFlag() {
		return commitFlag;
	}

	public void setCommitFlag(boolean commitFlag) {
		this.commitFlag = commitFlag;
	}

	public boolean getShareFlag() {
		return shareFlag;
	}

	public void setShareFlag(boolean shareFlag) {
		this.shareFlag = shareFlag;
	}

	
	public User getUser() {
		return user;
	}



	public void setUser(User user) {
		this.user = user;
	}



	public TodayColor getTodayColor() {
		return todayColor;
	}



	public void setTodayColor(TodayColor todayColor) {
		this.todayColor = todayColor;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}

	

	public String getNickname() {
		return nickname;
	}



	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	


	public String getCustId() {
		return custId;
	}



	public void setCustId(String custId) {
		this.custId = custId;
	}



	@Override
	public String toString() {
		return "UserColor [ucid=" + ucid + ", custId=" + custId + ", cid=" + cid + ", content=" + content + ", modTime="
				+ modTime + ", hitCount=" + hitCount + ", viewCount=" + viewCount + ", emotion=" + emotion
				+ ", commitFlag=" + commitFlag + ", shareFlag=" + shareFlag + "]";
	}
	
	
	
	
	
	


}
