package com.xwin.web.command;

public class CartCalc
{
	private String bet;
	private String rate;
	private String expect;
	private String balance;
	private String after;
	
	public CartCalc() {}
		
	public CartCalc(String after, String balance, String bet, String expect,
			String rate) {
		this.after = after;
		this.balance = balance;
		this.bet = bet;
		this.expect = expect;
		this.rate = rate;
	}
	
	public String getBet() {
		return bet;
	}
	public void setBet(String bet) {
		this.bet = bet;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getExpect() {
		return expect;
	}
	public void setExpect(String expect) {
		this.expect = expect;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	public String getAfter() {
		return after;
	}
	public void setAfter(String after) {
		this.after = after;
	}	
}
