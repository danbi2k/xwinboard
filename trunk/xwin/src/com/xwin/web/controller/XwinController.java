package com.xwin.web.controller;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.infra.dao.AccessDao;
import com.xwin.infra.dao.AccountDao;
import com.xwin.infra.dao.BankBookDao;
import com.xwin.infra.dao.BetGameDao;
import com.xwin.infra.dao.BettingDao;
import com.xwin.infra.dao.BoardDao;
import com.xwin.infra.dao.GameDao;
import com.xwin.infra.dao.LeagueDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.dao.MoneyInDao;
import com.xwin.infra.dao.MoneyOutDao;

public class XwinController extends MultiActionController
{
	protected BettingDao bettingDao = null;
	protected GameDao gameDao = null;
	protected LeagueDao leagueDao = null;
	protected MemberDao memberDao = null;
	protected BetGameDao betGameDao = null;
	protected BoardDao boardDao = null;
	protected MoneyInDao moneyInDao = null;
	protected MoneyOutDao moneyOutDao = null;
	protected BankBookDao bankBookDao = null;
	protected AccountDao accountDao = null;
	protected AccessDao accessDao = null;
	
	public void setBettingDao(BettingDao bettingDao) {
		this.bettingDao = bettingDao;
	}
	public void setGameDao(GameDao gameDao) {
		this.gameDao = gameDao;
	}
	public void setLeagueDao(LeagueDao leagueDao) {
		this.leagueDao = leagueDao;
	}
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	public void setBetGameDao(BetGameDao betGameDao) {
		this.betGameDao = betGameDao;
	}
	public void setBoardDao(BoardDao boardDao) {
		this.boardDao = boardDao;
	}
	public void setMoneyInDao(MoneyInDao moneyInDao) {
		this.moneyInDao = moneyInDao;
	}
	public void setMoneyOutDao(MoneyOutDao moneyOutDao) {
		this.moneyOutDao = moneyOutDao;
	}
	public void setBankBookDao(BankBookDao bankBookDao) {
		this.bankBookDao = bankBookDao;
	}
	public void setAccountDao(AccountDao accountDao) {
		this.accountDao = accountDao;
	}
	public void setAccessDao(AccessDao accessDao) {
		this.accessDao = accessDao;
	}
}
