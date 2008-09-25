package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.game.GameWdl;

public class GameWdlDao
{	
	public void insertGameWdl(GameWdl gameWdl)
	{
		sqlMapClientTemplate.insert("insertGameWdl", gameWdl);
	}
	
	public GameWdl selectGameWdl(String id)
	{
		return (GameWdl) sqlMapClientTemplate.queryForObject("selectGameWdlById", id);
	}
	
	public List<GameWdl> selectGameWdl(Map<String, String> where)
	{
		return sqlMapClientTemplate.queryForList("selectGameWdlByWhere");
	}

	public List<GameWdl> selectGameWdlList() {
		return sqlMapClientTemplate.queryForList("selectGameWdlList");
	}
	
	public List<GameWdl> selectGameWdlListByLeagueId(String leagueId) {
		return sqlMapClientTemplate.queryForList("selectGameWdlListByLeagueId", leagueId);
	}
	
	public void updateGameWdl(Map<String, String> value, Map<String, String> where)
	{
		Map<String, String> condition = new HashMap<String, String>();
		condition.putAll(value);
		condition.putAll(where);
		
		sqlMapClientTemplate.update("updateGameWdl", condition);
	}
	
	public void deleteGameWdl(String id)
	{
		sqlMapClientTemplate.delete("deleteGameWdlById", id);
	}

	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
