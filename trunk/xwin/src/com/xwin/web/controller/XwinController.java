package com.xwin.web.controller;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.infra.dao.BetGameDao;
import com.xwin.infra.dao.BettingDao;
import com.xwin.infra.dao.GameDao;
import com.xwin.infra.dao.LeagueDao;
import com.xwin.infra.dao.MemberDao;

public class XwinController extends MultiActionController
{
	protected BettingDao bettingDao = null;
	protected GameDao gameDao = null;
	protected LeagueDao leagueDao = null;
	protected MemberDao memberDao = null;
	protected BetGameDao betGameDao = null;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}	
	public void setGameDao(GameDao gameDao) {
		this.gameDao = gameDao;
	}
	public void setLeagueDao(LeagueDao leagueDao) {
		this.leagueDao = leagueDao;
	}
	public void setBettingDao(BettingDao bettingDao) {
		this.bettingDao = bettingDao;
	}
	public void setBetGameDao(BetGameDao betGameDao) {
		this.betGameDao = betGameDao;
	}
}
