package com.xwin.infra.dao;

import java.io.Serializable;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

public class XwinDao implements Serializable
{
	protected SqlMapClientTemplate sqlMapClientTemplate;
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
