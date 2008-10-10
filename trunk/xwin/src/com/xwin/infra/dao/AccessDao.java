package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Access;

public class AccessDao extends XwinDao
{
	public void insertAccess(Access access)
	{
		sqlMapClientTemplate.insert("insertAccess", access);
	}
	
	public List<Access> selectAccessList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectAccessList", param);
	}
	
	public Integer selectAccessCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectAccessCount", param);
	}
}
