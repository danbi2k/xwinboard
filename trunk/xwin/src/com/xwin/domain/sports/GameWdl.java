package com.xwin.domain.sports;

public class GameWdl extends Game
{
	private float winRate;
	private float drawRate;
	private float loseRate;
	
	public float getWinRate() {
		return winRate;
	}
	public void setWinRate(float winRate) {
		this.winRate = winRate;
	}
	public float getDrawRate() {
		return drawRate;
	}
	public void setDrawRate(float drawRate) {
		this.drawRate = drawRate;
	}
	public float getLoseRate() {
		return loseRate;
	}
	public void setLoseRate(float loseRate) {
		this.loseRate = loseRate;
	}
}
