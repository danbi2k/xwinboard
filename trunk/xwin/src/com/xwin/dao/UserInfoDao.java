package com.xwin.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.user.User;

public class UserInfoDao
{
	public void insertUserInfo(User user)
	{
		sqlMapClientTemplate.insert("insertUserInfo", user);
	}
	
	public List<User> selectUserInfoList()
	{
		return (List<User>) sqlMapClientTemplate.queryForList("selectUserInfoList");
	}
	
	private SqlMapClientTemplate sqlMapClientTemplate;

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}		
}
