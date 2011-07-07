package com.xwin.domain.user;

import java.util.Date;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class Dealer extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -105672944700551224L;
	
	private String id;
	private String dealerId;
	private String nickName;
	private String password;
	private double preFeeRate;
	private double postFeeRate;
	private String mobile;
	private String email;
	private String status;
	private Date joinDate;
	private String bankName;
	private String bankNumber;
	private String bankOwner;
	private String note;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDealerId() {
		return dealerId;
	}
	public void setDealerId(String dealerId) {
		this.dealerId = dealerId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public double getPreFeeRate() {
		return preFeeRate;
	}
	public void setPreFeeRate(double preFeeRate) {
		this.preFeeRate = preFeeRate;
	}
	public double getPostFeeRate() {
		return postFeeRate;
	}
	public void setPostFeeRate(double postFeeRate) {
		this.postFeeRate = postFeeRate;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankNumber() {
		return bankNumber;
	}
	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}
	public String getBankOwner() {
		return bankOwner;
	}
	public void setBankOwner(String bankOwner) {
		this.bankOwner = bankOwner;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
}
