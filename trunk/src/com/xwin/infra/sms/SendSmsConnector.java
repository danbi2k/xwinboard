package com.xwin.infra.sms;

import java.util.List;

public interface SendSmsConnector
{
	public void sendSms(String message, String phone, String callback) throws Exception;
	public void sendSmsList(String message, List<String> phoneList, String callback) throws Exception;
}
