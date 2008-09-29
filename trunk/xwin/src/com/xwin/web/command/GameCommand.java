package com.xwin.web.command;

public class GameCommand
{
	private String homeTeam;
	private String awayTeam;
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	private Integer year;
	private Integer month;
	private Integer date;
	private Integer hour;
	private Integer minute;
	private String status;
	private String leagueId;
	
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
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public Integer getDate() {
		return date;
	}
	public void setDate(Integer date) {
		this.date = date;
	}
	public Integer getHour() {
		return hour;
	}
	public void setHour(Integer hour) {
		this.hour = hour;
	}
	public Integer getMinute() {
		return minute;
	}
	public void setMinute(Integer minute) {
		this.minute = minute;
	}
	public String getLeagueId() {
		return leagueId;
	}
	public void setLeagueId(String leagueId) {
		this.leagueId = leagueId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
