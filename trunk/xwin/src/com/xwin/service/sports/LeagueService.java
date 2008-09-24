package com.xwin.service.sports;

import java.util.List;

import com.xwin.domain.sports.League;
import com.xwin.infra.dao.LeagueDao;

public class LeagueService
{
	private LeagueDao leagueDao = null;
	
	public void createLeague(League league)
	{
		leagueDao.insertLeague(league);
	}
	
	public List<League> getLeagueList()
	{
		return leagueDao.selectLeagueList();
	}
	
//	public League getLeague(String id) {
//		return leagueDao.get
//	}

	public void setLeagueDao(LeagueDao leagueDao) {
		this.leagueDao = leagueDao;
	}
}
