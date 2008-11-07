package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.Map;

public class AdminDao extends XwinDao
{
	private static final long serialVersionUID = 1860408668674867985L;

	public void updateAdmin(String constant, String variable)
	{
		Map<String, String> param = new HashMap<String, String>(1);
		param.put("constant", constant);
		param.put("variable", variable);
		
		sqlMapClientTemplate.insert("updateAdmin", param);
	}
	
	public String selectAdmin(String constant)
	{
		return (String) sqlMapClientTemplate.queryForObject("selectAdmin", constant);
	}
}
