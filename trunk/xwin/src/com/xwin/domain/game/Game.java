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
	private String gameDateStr;
	private Date gameDate;
	private String leagueId;
	private String leagueName;
	
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	
	private String winRateStr;
	private String drawRateStr;
	private String loseRateStr;
	
	private Integer homeScore;
	private Integer awayScore;
	
	private Double handy;
	
	private String result;
	private String type;
	private String betStatus;
	
	private String winBetStatus;
	private String drawBetStatus;
	private String loseBetStatus;

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

	public String getGameDateStr() {
		return gameDateStr;
	}

	public void setGameDateStr(String gameDateStr) {
		this.gameDateStr = gameDateStr;
	}

	public Date getGameDate() {
		return gameDate;
	}

	public void setGameDate(Date gameDate) {
		this.gameDate = gameDate;
		this.gameDateStr = XwinUtil.toDateStr(gameDate, 0);
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

	public Integer getHomeScore() {
		return homeScore;
	}

	public void setHomeScore(Integer homeScore) {
		this.homeScore = homeScore;
	}

	public Integer getAwayScore() {
		return awayScore;
	}

	public void setAwayScore(Integer awayScore) {
		this.awayScore = awayScore;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	public String getGameHour()
	{
		return XwinUtil.getHour(this.gameDate);
	}
	
	public String getGameMinute()
	{
		return XwinUtil.getMinute(this.gameDate);
	}

	public String getBetStatus() {
		return betStatus;
	}

	public void setBetStatus(String betStatus) {
		this.betStatus = betStatus;
	}

	public String getWinBetStatus() {
		return winBetStatus;
	}

	public void setWinBetStatus(String winBetStatus) {
		this.winBetStatus = winBetStatus;
	}

	public String getDrawBetStatus() {
		return drawBetStatus;
	}

	public void setDrawBetStatus(String drawBetStatus) {
		this.drawBetStatus = drawBetStatus;
	}

	public String getLoseBetStatus() {
		return loseBetStatus;
	}

	public void setLoseBetStatus(String loseBetStatus) {
		this.loseBetStatus = loseBetStatus;
	}
}
