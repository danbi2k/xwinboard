package com.xwin.domain.comm;

public class KtfSmsMessage
{
	private String id;
	private String msgSeq;
	private String inDate;
	private String msg;
	private String sm;
	private String callBack;	
	
	public KtfSmsMessage() {};
	
	public KtfSmsMessage( String id, String msgSeq, String msg, String callBack,
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
}
