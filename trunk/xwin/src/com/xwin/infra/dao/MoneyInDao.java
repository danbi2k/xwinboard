package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.Code;

public class MoneyInDao extends XwinDao
{

	public void insertMoneyIn(MoneyIn moneyIn) {
		sqlMapClientTemplate.insert("insertMoneyIn", moneyIn);
	}
	
	public void updateMoneyIn(MoneyIn moneyIn) {
		sqlMapClientTemplate.update("updateMoneyIn", moneyIn);
	}
	
	public void deleteMoneyIn(String id) {
		sqlMapClientTemplate.update("deleteMoneyIn", id);
	}	
	
	public List<MoneyIn> selectMoneyInList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);		
	}
	
	public Integer selectMoneyInCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyInCount", param);	
	}
	
	public Integer selectMoneyInSum(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyInSum", param);	
	}

	public List<MoneyIn> selectMoneyInList(String userId, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);		
	}
	
	public List<MoneyIn> selectMoneyInList(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);		
	}
	
	public Integer selectMoneyInCount(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		param.put("status", status);
		
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyInCount", param);		
	}

	public MoneyIn selectMoneyIn(String id)
	{
		return (MoneyIn) sqlMapClientTemplate.queryForObject("selectMoneyIn", id);		
	}

	public List<MoneyIn> selectRecentlyRequestList()
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("status", Code.MONEY_IN_REQUEST);
		param.put("fromRow", 0);
		param.put("rowSize", 5);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);	
	}
}
