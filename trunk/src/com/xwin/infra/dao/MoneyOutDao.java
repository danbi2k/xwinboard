package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.statistics.MoneyOutStat;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.util.Code;

public class MoneyOutDao extends XwinDao
{
	private static final long serialVersionUID = -551527196455218277L;

	public void insertMoneyOut(MoneyOut account) {
		sqlMapClientTemplate.insert("insertMoneyOut", account);
	}
	
	public void updateMoneyOut(MoneyOut moneyOut) {
		sqlMapClientTemplate.update("updateMoneyOut", moneyOut);
	}
	
	public void deleteMoneyOut(String id) {
		sqlMapClientTemplate.update("deleteMoneyOut", id);
	}
	
	public List<MoneyOut> selectMoneyOutList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);
	}
	
	public Integer selectMoneyOutCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyOutCount", param);
	}
	
	public Long selectMoneyOutSum(Map<String, Object> param)
	{
		return (Long) sqlMapClientTemplate.queryForObject("selectMoneyOutSum", param);
	}

	public List<MoneyOut> selectMoneyOutList(String userId, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);		
	}
	
	public List<MoneyOut> selectMoneyOutList(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);		
	}
	
	public Integer selectMoneyOutCount(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		param.put("status", status);
		
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyOutCount", param);		
	}
	
	public MoneyOut selectMoneyOut(String id)
	{
		return (MoneyOut) sqlMapClientTemplate.queryForObject("selectMoneyOut", id);		
	}

	public List<MoneyOut> selectRecentlyRequestList()
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("status", Code.MONEY_OUT_REQUEST);
		param.put("fromRow", 0);
		param.put("rowSize", 5);
		
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);
	}
	
	public List<MoneyOutStat> selectMoneyOutGroupByBankList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectMoneyOutGroupByBankList", param);
	}
	
	public Integer selectMoneyOutGroupByBankCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyOutGroupByBankCount", param);
	}
}
