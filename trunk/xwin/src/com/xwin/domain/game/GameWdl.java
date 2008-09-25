package com.xwin.domain.game;

public class GameWdl extends Game
{
	private Double winRate;
	private Double drawRate;
	private Double loseRate;
	
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
}
