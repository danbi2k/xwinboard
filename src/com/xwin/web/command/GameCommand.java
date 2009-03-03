package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class GameCommand extends XwinObject
{
	private static final long serialVersionUID = -787424143742458070L;
	
	private String gameId;
	private String homeTeam;
	private String awayTeam;
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	private Double overRate;
	private Double handyRate;
	private Double underRate;
	private boolean uoCheck;
	private String gameDate;
	private Integer gameHour;
	private Integer gameMinute;
	private String status;
	private String leagueId;
	private Integer homeScore;
	private Integer awayScore;
	private String winDeny;
	private String drawDeny;
	private String loseDeny;
	private String grade;
	private String note;
	private String reuse;
	
	public String getGameId() {
		return gameId;
	}
	public void setGameId(String gameId) {
		this.gameId = gameId;
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
	public Double getWinRate() {
		return winRate;
	}
	public void setWinRate(Double winRate) {
		this.winRate = winRate;
	}
	public Double getDrawRate() {
		return drawRate;
	}
	public void setDrawRate(Double drawRate) {
		this.drawRate = drawRate;
	}
	public Double getLoseRate() {
		return loseRate;
	}
	public void setLoseRate(Double loseRate) {
		this.loseRate = loseRate;
	}
	public Double getOverRate() {
		return overRate;
	}
	public void setOverRate(Double overRate) {
		this.overRate = overRate;
	}
	public Double getHandyRate() {
		return handyRate;
	}
	public void setHandyRate(Double handyRate) {
		this.handyRate = handyRate;
	}
	public Double getUnderRate() {
		return underRate;
	}
	public void setUnderRate(Double underRate) {
		this.underRate = underRate;
	}
	public boolean isUoCheck() {
		return uoCheck;
	}
	public void setUoCheck(boolean uoCheck) {
		this.uoCheck = uoCheck;
	}
	public String getGameDate() {
		return gameDate;
	}
	public void setGameDate(String gameDate) {
		this.gameDate = gameDate;
	}
	public Integer getGameHour() {
		return gameHour;
	}
	public void setGameHour(Integer gameHour) {
		this.gameHour = gameHour;
	}
	public Integer getGameMinute() {
		return gameMinute;
	}
	public void setGameMinute(Integer gameMinute) {
		this.gameMinute = gameMinute;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLeagueId() {
		return leagueId;
	}
	public void setLeagueId(String leagueId) {
		this.leagueId = leagueId;
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
	public String getWinDeny() {
		return winDeny;
	}
	public void setWinDeny(String winDeny) {
		this.winDeny = winDeny;
	}
	public String getDrawDeny() {
		return drawDeny;
	}
	public void setDrawDeny(String drawDeny) {
		this.drawDeny = drawDeny;
	}
	public String getLoseDeny() {
		return loseDeny;
	}
	public void setLoseDeny(String loseDeny) {
		this.loseDeny = loseDeny;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getReuse() {
		return reuse;
	}
	public void setReuse(String reuse) {
		this.reuse = reuse;
	}
}
