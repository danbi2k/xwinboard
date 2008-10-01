package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Account;

public class AccountDao extends XwinDao
{

	public void insertAccount(Account account) {
		sqlMapClientTemplate.insert("insertAccount", account);
	}
	

	public List<Account> selectAccountList(String userId, String type)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", type);
		
		return sqlMapClientTemplate.queryForList("selectAccountList", param);		
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
}
