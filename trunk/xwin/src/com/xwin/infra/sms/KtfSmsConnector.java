package com.xwin.infra.sms;

import java.io.IOException;
import java.net.NoRouteToHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.xwin.domain.comm.KtfSmsMessage;
import com.xwin.infra.dao.KtfSmsDao;


public class KtfSmsConnector
{
	private static final DocumentBuilderFactory docBuilderFact = DocumentBuilderFactory.newInstance();
	private static final String getUri = "http://221.148.243.76/Application/ASP/PremMessenger20/MsgrMsgBox_List.asp?UserTel=01029017589&LogTime=20080727204924&ClientIP=10.21.49.124&MagicN_Id=Y29vbGlvbg==&ALevel=1&boxType=1&pagesize=2000&curpage=1";
	private static final String get = "http://msgmgr.show.co.kr/Application/ASP/PremMessenger20/MsgrMsgBox_List.asp?UserTel=01065591482&LogTime=20081007154021&ClientIP=10.100.29.205&MagicN_Id=Y2hsdGpyZ2g1OQ==&ALevel=2&boxType=1&pagesize=20&curpage=1";
	private static final String delUri = "http://221.148.243.76/Application/ASP/PremMessenger20/MsgrMsgBox_Del.asp?UserTel=01029017589&LogTime=20080727204924&ClientIP=10.21.49.124&IsALL=N&boxType=1&ALevel=1&targetMsg=";
	
	private KtfSmsDao ktfSmsDao = null;
	
	/**
	 * @param args
	 */
	private List<Map<String, String>> parseKTF()
	{
		List<Map<String, String>> mapList = null;
		try {			
			DocumentBuilder getBuilder = docBuilderFact.newDocumentBuilder();
			
			Document doc = getBuilder.parse(getUri);
			doc.getDoctype();
			
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
		} catch (NoRouteToHostException e) {
			System.out.println("SMS 서버에 연결하지 못하였습니다");
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
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
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
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
				
				ktfSmsDao.insertMessage(message);
			}	
		}
	}
	
	public List<KtfSmsMessage> getMessageList()
	{
		return ktfSmsDao.selectList();
	}
}
