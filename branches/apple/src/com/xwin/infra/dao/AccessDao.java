package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Access;

public class AccessDao extends XwinDao
{
	private static final long serialVersionUID = 8870829519677473986L;

	public void insertAccess(Access access)
	{
		sqlMapClientTemplate.insert("insertAccess", access);
	}
	
	public Access selectAccess(Map<String, Object> param)
	{
		return (Access) sqlMapClientTemplate.queryForObject("selectAccess", param);
	}
	
	public List<Access> selectAccessList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectAccessList", param);
	}
	
	public Integer selectAccessCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectAccessCount", param);
	}
	
	public void insertBlockIp(String ip)
	{
		sqlMapClientTemplate.insert("insertBlockIp", ip);
	}
	
	public Integer selectBlockIpCount(String ip)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectBlockIpCount", ip);
	}

	public void deleteBlockIp(String ip)
	{
		sqlMapClientTemplate.delete("deleteBlockIp", ip);		
	}
}
