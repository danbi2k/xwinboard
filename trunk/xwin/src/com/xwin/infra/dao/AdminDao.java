package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.Map;

public class AdminDao extends XwinDao
{
	public void updateAdmin(String constant, String variable)
	{
		Map<String, String> param = new HashMap<String, String>(1);
		param.put("constant", constant);
		param.put("variable", variable);
		
		sqlMapClientTemplate.insert("insertAdmin", param);
	}
	
	public String selectAdmin(String key)
	{
		return (String) sqlMapClientTemplate.queryForObject("selectAdmin", key);
	}
}
