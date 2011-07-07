package com.xwin.domain.join;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class Invitation extends XwinObject
{
	private static final long serialVersionUID = -3904886426193187817L;
	
	private String id;
	private String userId;
	private String dealerId;
	private String inviteKey;
	private String mobile;
	private Date sendDate;
	private String joinId;
	private String source;
	
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
	public String getDealerId() {
		return dealerId;
	}
	public void setDealerId(String dealerId) {
		this.dealerId = dealerId;
	}
	public String getInviteKey() {
		return inviteKey;
	}
	public void setInviteKey(String inviteKey) {
		this.inviteKey = inviteKey;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getJoinId() {
		return joinId;
	}
	public void setJoinId(String joinId) {
		this.joinId = joinId;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
}
