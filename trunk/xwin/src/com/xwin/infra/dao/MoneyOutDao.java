package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.MoneyOut;

public class MoneyOutDao extends XwinDao
{

	public void insertMoneyOut(MoneyOut account) {
		sqlMapClientTemplate.insert("insertMoneyOut", account);
	}
	

	public List<MoneyOut> selectMoneyOutList(String userId, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectMoneyOutList", param);		
	}
}
