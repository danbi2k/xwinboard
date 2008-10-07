package com.xwin.infra.dao;

import java.util.List;

import com.xwin.domain.admin.Access;

public class AccessDao extends XwinDao
{
	public void insertAccess(Access access)
	{
		sqlMapClientTemplate.insert("insertAccess", access);
	}
	
	public List<Access> selectAccessList()
	{
		return sqlMapClientTemplate.queryForList("selectAccessList");
	}
}
