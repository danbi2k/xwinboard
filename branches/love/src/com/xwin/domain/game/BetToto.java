package com.xwin.domain.game;

public class BetToto extends Game
{
	private static final long serialVersionUID = 4739208784483978447L;
	
	private String id;
	private String totoId;
	private String userId;
	private String nickName;
	private String date;
	private String rate;
	private String money;
	private String calcStatus;
	private String status;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getCalcStatus() {
		return calcStatus;
	}
	public void setCalcStatus(String calcStatus) {
		this.calcStatus = calcStatus;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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