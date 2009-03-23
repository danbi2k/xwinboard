package com.xwin.domain.game;

import java.util.Date;

public class BetToto extends Toto
{
	private static final long serialVersionUID = 4739208784483978447L;
	
	private String id;
	private String totoId;
	private String userId;
	private String nickName;
	private Date date;
	private Double rate;
	private Integer money;
	private String calcStatus;
	private String runStatus;
	private String isDeleted;
	private String endDate;
	private String markingString;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTotoId() {
		return totoId;
	}
	public void setTotoId(String totoId) {
		this.totoId = totoId;
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
	public String getCalcStatus() {
		return calcStatus;
	}
	public void setCalcStatus(String calcStatus) {
		this.calcStatus = calcStatus;
	}
	public String getRunStatus() {
		return runStatus;
	}
	public void setRunStatus(String runStatus) {
		this.runStatus = runStatus;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getMarkingString() {
		return markingString;
	}
	public void setMarkingString(String markingString) {
		this.markingString = markingString;
	}
}