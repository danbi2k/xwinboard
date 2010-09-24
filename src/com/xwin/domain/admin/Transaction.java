package com.xwin.domain.admin;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class Transaction extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5323063324662410398L;
	
	private String id;
	private Date date;
	private String type;
	private String userName;
	private Long money;
	private Long balance;
	private String isCharge;
	private String msgSeq;
	private String inDate;
	private String moneyInId;
	private String moneyOutId;
	private String note;
	private String bankName;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
	public Long getBalance() {
		return balance;
	}
	public void setBalance(Long balance) {
		this.balance = balance;
	}
	public String getIsCharge() {
		return isCharge;
	}
	public void setIsCharge(String isCharge) {
		this.isCharge = isCharge;
	}
	public String getMsgSeq() {
		return msgSeq;
	}
	public void setMsgSeq(String msgSeq) {
		this.msgSeq = msgSeq;
	}
	public String getInDate() {
		return inDate;
	}
	public void setInDate(String inDate) {
		this.inDate = inDate;
	}
	public String getMoneyInId() {
		return moneyInId;
	}
	public void setMoneyInId(String moneyInId) {
		this.moneyInId = moneyInId;
	}
	public String getMoneyOutId() {
		return moneyOutId;
	}
	public void setMoneyOutId(String moneyOutId) {
		this.moneyOutId = moneyOutId;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	
	public String toString() {
		return "Transaction [balance=" + balance + "\n bankName=" + bankName
				+ "\n date=" + date + "\n id=" + id + "\n inDate=" + inDate
				+ "\n isCharge=" + isCharge + "\n money=" + money
				+ "\n moneyInId=" + moneyInId + "\n moneyOutId=" + moneyOutId
				+ "\n msgSeq=" + msgSeq + "\n note=" + note + "\n type=" + type
				+ "\n userName=" + userName + "]";
	}
}
