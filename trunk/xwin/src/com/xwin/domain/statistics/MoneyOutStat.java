package com.xwin.domain.statistics;

import com.xwin.domain.XwinObject;

public class MoneyOutStat extends XwinObject
{
	private static final long serialVersionUID = 7555296810210046178L;
	
	private String bankName;
	private String number;
	private String name;
	private Integer outCount;
	private Integer outSum;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getOutCount() {
		return outCount;
	}
	public void setOutCount(Integer outCount) {
		this.outCount = outCount;
	}
	public Integer getOutSum() {
		return outSum;
	}
	public void setOutSum(Integer outSum) {
		this.outSum = outSum;
	}	
}
