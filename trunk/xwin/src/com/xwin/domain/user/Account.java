package com.xwin.domain.user;

import java.util.Date;

public class Account
{
	private String id;
	private String userId;
	private Integer money;
	private String type;
	private String bettingId;
	private Date date;
	
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
	public Integer getMoney() {
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBettingId() {
		return bettingId;
	}
	public void setBettingId(String bettingId) {
		this.bettingId = bettingId;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
}
