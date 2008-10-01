package com.xwin.infra.dao;

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
}
