package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.MoneyIn;
import com.xwin.domain.user.MoneyOut;

public class MoneyOutDao extends XwinDao
{

	public void insertMoneyOut(MoneyOut account) {
		sqlMapClientTemplate.insert("insertMoneyOut", account);
	}
	
	public void updateMoneyOut(MoneyOut moneyOut) {
		sqlMapClientTemplate.update("updateMoneyOut", moneyOut);
	}

	public List<MoneyOut> selectMoneyOutList(String userId, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);		
	}
	
	public List<MoneyOut> selectMoneyOutList(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate)
	{
		Map<String, Object> param = new HashMap<String, Object>(6);
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);		
	}
	
	public MoneyOut selectMoneyOut(String id)
	{
		return (MoneyOut) sqlMapClientTemplate.queryForObject("selectMoneyOut", id);		
	}
}
