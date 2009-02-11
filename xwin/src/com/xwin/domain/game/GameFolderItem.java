package com.xwin.domain.game;

public class GameFolderItem extends Game
{
	private static final long serialVersionUID = 5384098081793435381L;
	
	private String guess;	
	private Double selRate;
	
	public String getGuess() {
		return guess;
	}
	public void setGuess(String guess) {
		this.guess = guess;
	}
	public Double getSelRate() {
		return selRate;
	}
	public void setSelRate(Double selRate) {
		this.selRate = selRate;
	}
}