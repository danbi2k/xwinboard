package com.xwin.domain.user;

import java.util.Date;

import com.xwin.infra.util.XwinUtil;

public class MoneyOut extends MoneyInOut
{
	private String bankName;
	private String number;
	private String name;
	
	private Date reqDate;	
	private String reqDateStr;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
}
