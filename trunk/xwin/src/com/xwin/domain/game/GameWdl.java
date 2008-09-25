package com.xwin.domain.game;

public class GameWdl extends Game
{
	private double winRate;
	private double drawRate;
	private double loseRate;
	
	public double getWinRate() {
		return winRate;
	}
	public void setWinRate(double winRate) {
		this.winRate = winRate;
	}
	public double getDrawRate() {
		return drawRate;
	}
	public void setDrawRate(double drawRate) {
		this.drawRate = drawRate;
	}
	public double getLoseRate() {
		return loseRate;
	}
	public void setLoseRate(double loseRate) {
		this.loseRate = loseRate;
	}
}
