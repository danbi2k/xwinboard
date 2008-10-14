package com.xwin.domain.statistics;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class BetMoneyStat extends XwinObject
{
	private String id;
	private Date date;
	private Long inMoney;
	private Long outMoney;
	
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
	public Long getInMoney() {
		return inMoney;
	}
	public void setInMoney(Long inMoney) {
		this.inMoney = inMoney;
	}
	public Long getOutMoney() {
		return outMoney;
	}
	public void setOutMoney(Long outMoney) {
		this.outMoney = outMoney;
	}
}
