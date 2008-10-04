package com.xwin.domain.user;

import java.util.Date;

import com.xwin.infra.util.XwinUtil;

public class Member
{
	private String id;
	private String userId;
	private String nickName;
	private String password;
	private String mobile;
	private String email;
	private String pin;
	private Long balance;
	private String status;
	private String grade;
	private Date joinDate;
	private String joinDateStr;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
	public Long getBalance() {
		return balance;
	}
	public void setBalance(Long balance) {
		this.balance = balance;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
		this.joinDateStr = XwinUtil.toDateStr(joinDate, 1);
	}
	public String getJoinDateStr() {
		return joinDateStr;
	}
	public void setJoinDateStr(String joinDateStr) {
		this.joinDateStr = joinDateStr;
	}
}
