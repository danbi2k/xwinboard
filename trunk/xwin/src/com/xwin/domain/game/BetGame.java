package com.xwin.domain.game;

public class BetGame extends Game
{
	private String bettingId;
	private String guess;
	
	public String getBettingId() {
		return bettingId;
	}
	public void setBettingId(String bettingId) {
		this.bettingId = bettingId;
	}
	public String getGuess() {
		return guess;
	}
	public void setGuess(String guess) {
		this.guess = guess;
	}
}
