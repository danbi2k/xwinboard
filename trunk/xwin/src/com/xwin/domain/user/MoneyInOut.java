package com.xwin.domain.user;

import java.util.Date;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class MoneyInOut extends XwinObject
{
	private String id;
	private String userId;
	private String nickName;
	private Long money;
	private String status;
	private Date procDate;
	private String procDateStr;
	private String isChecked;
	private String isDeleted;
	private String note;
	private String name;
	
	private Date reqDate;	
	private String reqDateStr;
	
	private String bankName;
	private String number;
	
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
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getProcDate() {
		return procDate;
	}
	public void setProcDate(Date procDate) {
		this.procDate = procDate;
		this.procDateStr = XwinUtil.toDateStr(procDate, 1);
	}
	public String getProcDateStr() {
		return procDateStr;
	}
	public void setProcDateStr(String procDateStr) {
		this.procDateStr = procDateStr;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
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
