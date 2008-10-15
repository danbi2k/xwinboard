package com.xwin.domain.admin;

import java.util.Date;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class Account extends XwinObject
{
	private String id;
	private Date date;
	private String dateStr;
	private Long money;
	private Long balance;
	private Long oldBalance;
	private String note;
	private String bettingId;
	private String moneyInId;
	private String moneyOutId;
	private String type;
	private String userId;
	
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
		this.dateStr = XwinUtil.toDateStr(date, 1);
	}
	public String getDateStr() {
		return dateStr;
	}
	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
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
	public Long getOldBalance() {
		return oldBalance;
	}
	public void setOldBalance(Long oldBalance) {
		this.oldBalance = oldBalance;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getBettingId() {
		return bettingId;
	}
	public void setBettingId(String bettingId) {
		this.bettingId = bettingId;
	}
	public String getMoneyInId() {
		return moneyInId;
	}
	public void setMoneyInId(String moneyInId) {
		this.moneyInId = moneyInId;
	}
	public String getMoneyOutId() {
		return moneyOutId;
	}
	public void setMoneyOutId(String moneyOutId) {
		this.moneyOutId = moneyOutId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
}
