package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.comm.KtfSmsMessage;

public class KtfSmsDao extends XwinDao
{
	public void insertMessage(KtfSmsMessage message)
	{
		sqlMapClientTemplate.insert("insertMessage", message);
	}
	
	public List<KtfSmsMessage> selectList()
	{
		return sqlMapClientTemplate.queryForList("selectKtfSmsList");
	}
}
