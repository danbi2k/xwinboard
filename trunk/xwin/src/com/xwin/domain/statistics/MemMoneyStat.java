package com.xwin.domain.statistics;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class MemMoneyStat extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2976175783683152815L;
	
	private String id;
	private Date date;
	private Long balance;
	private Long money;
	
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
	public Long getBalance() {
		return balance;
	}
	public void setBalance(Long balance) {
		this.balance = balance;
	}
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
}
