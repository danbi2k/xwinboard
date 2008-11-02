package com.xwin.service.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Account;
import com.xwin.domain.comm.SmsWait;
import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;

public class BettingService extends XwinService
{	
	public void judgeGameResult(Game game)
	{
		String gameId = game.getId();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gameId", gameId);
		param.put("notCalcStatus", Code.BET_CALC_COMMIT);
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		
		if (bettingList != null) {
			for (Betting betting : bettingList) {
				List<BetGame> betGameList = betting.getBetGameList();
				Integer cancelCount = 0;
				Integer successCount = 0;
				Integer failureCount = 0;
				Integer drawCount = 0;
				
				Double totalRate = 0.0;
				
				if (betGameList != null) {
					for (BetGame betGame : betGameList) {						
						Double thisRate = betGame.getSelRate();
						
						if (betGame.getStatus().equals(Code.GAME_STATUS_END)) {
							String result = judgeGameScore(betGame);							
							betGame.setResult(result);	
							
							if (betGame.getType().equals("wdl")) {
								if (betGame.getResult().equals("D") && betGame.getDrawRate() == 0.0) {
									betGame.setResultStatus(Code.RESULT_STATUS_DRAW);
									drawCount++;
									thisRate = 0.0;
								} else if (betGame.getResult().equals(betGame.getGuess())) {
									betGame.setResultStatus(Code.RESULT_STATUS_SUCCESS);
									successCount++;
								} else {
									betGame.setResultStatus(Code.RESULT_STATUS_FAILURE);
									failureCount++;
								}
							} else if (betGame.getType().equals("handy")) {
								if (betGame.getResult().equals("D")) {
									betGame.setResultStatus(Code.RESULT_STATUS_DRAW);
									drawCount++;
									thisRate = 0.0;
								} else if (betGame.getResult().equals(betGame.getGuess())) {
									betGame.setResultStatus(Code.RESULT_STATUS_SUCCESS);
									successCount++;
								} else {
									betGame.setResultStatus(Code.RESULT_STATUS_FAILURE);
									failureCount++;
								}
							}						
						} else if (betGame.getStatus().equals(Code.GAME_STATUS_CANCEL)) {
							betGame.setResultStatus(Code.RESULT_STATUS_CANCEL);
							thisRate = 0.0;
							cancelCount++;
						}
						
						if (totalRate == 0.0)
							totalRate = thisRate;
						else if (thisRate > 0.0)
							totalRate *= thisRate;
						
						betGameDao.updateBetGame(betGame);
					}
				}
				
				Integer totalCount = betGameList.size();		
				boolean calcEnable = false;
				
				List<Betting> notiTargetBetting = new ArrayList<Betting>();
				
				if (failureCount > 0) {
					betting.setStatus(Code.BET_STATUS_FAILURE);
					calcEnable = true;
				} else if (totalCount == (cancelCount)) {
					betting.setStatus(Code.BET_STATUS_CANCEL);
					calcEnable = true;
				} else if (totalCount == (cancelCount + drawCount)) {
					betting.setStatus(Code.BET_STATUS_RETURN);
					calcEnable = true;
				} else if (totalCount == (successCount + cancelCount + drawCount)) {
					betting.setStatus(Code.BET_STATUS_SUCCESS);
					calcEnable = true;
					notiTargetBetting.add(betting);
				}
				
				if (calcEnable) {
					String calcStatus = calcuateBetting(betting);
					betting.setCalcStatus(calcStatus);
				}
				
				Double cutRate = XwinUtil.doubleCut(totalRate); 
				betting.setRate(cutRate);
				betting.setExpect(XwinUtil.calcExpectMoney(cutRate, betting.getMoney()));
				bettingDao.updateBetting(betting);
				notifyGameResult(notiTargetBetting);
			}
		}
	}
	
	public String calcuateBetting(Betting betting) {
		String status = betting.getStatus();
		String userId = betting.getUserId();
		String calcStatus = betting.getCalcStatus();
		
		Member member = memberDao.selectMember(userId, null);		 
		
		// 1. 미적중의 경우
		if (status.equals(Code.BET_STATUS_FAILURE)) {
			calcStatus = Code.BET_CALC_COMMIT;
		}
		
		// 2. 환불의 경우
		else if (status.equals(Code.BET_STATUS_RETURN)) {
			Account account = new Account();
			account.setUserId(userId);
			account.setType(Code.ACCOUNT_TYPE_BETTING_RETURN);		
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(betting.getMoney());
			account.setBalance(member.getBalance() + betting.getMoney());
			account.setBettingId(betting.getId());
			accountDao.insertAccount(account);
			
			memberDao.plusMinusBalance(userId, betting.getMoney());
			
			calcStatus = Code.BET_CALC_COMMIT;
		}
		
		// 3. 적중의 경우
		else if (status.equals(Code.BET_STATUS_SUCCESS)) {			
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
			
			calcStatus = Code.BET_CALC_COMMIT;
		}
		
		return calcStatus;
	}

	public String judgeGameScore(Game game) {
		String type = game.getType();
		Integer homeScore = game.getHomeScore();
		Integer awayScore = game.getAwayScore();						
		String result = null;
		
		if (type.equals("wdl")) {			
			if (homeScore > awayScore)
				result = "W";
			else if (homeScore < awayScore)
				result = "L";
			else
				result = "D";
		} else if (type.equals("handy")) {
			double homeScoreDouble = (double)homeScore;
			double awayScoreDouble = (double)awayScore;
			
			homeScoreDouble += game.getDrawRate();
			
			if (homeScoreDouble > awayScoreDouble)
				result = "W";
			else if (homeScoreDouble < awayScoreDouble)
				result = "L";
			else {
				result = "D";
			}
		}
		
		return result;
	}
	
//	public void multipleTotalRate(String gameId)
//	{
//		Map<String, Object> param = new HashMap<String, Object>();
//		param.put("gameId", gameId);
//		List<Betting> bettingList = bettingDao.selectBettingList(param);
//		for (Betting betting : bettingList)
//			multipleTotalRate(betting);
//	}
//	
//	public void multipleTotalRate(Betting betting)
//	{
//		List<BetGame> betGameList = betting.getBetGameList();
//		
//		double totalRate = 0.0;
//		if (betGameList != null) {
//			for (BetGame betGame : betGameList) {
//				Double rate = null;
//				if (betGame.getGuess().equals("W"))
//					rate = betGame.getWinRate();
//				else if (betGame.getGuess().equals("D"))
//					rate = betGame.getDrawRate();
//				else if (betGame.getGuess().equals("L"))
//					rate = betGame.getLoseRate();
//				
//				if (rate == 0.0) continue;
//				if (betGame.getType().equals("handy") && betGame.getResult().equals("D")) continue;
//				if (betGame.getStatus().equals(Code.GAME_STATUS_CANCEL)) continue;
//				
//				if (totalRate == 0.0)
//					totalRate = rate;
//				else
//					totalRate *= rate;				
//			}
//		}
//		
//		Double cutRate = XwinUtil.doubleCut(totalRate);
//		Long expect = XwinUtil.calcExpectMoney(cutRate, betting.getMoney());
//		
//		betting.setRate(cutRate);
//		betting.setExpect(expect);
//		
//		bettingDao.updateBetting(betting);
//	}
	
	private void notifyGameResult(List<Betting> bettingList) {
		if (bettingList != null) {
			for (Betting betting : bettingList) {				
				try {
					Member member = memberDao.selectMember(betting.getUserId(), null);
					if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS) && member.getGetSms().equals("Y")) {
						String message = "[KingBet] " + betting.getNickName() + "님의 " + betting.getId() + "번 배팅이 " +
								Code.getValue(betting.getStatus()) + " 되었습니다.";
						if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
							message += "배당금 : " + XwinUtil.comma3(betting.getExpect());
						
						SmsWait smsWait = new SmsWait();
						smsWait.setMsg(message);
						smsWait.setPhone(member.getMobile());
						smsWait.setCallback("000-000-0000");
						
						smsWaitDao.insertSmsWait(smsWait);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
