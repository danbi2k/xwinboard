package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.comm.ShowSmsMessage;

public class ShowSmsDao extends XwinDao
{
	private static final long serialVersionUID = 2217634749532579292L;

	public void insertMessage(ShowSmsMessage message)
	{
		sqlMapClientTemplate.insert("insertMessage", message);
	}
	
	public List<ShowSmsMessage> selectList()
	{
		return sqlMapClientTemplate.queryForList("selectShowSmsList");
	}
	
	public List<ShowSmsMessage> searchAssociateWitnMoneyIn(String name, String money)
	{
		String keyword = "%" + name + "%" + money + "%";
		return sqlMapClientTemplate.queryForList("searchAssociateWitnMoneyIn", keyword);
	}
	
	public void deleteShowMessage(String id)
	{
		sqlMapClientTemplate.delete("deleteShowMessage", id);
	}
	
	public void updateStatus(String id, String status)
	{
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("status", status);
		
		sqlMapClientTemplate.update("updateShowSmsMessage", param);
	}
}
