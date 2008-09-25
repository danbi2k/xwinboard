package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.game.Team;

public class TeamDao
{
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void insertTeam(Team team)
	{
		sqlMapClientTemplate.insert("insertTeam", team);
	}
	
	public List<Team> selectTeamList()
	{
		return sqlMapClientTemplate.queryForList("selectTeamList");
	}

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
