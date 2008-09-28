package com.xwin.infra.dao;

import java.util.List;

import com.xwin.domain.user.Account;

public class AccountDao extends XwinDao
{

	public void insertAccount(Account account) {
		sqlMapClientTemplate.insert("insertAccount", account);
	}
	
	public List<Account> selectAccountListByUserId(String userId)
	{
		return sqlMapClientTemplate.queryForList("selectAccountListByUserId", userId);
	}
}
