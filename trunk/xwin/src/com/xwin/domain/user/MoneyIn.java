package com.xwin.domain.user;

import java.util.Date;

import com.xwin.domain.admin.BankBook;
import com.xwin.infra.util.XwinUtil;

public class MoneyIn extends MoneyInOut
{
	private String name;
	private String bankBookId;
	private BankBook bankBook;
	
	private Date reqDate;	
	private String reqDateStr;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBankBookId() {
		return bankBookId;
	}
	public void setBankBookId(String bankBookId) {
		this.bankBookId = bankBookId;
	}
	public BankBook getBankBook() {
		return bankBook;
	}
	public void setBankBook(BankBook bankBook) {
		this.bankBook = bankBook;
	}
	public Date getReqDate() {
		return reqDate;
	}
	public void setReqDate(Date reqDate) {
		this.reqDate = reqDate;
		this.reqDateStr = XwinUtil.toDateStr(reqDate, 1);
	}
	public String getReqDateStr() {
		return reqDateStr;
	}
	public void setReqDateStr(String reqDateStr) {
		this.reqDateStr = reqDateStr;
	}
}
