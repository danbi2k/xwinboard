package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.MoneyIn;

public class MoneyInDao extends XwinDao
{

	public void insertMoneyIn(MoneyIn account) {
		sqlMapClientTemplate.insert("insertMoneyIn", account);
	}
	
	public void updateMoneyIn(MoneyIn moneyIn) {
		sqlMapClientTemplate.update("updateMoneyIn", moneyIn);
	}

	public List<MoneyIn> selectMoneyInList(String userId, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);		
	}
	
	public List<MoneyIn> selectMoneyInList(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate)
	{
		Map<String, Object> param = new HashMap<String, Object>(6);
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);		
	}

	public MoneyIn selectMoneyIn(String id)
	{
		return (MoneyIn) sqlMapClientTemplate.queryForObject("selectMoneyIn", id);		
	}

	public List<MoneyIn> selectRecentlyRequestList()
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("pageIndex", 0);
		param.put("pageSize", 5);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);	
	}
}
