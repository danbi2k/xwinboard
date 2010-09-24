package com.xwin.infra.sms;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
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

	private List<String> getUri = new ArrayList<String>();
	private List<String> delUri = new ArrayList<String>();
	private List<String> emptyUri = new ArrayList<String>();
	
	private KtfSmsDao ktfSmsDao = null;
	
	/**
	 * @param args
	 */
	public List<Map<String, String>> parseKTF()
	{
		List<Map<String, String>> mapList = new ArrayList<Map<String, String>>();;
			
		DocumentBuilder getBuilder = null;
		try {
			getBuilder = docBuilderFact.newDocumentBuilder();
		} catch (ParserConfigurationException e1) {
			e1.printStackTrace();
		}
		
		HttpClient hc = new HttpClient();
		hc.getHttpConnectionManager().getParams().setSoTimeout(30000);
			
		for (int x = 0 ; x < getUri.size() ; x++) {
			try {
				HttpMethod method = new GetMethod(getUri.get(x));
				hc.executeMethod(method);
				InputStream is = method.getResponseBodyAsStream();
				
				Document doc = getBuilder.parse(is);
				
				Element elem = doc.getDocumentElement();
				
				NodeList nodeList = elem.getElementsByTagName("boxlist");
				int node_length = nodeList.getLength();
				
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
	
					deleteSms(boxMap.get("msg_seq"), boxMap.get("in_date"), boxMap.get("sm"), x);				
					mapList.add(boxMap);
				}
			} catch (SAXException e) {
				e.printStackTrace();
				System.out.println("잘못된 xml 입니다");
				emptySms(x);				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("(GET) SMS 서버에 연결하지 못하였습니다");
			}
		}
		
		return mapList;
	}
	
	public void setKtfSmsDao(KtfSmsDao ktfSmsDao) {
		this.ktfSmsDao = ktfSmsDao;
	}

	public boolean deleteSms(String msgSeq, String inDate, String sm, int x)
	{
		try {
			DocumentBuilder actBuilder = docBuilderFact.newDocumentBuilder();
			String delParam = msgSeq + "|" + inDate + "|" + sm; 
			actBuilder.parse(delUri.get(x) + delParam);
//			System.out.println(delUri[x] + delParam);
			
//			HttpClient hc = new HttpClient();
//			HttpMethod method = new GetMethod(delUri + delParam);
//			hc.getHttpConnectionManager().getParams().setSoTimeout(2000);
//			hc.executeMethod(method);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("(DELETE) SMS 서버에 연결하지 못하였습니다");
		}
		
		return true;
	}
	
	public boolean emptySms(int x)
	{
		try {
			DocumentBuilder actBuilder = docBuilderFact.newDocumentBuilder();
			actBuilder.parse(emptyUri.get(x));
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("(EMPTY) SMS 서버에 연결하지 못하였습니다");			
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

	public List<String> getGetUri() {
		return getUri;
	}

	public void setGetUri(List<String> getUri) {
		this.getUri = getUri;
	}

	public List<String> getDelUri() {
		return delUri;
	}

	public void setDelUri(List<String> delUri) {
		this.delUri = delUri;
	}

	public List<String> getEmptyUri() {
		return emptyUri;
	}

	public void setEmptyUri(List<String> emptyUri) {
		this.emptyUri = emptyUri;
	}
}
