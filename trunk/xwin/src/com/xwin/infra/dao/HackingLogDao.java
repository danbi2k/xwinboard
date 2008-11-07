package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.log.HackingLog;

public class HackingLogDao extends XwinDao
{
	private static final long serialVersionUID = -4959827720682654481L;

	public void insertHackingLog(HackingLog hackingLog)
	{
		sqlMapClientTemplate.insert("insertHackingLog", hackingLog);
	}
	
	public List<HackingLog> selectHackingLogList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectHackingLogList", param);
	}
	
	public Integer selectHackingLogCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectHackingLogCount", param);
	}

	public void updateHackingLog(HackingLog hackingLog) {
		sqlMapClientTemplate.update("updateHackingLog", hackingLog);		
	}
}
