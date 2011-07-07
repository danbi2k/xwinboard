package com.xwin.domain.statistics;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class DealerSummary extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -479696618961167951L;
	
	private String id;
	private String dealerId;
	private Date date;
	private Integer totalBettingMoney;
	private Integer failureBettingMoney;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDealerId() {
		return dealerId;
	}
	public void setDealerId(String dealerId) {
		this.dealerId = dealerId;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Integer getTotalBettingMoney() {
		return totalBettingMoney;
	}
	public void setTotalBettingMoney(Integer totalBettingMoney) {
		this.totalBettingMoney = totalBettingMoney;
	}
	public Integer getFailureBettingMoney() {
		return failureBettingMoney;
	}
	public void setFailureBettingMoney(Integer failureBettingMoney) {
		this.failureBettingMoney = failureBettingMoney;
	}
}
