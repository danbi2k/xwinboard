package com.xwin.infra.sms;

import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;

public class MunjaBadaConnector implements SendSmsConnector
{
	private final String URL = "http://www.munjabada.co.kr/Remote/RemoteSms.php";
	
	private String userId;
	private String password;
	private String returnUrl;
	
	public void sendSms(String message, String phone, String callback) throws Exception
	{
		HttpClient hc = new HttpClient();
		PostMethod method = new PostMethod(URL);
		method.addRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=euc-kr");
		
		method.setParameter("remote_id", userId);
		method.setParameter("remote_pass", password);
		method.setParameter("remote_returnurl", returnUrl);
		method.setParameter("remote_num", "1");
		method.setParameter("remote_phone", phone.replaceAll("-", ""));
		method.setParameter("remote_callback", callback);
		method.setParameter("remote_msg", message);
		try {		
		hc.executeMethod(method);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void sendSmsList(String message, List<String> phoneList, String callback)
			throws Exception
	{
		HttpClient hc = new HttpClient();
		PostMethod method = new PostMethod(URL);
		method.addRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=euc-kr");

		int size = phoneList.size();
		StringBuffer sb = new StringBuffer();
		if (phoneList != null && phoneList.size() > 0) {
			int count = 0;
			for (String phone : phoneList) {
				sb.append(phone.replaceAll("-", ""));
				if (++count < size)
					sb.append(",");
			}
			
			method.setParameter("remote_id", userId);
			method.setParameter("remote_pass", password);
			method.setParameter("remote_num", "" + size);
			method.setParameter("remote_phone", sb.toString());
			method.setParameter("remote_callback", callback);
			method.setParameter("remote_msg", message);
			
			hc.executeMethod(method);
			System.out.println(method.getResponseBodyAsString());
		}
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}
}
