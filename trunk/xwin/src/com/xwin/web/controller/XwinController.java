package com.xwin.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.user.Member;
import com.xwin.infra.dao.AccessDao;
import com.xwin.infra.dao.AccountDao;
import com.xwin.infra.dao.AdminDao;
import com.xwin.infra.dao.BankBookDao;
import com.xwin.infra.dao.BetGameDao;
import com.xwin.infra.dao.BettingDao;
import com.xwin.infra.dao.BoardDao;
import com.xwin.infra.dao.GameDao;
import com.xwin.infra.dao.HackingLogDao;
import com.xwin.infra.dao.InvitationDao;
import com.xwin.infra.dao.KtfSmsDao;
import com.xwin.infra.dao.LeagueDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.dao.MemoDao;
import com.xwin.infra.dao.MoneyInDao;
import com.xwin.infra.dao.MoneyInOutDao;
import com.xwin.infra.dao.MoneyOutDao;
import com.xwin.infra.dao.PointDao;
import com.xwin.infra.dao.SmsWaitDao;
import com.xwin.infra.dao.TransactionDao;
import com.xwin.infra.sms.SendSmsConnector;
import com.xwin.service.admin.BettingService;

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
	protected MoneyInOutDao moneyInOutDao = null;
	protected BankBookDao bankBookDao = null;
	protected AccountDao accountDao = null;
	protected TransactionDao transactionDao = null;
	protected PointDao pointDao = null;
	protected AccessDao accessDao = null;
	protected KtfSmsDao ktfSmsDao = null;
	protected AdminDao adminDao = null;
	protected SmsWaitDao smsWaitDao = null;
	protected MemoDao memoDao = null;
	protected HackingLogDao hackingLogDao = null;
	protected InvitationDao invitationDao = null;
	
	protected SendSmsConnector sendSmsConnector = null;
	protected BettingService bettingService = null;
	
	public Member getLoginMember(HttpServletRequest request) {
		Member member = (Member) request.getSession().getAttribute("Member");
		
		return member;
	}
	
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
	public void setMoneyInOutDao(MoneyInOutDao moneyInOutDao) {
		this.moneyInOutDao = moneyInOutDao;
	}

	public void setBankBookDao(BankBookDao bankBookDao) {
		this.bankBookDao = bankBookDao;
	}
	public void setAccountDao(AccountDao accountDao) {
		this.accountDao = accountDao;
	}
	public void setTransactionDao(TransactionDao transactionDao) {
		this.transactionDao = transactionDao;
	}

	public void setAccessDao(AccessDao accessDao) {
		this.accessDao = accessDao;
	}
	public void setPointDao(PointDao pointDao) {
		this.pointDao = pointDao;
	}

	public void setKtfSmsDao(KtfSmsDao ktfSmsDao) {
		this.ktfSmsDao = ktfSmsDao;
	}
	public void setSendSmsConnector(SendSmsConnector sendSmsConnector) {
		this.sendSmsConnector = sendSmsConnector;
	}
	public void setBettingService(BettingService bettingService) {
		this.bettingService = bettingService;
	}
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	public void setSmsWaitDao(SmsWaitDao smsWaitDao) {
		this.smsWaitDao = smsWaitDao;
	}

	public void setMemoDao(MemoDao memoDao) {
		this.memoDao = memoDao;
	}

	public void setHackingLogDao(HackingLogDao hackingLogDao) {
		this.hackingLogDao = hackingLogDao;
	}

	public void setInvitationDao(InvitationDao invitationDao) {
		this.invitationDao = invitationDao;
	}
}
