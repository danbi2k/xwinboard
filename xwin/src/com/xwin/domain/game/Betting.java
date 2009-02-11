package com.xwin.domain.game;

import java.util.Date;
import java.util.List;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class Betting extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2323671094519748848L;
	
	private String id;
	private String userId;
	private Date date;
	private String dateStr;
	private Double rate;
	private String rateStr;
	private Long money;
	private Long expect;
	private String status;
	private String calcStatus;	
	private String introducerId;	
	private String gameType;
	private String nickName;	
	private Date endDate;	
	private String isDeleted;
	private Integer successCount;
	private String gameGrade;
	
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
		this.dateStr = XwinUtil.toDateStr(date, 0);
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
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
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
	public Long getExpect() {
		return expect;
	}
	public void setExpect(Long expect) {
		this.expect = expect;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGameType() {
		return gameType;
	}
	public void setGameType(String gameType) {
		this.gameType = gameType;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getCalcStatus() {
		return calcStatus;
	}
	public void setCalcStatus(String calcStatus) {
		this.calcStatus = calcStatus;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getIntroducerId() {
		return introducerId;
	}
	public void setIntroducerId(String introducerId) {
		this.introducerId = introducerId;
	}
	public Integer getSuccessCount() {
		return successCount;
	}
	public void setSuccessCount(Integer successCount) {
		this.successCount = successCount;
	}
	public String getGameGrade() {
		return gameGrade;
	}
	public void setGameGrade(String gameGrade) {
		this.gameGrade = gameGrade;
	}
	public String toString()
	{
		StringBuffer sb = new StringBuffer();

		sb.append("\nid= " + id);
		sb.append("\nuserId= " + userId);
		sb.append("\nnickName= " + nickName);
		sb.append("\ndateStr= " + dateStr);
		sb.append("\nrateStr= " + rateStr);
		sb.append("\nmoney= " + money);
		sb.append("\nexpect= " + expect);
		sb.append("**********");
		if (betGameList != null) {
			for (BetGame betGame : betGameList) {
				sb.append(betGame.toString());
			}
		}
		
		return sb.toString();
	}
}
