package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Account;

public class AccountDao extends XwinDao
{
	private static final long serialVersionUID = 4325322876673524306L;

	public void insertAccount(Account account) {
		sqlMapClientTemplate.insert("insertAccount", account);
	}
	
	public List<Account> selectAccountList(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate)
	{
		Map<String, Object> param = new HashMap<String, Object>(6);
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		
		return sqlMapClientTemplate.queryForList("selectAccountList", param);		
	}
	
	public List<Account> selectAccountList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectAccountList", param);		
	}
	
	public Integer selectAccountCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectAccountCount", param);		
	}

	public void updateAccount(Account account) {
		sqlMapClientTemplate.update("updateAccount", account);
		
	}
}
