package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class MemberCommand extends XwinObject
{
	private static final long serialVersionUID = -9024700845464615238L;
	
	private String userId;
	private String nickName;
	private String phone1;
	private String phone2;
	private String phone3;
	private String phonePin;
	private String email1;
	private String email2;
	private String password1;
	private String password2;
	private String pin;
	private String bankName;
	private String bankNumber;
	private String bankOwner;
	private String smsCheck;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId.trim();
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName.trim();
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1.trim();
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2.trim();
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3.trim();
	}
	public String getPhonePin() {
		return phonePin;
	}
	public void setPhonePin(String phonePin) {
		this.phonePin = phonePin.trim();
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1.trim();
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2.trim();
	}
	public String getPassword1() {
		return password1;
	}
	public void setPassword1(String password1) {
		this.password1 = password1.trim();
	}
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2.trim();
	}
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin.trim();
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName.trim();
	}
	public String getBankNumber() {
		return bankNumber;
	}
	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber.trim();
	}
	public String getBankOwner() {
		return bankOwner;
	}
	public void setBankOwner(String bankOwner) {
		this.bankOwner = bankOwner.trim();
	}
	public String getSmsCheck() {
		return smsCheck;
	}
	public void setSmsCheck(String smsCheck) {
		this.smsCheck = smsCheck;
	}
}
