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
	private Integer money;
	private Integer expect;
	private String status;
	private Integer gameCount;
	private Integer endCount;
	
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
		this.dateStr = XwinUtil.toDate(date);
	}
	public Double getRate() {
		return rate;
	}
	public void setRate(Double rate) {
		this.rate = rate;
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
	public Integer getGameCount() {
		return gameCount;
	}
	public void setGameCount(Integer gameCount) {
		this.gameCount = gameCount;
	}
	public Integer getEndCount() {
		return endCount;
	}
	public void setEndCount(Integer endCount) {
		this.endCount = endCount;
	}
}
