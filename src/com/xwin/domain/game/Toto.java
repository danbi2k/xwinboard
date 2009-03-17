package com.xwin.domain.game;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class Toto extends XwinObject
{
	private static final long serialVersionUID = 7627155696329993555L;
	
	private String id;
	private Date gameDate;
	private String title;
	private String leagueId;
	private String leagueName;
	private String leagueImage;
	private Double earnRate;
	private String resultString;
	private String cardString;
	private Integer rowNum;
	private Integer colNum;
	private String status;
	private String betStatus;
	private String displayStatus;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getGameDate() {
		return gameDate;
	}
	public void setGameDate(Date gameDate) {
		this.gameDate = gameDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLeagueId() {
		return leagueId;
	}
	public void setLeagueId(String leagueId) {
		this.leagueId = leagueId;
	}
	public String getLeagueName() {
		return leagueName;
	}
	public void setLeagueName(String leagueName) {
		this.leagueName = leagueName;
	}
	public String getLeagueImage() {
		return leagueImage;
	}
	public void setLeagueImage(String leagueImage) {
		this.leagueImage = leagueImage;
	}
	public Double getEarnRate() {
		return earnRate;
	}
	public void setEarnRate(Double earnRate) {
		this.earnRate = earnRate;
	}
	public String getResultString() {
		return resultString;
	}
	public void setResultString(String resultString) {
		this.resultString = resultString;
	}
	public String getCardString() {
		return cardString;
	}
	public void setCardString(String cardString) {
		this.cardString = cardString;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBetStatus() {
		return betStatus;
	}
	public void setBetStatus(String betStatus) {
		this.betStatus = betStatus;
	}
	public String getDisplayStatus() {
		return displayStatus;
	}
	public void setDisplayStatus(String displayStatus) {
		this.displayStatus = displayStatus;
	}
	public Integer getRowNum() {
		return rowNum;
	}
	public void setRowNum(Integer rowNum) {
		this.rowNum = rowNum;
	}
	public Integer getColNum() {
		return colNum;
	}
	public void setColNum(Integer colNum) {
		this.colNum = colNum;
	}
}
