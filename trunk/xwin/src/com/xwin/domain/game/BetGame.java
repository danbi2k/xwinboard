package com.xwin.domain.game;

public class BetGame extends Game
{
	private String bettingId;
	private String guess;
	private String resultStatus;
	private Double selRate;
	
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
	public String getResultStatus() {
		return resultStatus;
	}
	public void setResultStatus(String resultStatus) {
		this.resultStatus = resultStatus;
	}
	public Double getSelRate() {
		return selRate;
	}
	public void setSelRate(Double selRate) {
		this.selRate = selRate;
	}
}