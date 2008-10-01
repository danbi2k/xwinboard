package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.MoneyIn;

public class MoneyInDao extends XwinDao
{

	public void insertMoneyIn(MoneyIn account) {
		sqlMapClientTemplate.insert("insertMoneyIn", account);
	}
	

	public List<MoneyIn> selectMoneyInList(String userId, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyInList", param);		
	}
}
