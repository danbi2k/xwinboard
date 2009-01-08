package com.xwin.domain.game;

import com.xwin.domain.XwinObject;

public class GameFolderItem extends XwinObject
{
	private static final long serialVersionUID = 5384098081793435381L;
	
	private String gameId;
	private String homeTeam;
	private String awayTeam;
	private String guess;
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	private Double selRate;
	private String league;
	
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
	public String getGuess() {
		return guess;
	}
	public void setGuess(String guess) {
		this.guess = guess;
	}
	public String getLeague() {
		return league;
	}
	public void setLeague(String league) {
		this.league = league;
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
	public Double getSelRate() {
		return selRate;
	}
	public void setSelRate(Double selRate) {
		this.selRate = selRate;
	}	
}