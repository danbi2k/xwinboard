package com.xwin.domain.game;

import java.util.Date;
import java.util.List;

import com.xwin.infra.util.XwinUtil;

public class Betting
{
	private String id;
	private String userId;
	private Date date;
	private String dateStr;
	private Double rate;
	private String rateStr;
	private Integer money;
	private Integer expect;
	private String status;
	private Integer totalCount;
	private Integer successCount;
	private Integer failureCount;
	
	private List<BetGame> betGameList;
	
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
		this.dateStr = XwinUtil.toDateStr(date);
	}
	public Double getRate() {
		return rate;
	}
	public void setRate(Double rate) {
		this.rate = rate;
		this.rateStr = XwinUtil.to2Digit(rate);
	}
	public String getRateStr() {
		return rateStr;
	}
	public void setRateStr(String rateStr) {
		this.rateStr = rateStr;
	}
	public Integer getMoney() {
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
	}
	public List<BetGame> getBetGameList() {
		return betGameList;
	}
	public void setBetGameList(List<BetGame> betGameList) {
		this.betGameList = betGameList;
	}
	public String getDateStr() {
		return dateStr;
	}
	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
	}
	public Integer getExpect() {
		return expect;
	}
	public void setExpect(Integer expect) {
		this.expect = expect;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getSuccessCount() {
		return successCount;
	}
	public void setSuccessCount(Integer successCount) {
		this.successCount = successCount;
	}
	public Integer getFailureCount() {
		return failureCount;
	}
	public void setFailureCount(Integer failureCount) {
		this.failureCount = failureCount;
	}
}
