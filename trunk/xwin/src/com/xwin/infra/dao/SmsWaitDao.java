package com.xwin.infra.dao;

import java.util.List;

import com.xwin.domain.comm.SmsWait;

public class SmsWaitDao extends XwinDao
{
	public void insertSmsWait(SmsWait smsWait)
	{
		sqlMapClientTemplate.insert("insertSmsWait", smsWait);
	}
	
	public void deleteSmsWait(String id)
	{
		sqlMapClientTemplate.delete("deleteSmsWait", id);
	}
	
	public List<SmsWait> selectSmsWaitList()
	{
		return sqlMapClientTemplate.queryForList("selectSmsWaitList");
	}
}
