package com.xwin.infra.sms;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.xwin.domain.comm.KtfSmsMessage;
import com.xwin.infra.dao.KtfSmsDao;


public class KtfSmsConnector
{
	private static final DocumentBuilderFactory docBuilderFact = DocumentBuilderFactory.newInstance();
//	private static final String getUri = "http://221.148.243.76/Application/ASP/PremMessenger20/MsgrMsgBox_List.asp?UserTel=01029017589&LogTime=20081107103112&ClientIP=10.21.49.124&MagicN_Id=Y29vbGlvbg==&ALevel=1&boxType=1&pagesize=2000&curpage=1";
//	private static final String delUri = "http://221.148.243.76/Application/ASP/PremMessenger20/MsgrMsgBox_Del.asp?UserTel=01029017589&LogTime=20081107103112&ClientIP=10.21.49.124&IsALL=N&boxType=1&ALevel=1&targetMsg=";
	private static final String getUri = "http://msgmgr.show.co.kr/Application/ASP/PremMessenger20/MsgrMsgBox_List.asp?UserTel=01065591482&LogTime=20081007154021&ClientIP=10.100.29.205&MagicN_Id=Y2hsdGpyZ2g1OQ==&ALevel=2&boxType=1&pagesize=100&curpage=1";
	private static final String delUri = "http://msgmgr.show.co.kr/Application/ASP/PremMessenger20/MsgrMsgBox_Del.asp?UserTel=01065591482&LogTime=20081007154021&ClientIP=10.100.29.205&IsALL=N&boxType=1&ALevel=1&targetMsg=";
	
	private KtfSmsDao ktfSmsDao = null;
	
	/**
	 * @param args
	 */
	public List<Map<String, String>> parseKTF()
	{
		List<Map<String, String>> mapList = null;
		try {			
			DocumentBuilder getBuilder = docBuilderFact.newDocumentBuilder();
			HttpClient hc = new HttpClient();
			hc.getHttpConnectionManager().getParams().setSoTimeout(5000);
			
			HttpMethod method = new GetMethod(getUri);
			hc.executeMethod(method);
			InputStream is = method.getResponseBodyAsStream();
			
			Document doc = getBuilder.parse(is);
			
			Element elem = doc.getDocumentElement();
			
			NodeList nodeList = elem.getElementsByTagName("boxlist");
			int node_length = nodeList.getLength();
			
			mapList = new ArrayList<Map<String, String>>(node_length);
			for (int i = 0 ; i < node_length ; i++)
			{
				Node node = nodeList.item(i);
				NodeList boxlist = node.getChildNodes();
				int boxlist_length = boxlist.getLength();
				Map<String, String> boxMap = new HashMap<String, String>();
				for (int j = 0 ; j < boxlist_length ; j++) {
					Node boxnode = boxlist.item(j);
					if (boxnode.getFirstChild() != null) {
						boxMap.put(boxnode.getNodeName(), boxnode.getFirstChild().getNodeValue());
					}
				}

				deleteSms(boxMap.get("msg_seq"), boxMap.get("in_date"), boxMap.get("sm"));				
				mapList.add(boxMap);
			}				
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SMS 서버에 연결하지 못하였습니다");
		}
		
		return mapList;
	}
	
	public void setKtfSmsDao(KtfSmsDao ktfSmsDao) {
		this.ktfSmsDao = ktfSmsDao;
	}

	public boolean deleteSms(String msgSeq, String inDate, String sm)
	{
		try {
			DocumentBuilder actBuilder = docBuilderFact.newDocumentBuilder();
			String delParam = msgSeq + "|" + inDate + "|" + sm; 
			actBuilder.parse(delUri + delParam);
			
//			HttpClient hc = new HttpClient();
//			HttpMethod method = new GetMethod(delUri + delParam);
//			hc.getHttpConnectionManager().getParams().setSoTimeout(2000);
//			hc.executeMethod(method);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SMS 서버에 연결하지 못하였습니다");
		}
		
		return true;
	}
	
	public void processDbTranscation()
	{
		List<Map<String, String>> smsList = parseKTF();
		if (smsList != null) {
			for (Map<String, String> smsMap : smsList) {
				
				KtfSmsMessage message = new KtfSmsMessage(
					null,
					smsMap.get("msg_seq"),
					smsMap.get("msg"),
					smsMap.get("call_back"),
					smsMap.get("in_date"),				
					smsMap.get("sm"));
				
				if (message.getMsg().startsWith("[KB]"))
					ktfSmsDao.insertMessage(message);
			}	
		}
	}
	
	public List<KtfSmsMessage> getMessageList()
	{
		return ktfSmsDao.selectList();
	}
}
