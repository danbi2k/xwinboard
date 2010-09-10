package com.xwin.infra.sms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.xwin.domain.comm.ShowSmsMessage;
import com.xwin.infra.dao.ShowSmsDao;


public class ShowSmsConnector
{	
	private ShowSmsDao showSmsDao = null;
	
	/**
	 * @param args
	 */
	public List<Map<String, String>> parseSHOW()
	{
		List<Map<String, String>> mapList = new ArrayList<Map<String, String>>();;
			
		List<ShowSmsMessage> messageList = showSmsDao.selectList();
		Iterator<ShowSmsMessage> messageIter = messageList.iterator();
		while (messageIter.hasNext()) {
			ShowSmsMessage message = messageIter.next();
			Map<String, String> boxMap = new HashMap<String, String>();
			boxMap.put("msg_seq", message.getMsgSeq());
			boxMap.put("msg", message.getMsg());
			boxMap.put("call_back", message.getCallBack());
			boxMap.put("in_date", message.getInDate());
			boxMap.put("sm", message.getSm());
	
			deleteSms(message.getId());				
			mapList.add(boxMap);
		}
		
		return mapList;
	}
	
	public void setShowSmsDao(ShowSmsDao ShowSmsDao) {
		this.showSmsDao = ShowSmsDao;
	}

	public boolean deleteSms(String id)
	{
		try {
			showSmsDao.deleteShowMessage(id);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("(DELETE) 에 실패하였습니다");
		}
		
		return true;
	}
}
