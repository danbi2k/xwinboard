package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class FolderCalc extends XwinObject
{
	private static final long serialVersionUID = 4538168542784029622L;
	
	private Long money;
	private Double rate;
	private Long expect;
	private Long balance;
	private Long after;
	
	public FolderCalc() {}
		
	public FolderCalc(Long after, Long balance, Long money, Long expect,
			Double rate) {
		this.after = after;
		this.balance = balance;
		this.money = money;
		this.expect = expect;
		this.rate = rate;
	}
	
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
	public Double getRate() {
		return rate;
	}
	public void setRate(Double rate) {
		this.rate = rate;
	}
	public Long getExpect() {
		return expect;
	}
	public void setExpect(Long expect) {
		this.expect = expect;
	}
	public Long getBalance() {
		return balance;
	}
	public void setBalance(Long balance) {
		this.balance = balance;
	}
	public Long getAfter() {
		return after;
	}
	public void setAfter(Long after) {
		this.after = after;
	}	
}
