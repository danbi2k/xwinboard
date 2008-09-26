package com.xwin.domain.game;

import java.util.Date;
import java.util.List;

public class Betting
{
	private String id;
	private String userId;
	private Date date;
	private Double rate;
	private Integer money;
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
}
