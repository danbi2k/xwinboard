package com.xwin.domain.comm;

import com.xwin.domain.XwinObject;

public class ShowSmsMessage extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7976983867334263338L;
	
	private String id;
	private String msgSeq;
	private String inDate;
	private String msg;
	private String sm;
	private String callBack;	
	private String status;
	
	public ShowSmsMessage() {};
	
	public ShowSmsMessage( String id, String msgSeq, String msg, String callBack,
			String inDate, String sm) {
		this.callBack = callBack;
		this.id = id;
		this.inDate = inDate;
		this.msg = msg;
		this.msgSeq = msgSeq;
		this.sm = sm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getSm() {
		return sm;
	}
	public void setSm(String sm) {
		this.sm = sm;
	}
	public String getCallBack() {
		return callBack;
	}
	public void setCallBack(String callBack) {
		this.callBack = callBack;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("\nid = " + id);
		sb.append("\nmsgSeq = " + msgSeq);
		sb.append("\ninDate = " + inDate);
		sb.append("\nmsg = " + msg);
		sb.append("\nsm = " + sm);
		sb.append("\ncallBack = " + callBack);
		sb.append("\nstatus = " + status);
		sb.append("\n");
		
		return sb.toString();
	}
}
