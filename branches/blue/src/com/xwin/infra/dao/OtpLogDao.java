package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.log.OtpLog;

public class OtpLogDao extends XwinDao
{
	private static final long serialVersionUID = -6375127720682654481L;

	public void insertOtpLog(OtpLog otpLog)
	{
		sqlMapClientTemplate.insert("insertOtpLog", otpLog);
	}
	
	public List<OtpLog> selectOtpLogList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectOtpLogList", param);
	}
	
	public Integer selectOtpLogCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectOtpLogCount", param);
	}
}
