package com.xwin.domain.log;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class OtpLog extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1716593751838644409L;
	
	private String id;
	private Date date;
	private String phone;
	private String pin;
	private String ipAddress;
	
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
}
