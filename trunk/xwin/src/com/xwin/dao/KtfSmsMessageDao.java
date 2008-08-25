package com.xwin.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.comm.KtfSmsMessage;

public class KtfSmsMessageDao
{
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void insertMessage(KtfSmsMessage message)
	{
		sqlMapClientTemplate.insert("insertMessage", message);
	}
	
	public List<KtfSmsMessage> selectList()
	{
		return sqlMapClientTemplate.queryForList("selectKtfSmsList");
	}

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
