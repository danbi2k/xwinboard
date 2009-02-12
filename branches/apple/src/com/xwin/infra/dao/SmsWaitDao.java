package com.xwin.infra.dao;

import java.util.List;

import com.xwin.domain.comm.SmsWait;

public class SmsWaitDao extends XwinDao
{
	private static final long serialVersionUID = -5525460032190355900L;

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
	
	public void deleteSmsWaitList(String id)
	{
		sqlMapClientTemplate.delete("deleteSmsWaitList", id);
	}
}
