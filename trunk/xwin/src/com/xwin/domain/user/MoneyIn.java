package com.xwin.domain.user;

import java.util.Date;

import com.xwin.domain.admin.BankBook;
import com.xwin.infra.util.XwinUtil;

public class MoneyIn
{
	private String id;
	private String userId;
	private Integer money;
	private String name;
	private String status;
	private String bankBookId;
	private BankBook bankBook;
	
	private Date reqDate;
	private Date procDate;
	
	private String reqDateStr;
	private String procDateStr;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Integer getMoney() {
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
		this.reqDateStr = XwinUtil.toDateStr(reqDate);
	}
	public Date getProcDate() {
		return procDate;
	}
	public void setProcDate(Date procDate) {
		this.procDate = procDate;
		this.procDateStr = XwinUtil.toDateStr(procDate);
	}
	public String getReqDateStr() {
		return reqDateStr;
	}
	public void setReqDateStr(String reqDateStr) {
		this.reqDateStr = reqDateStr;
	}
	public String getProcDateStr() {
		return procDateStr;
	}
	public void setProcDateStr(String procdateStr) {
		this.procDateStr = procdateStr;
	}
}
