package com.xwin.domain.game;

import java.util.Date;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class Game extends XwinObject
{
	private String id;
	private String homeTeam;
	private String awayTeam;
	private String status;
	private String dateStr;
	private Date date;
	private String leagueId;
	private String leagueName;
	
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	
	private String winRateStr;
	private String drawRateStr;
	private String loseRateStr;
	
	private Double handy;
	
	private String type;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getHomeTeam() {
		return homeTeam;
	}

	public void setHomeTeam(String homeTeam) {
		this.homeTeam = homeTeam;
	}

	public String getAwayTeam() {
		return awayTeam;
	}

	public void setAwayTeam(String awayTeam) {
		this.awayTeam = awayTeam;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDateStr() {
		return dateStr;
	}

	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
		this.dateStr = XwinUtil.toDate(date);
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

	public Double getWinRate() {
		return winRate;
	}

	public void setWinRate(Double winRate) {
		this.winRate = winRate;
		this.winRateStr = XwinUtil.to2Digit(winRate);
	}

	public Double getDrawRate() {
		return drawRate;
	}

	public void setDrawRate(Double drawRate) {
		this.drawRate = drawRate;
		this.drawRateStr = XwinUtil.to2Digit(drawRate);
	}

	public Double getLoseRate() {
		return loseRate;
	}

	public void setLoseRate(Double loseRate) {
		this.loseRate = loseRate;
		this.loseRateStr = XwinUtil.to2Digit(loseRate);
	}

	public Double getHandy() {
		return handy;
	}

	public void setHandy(Double handy) {
		this.handy = handy;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getWinRateStr() {
		return winRateStr;
	}

	public void setWinRateStr(String winRateStr) {
		this.winRateStr = winRateStr;
	}

	public String getDrawRateStr() {
		return drawRateStr;
	}

	public void setDrawRateStr(String drawRateStr) {
		this.drawRateStr = drawRateStr;
	}

	public String getLoseRateStr() {
		return loseRateStr;
	}

	public void setLoseRateStr(String loseRateStr) {
		this.loseRateStr = loseRateStr;
	}
}
