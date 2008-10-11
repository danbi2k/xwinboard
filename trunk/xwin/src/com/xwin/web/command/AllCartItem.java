package com.xwin.web.command;

import java.util.Date;
import java.util.List;

public class AllCartItem
{
	private Long money;
	private Double rate;
	private Long expect;
	private Date date;
	
	private List<GameCartItem> cartItemList;
	
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
	public List<GameCartItem> getCartItemList() {
		return cartItemList;
	}
	public void setCartItemList(List<GameCartItem> cartItemList) {
		this.cartItemList = cartItemList;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
}
