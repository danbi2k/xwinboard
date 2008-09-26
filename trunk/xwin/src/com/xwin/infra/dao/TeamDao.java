package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.game.Team;

public class TeamDao extends XwinDao
{
	public void insertTeam(Team team)
	{
		sqlMapClientTemplate.insert("insertTeam", team);
	}
	
	public List<Team> selectTeamList()
	{
		return sqlMapClientTemplate.queryForList("selectTeamList");
	}
}
