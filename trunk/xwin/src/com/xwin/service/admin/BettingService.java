package com.xwin.service.admin;

import java.util.Date;

import com.xwin.domain.admin.Account;
import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.web.command.ResultXml;

public class BettingService extends XwinService
{
	public ResultXml calcuateBettingCommon(Betting betting) {
		String message = "";
		Integer code = 0;
		//String gameType= request.getParameter("gameType");
		String gameType = betting.getGameType();
		
		if (gameType.equals("wdl")) {
			if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS) == false) {
				code = -1;
				message = "배팅이 적중 상태가 아닙니다";
			} else {
				calculateWdl(betting);
				message = "정산되었습니다";
			}
		}
		else if (gameType.equals("handy")) {
			if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS) ||
					betting.getStatus().equals(Code.BET_STATUS_HANDYDRAW)) {
				calculateHandy(betting);
				message = "정산되었습니다";
			} else {
				code = -1;
				message = "정산 가능 상태가 아닙니다";
			}
		}
				
		ResultXml rx = new ResultXml(code, message, null);
		return rx;
	}

	public void calculateWdl(Betting betting) {
		String userId = betting.getUserId();
		Member member = memberDao.selectMember(userId, null);
					
		betting.setCalcStatus(Code.BET_CALC_COMMIT);
		bettingDao.updateBetting(betting);
		
		Account account = new Account();
		account.setUserId(userId);
		account.setType(Code.ACCOUNT_TYPE_JACKPOT);
		account.setDate(new Date());
		account.setOldBalance(member.getBalance());
		account.setMoney(betting.getExpect());
		account.setBalance(member.getBalance() + betting.getExpect());
		account.setBettingId(betting.getId());
		accountDao.insertAccount(account);
		
		memberDao.plusMinusBalance(userId, betting.getExpect());
	}
	
	public void calculateHandy(Betting betting) {
		String userId = betting.getUserId();
		Member member = memberDao.selectMember(userId, null);
		
		betting.setCalcStatus(Code.BET_CALC_COMMIT);
		bettingDao.updateBetting(betting);
		
		Account account = new Account();
		account.setUserId(userId);
		if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
			account.setType(Code.ACCOUNT_TYPE_JACKPOT);
		else
			account.setType(Code.ACCOUNT_TYPE_HANDYDRAW);
	
		account.setDate(new Date());
		account.setOldBalance(member.getBalance());
		account.setMoney(betting.getExpect());
		account.setBalance(member.getBalance() + betting.getExpect());
		account.setBettingId(betting.getId());
		accountDao.insertAccount(account);
		
		memberDao.plusMinusBalance(userId, betting.getExpect());
	}
}
