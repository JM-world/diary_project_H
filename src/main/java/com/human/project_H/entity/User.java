package com.human.project_H.entity;

import java.time.LocalDate;

public class User {
	private String custId;
	private String pwd;
	private String uname;
	private String nickName;
	private String email;
	private LocalDate regDate;
	private int isDeleted;
	
	public User() { }
	public User(String custId, String pwd, String uname, String nickName, String email) {
		this.custId = custId;
		this.pwd = pwd;
		this.uname = uname;
		this.nickName = nickName;
		this.email = email;
	}
	public User(String custId, String pwd, String uname, String nickName, String email, LocalDate regDate, int isDeleted) {
		this.custId = custId;
		this.pwd = pwd;
		this.uname = uname;
		this.nickName = nickName;
		this.email = email;
		this.regDate = regDate;
		this.isDeleted = isDeleted;
	}
	public String getCustid() {
		return custId;
	}
	public void setCustid(String custId) {
		this.custId = custId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getnickName() {
		return nickName;
	}
	public void setnickName(String nickName) {
		this.nickName = nickName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public LocalDate getRegDate() {
		return regDate;
	}
	public void setRegDate(LocalDate regDate) {
		this.regDate = regDate;
	}
	public int getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(int isDeleted) {
		this.isDeleted = isDeleted;
	}
	@Override
	public String toString() {
		return "User [custId=" + custId + ", pwd=" + pwd + ", uname=" + uname + ", nickName=" + nickName + ", email=" + email
				+ ", regDate=" + regDate + ", isDeleted=" + isDeleted + "]";
	}
	
}
	
	