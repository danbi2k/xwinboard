package com.xwin.domain.admin;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class Transaction extends XwinObject
{
	private String id;
	private Date date;
	private String type;
	private String userName;
	private Long money;
	private Long balance;
	private String isCharge;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
	public Long getBalance() {
		return balance;
	}
	public void setBalance(Long balance) {
		this.balance = balance;
	}
	public String getIsCharge() {
		return isCharge;
	}
	public void setIsCharge(String isCharge) {
		this.isCharge = isCharge;
	}
}
