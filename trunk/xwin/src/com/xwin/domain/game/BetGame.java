package com.xwin.domain.game;

public class BetGame extends Game
{
	private String bettingId;
	private String guess;
	private Double guessRate;
	private String hit;
	
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
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public Double getGuessRate() {
		return guessRate;
	}
	public void setGuessRate(Double guessRate) {
		this.guessRate = guessRate;
	}
}