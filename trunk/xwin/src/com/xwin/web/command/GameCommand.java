package com.xwin.web.command;

public class GameCommand
{
	private String gameId;
	private String homeTeam;
	private String awayTeam;
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	private String gameDate;
	private Integer gameHour;
	private Integer gameMinute;
	private String status;
	private String leagueId;
	private Integer homeScore;
	private Integer awayScore;
	
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
}
