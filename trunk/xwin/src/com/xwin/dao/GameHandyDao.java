package com.xwin.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.sports.GameHandy;
import com.xwin.domain.sports.GameWdl;

public class GameHandyDao
{
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void insertGame(GameHandy game)
	{
		sqlMapClientTemplate.insert("insertGameWdl", game);
	}
	
	public List<GameHandy> selectGameList()
	{
		return sqlMapClientTemplate.queryForList("selectGameWdlList");
	}

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
