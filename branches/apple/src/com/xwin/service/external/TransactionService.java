package com.xwin.service.external;

import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import com.xwin.domain.admin.Transaction;
import com.xwin.infra.util.XmlUtil;
import com.xwin.service.admin.XwinService;

public class TransactionService extends XwinService
{
	private static final String SERVER_URL = "http://bethit.net:10180/external.aspx?mode=setTransaction";
	//private static final String SERVER_URL = "http://localhost:8080/xwin/external.aspx?mode=setTransaction";
	
	public void sendTransaction(List<Transaction> transactionList)
	{
		HttpClient hc = new HttpClient();
		hc.getHttpConnectionManager().getParams().setSoTimeout(10000);
		
		String xml = XmlUtil.toXml(transactionList);
		
		PostMethod post = new PostMethod(SERVER_URL);
		post.addRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
		post.setRequestBody(
				new NameValuePair[] {
						new NameValuePair("transactionList", xml)
				}
		);
		
		try {
			hc.executeMethod(post);
			if (post.getStatusCode() != 200) {
				System.out.println("One More Try..");
				hc.executeMethod(post);
			}
			System.out.println("TRANSACTION : " + post.getStatusCode() + " " + post.getResponseBodyAsString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
}
