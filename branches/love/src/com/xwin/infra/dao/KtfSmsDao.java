package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.comm.KtfSmsMessage;

public class KtfSmsDao extends XwinDao
{
	private static final long serialVersionUID = 2217634749532579292L;

	public void insertMessage(KtfSmsMessage message)
	{
		sqlMapClientTemplate.insert("insertKtfMessage", message);
	}
	
	public List<KtfSmsMessage> selectList()
	{
		return sqlMapClientTemplate.queryForList("selectKtfSmsList");
	}
	
	public List<KtfSmsMessage> searchAssociateWitnMoneyIn(String name, String money)
	{
		String keyword = "%" + name + "%" + money + "%";
		return sqlMapClientTemplate.queryForList("searchAssociateWitnMoneyIn", keyword);
	}
	
	public void updateStatus(String id, String status)
	{
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("status", status);
		
		sqlMapClientTemplate.update("updateKtfSmsMessage", param);
	}
}
