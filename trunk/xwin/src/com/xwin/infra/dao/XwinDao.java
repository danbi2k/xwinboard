package com.xwin.infra.dao;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

public class XwinDao
{
	protected SqlMapClientTemplate sqlMapClientTemplate;
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
