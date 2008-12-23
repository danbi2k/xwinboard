package com.xwin.service.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Admin;
import com.xwin.domain.admin.Point;
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
						betting.setGameGrade(betGame.getGrade());
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
				
				List<Betting> notiTargetBetting = new ArrayList<Betting>();
				
				if (failureCount > 0) {
					betting.setStatus(Code.BET_STATUS_FAILURE);
				} else if (totalCount == (cancelCount)) {
					betting.setStatus(Code.BET_STATUS_CANCEL);
				} else if (totalCount == (cancelCount + drawCount)) {
					betting.setStatus(Code.BET_STATUS_RETURN);
				} else if (totalCount == (successCount + cancelCount + drawCount)) {
					betting.setStatus(Code.BET_STATUS_SUCCESS);
					notiTargetBetting.add(betting);
				}
				
				Double cutRate = XwinUtil.doubleCut(totalRate); 
				betting.setRate(cutRate);
				betting.setExpect(XwinUtil.calcExpectMoney(cutRate, betting.getMoney()));
				
				if (totalCount == (cancelCount + successCount + failureCount + drawCount)) {
					betting.setSuccessCount(successCount);
					calcuateBetting(betting);
					betting.setEndDate(new Date());
					betting.setCalcStatus(Code.BET_CALC_COMMIT);
				}
				
				bettingDao.updateBetting(betting);
				notifyGameResult(notiTargetBetting);
			}
		}
	}
	
	public void calcuateBetting(Betting betting)
	{
		String status = betting.getStatus();
		String userId = betting.getUserId();
		
		Member member = memberDao.selectMember(userId, null);
		
		boolean afterProcess = false; // 포인트 지급, 소개인 정보 갱신
		
		// 1. 미적중의 경우
		if (status.equals(Code.BET_STATUS_FAILURE)) {
			afterProcess = true;
		}
		
		// 2. 환불의 경우
		else if (status.equals(Code.BET_STATUS_RETURN) || status.equals(Code.BET_STATUS_CANCEL)) {
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
		}
		
		// 3. 적중의 경우
		else if (status.equals(Code.BET_STATUS_SUCCESS)) {
			afterProcess = true;
			
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
			
			try {
				if (betting.getGameGrade() == null)
					betting.setGameGrade(Code.USER_GRADE_NORMAL);
				
				if (Admin.WDL_BONUS_USE && betting.getGameType().equals("wdl") && betting.getGameGrade().equals(Code.USER_GRADE_NORMAL)) {
					if (betting.getSuccessCount() >= Admin.WDL_BONUS_LIMIT) {
						Double wdl_bonus_rate = Admin.WDL_BONUS_RATE.doubleValue() * 0.01;
						Long wdl_bonus_point = XwinUtil.calcExpectMoney(wdl_bonus_rate, betting.getExpect());
						
						Point pointLog = new Point();
						pointLog.setUserId(userId);
						pointLog.setType(Code.POINT_TYPE_BONUS);
						pointLog.setDate(new Date());
						pointLog.setOldBalance(member.getPoint());
						pointLog.setMoney(wdl_bonus_point);
						pointLog.setBalance(member.getPoint() + wdl_bonus_point);
						pointLog.setBettingId(betting.getId());
						pointLog.setNote("승무패 " + Admin.WDL_BONUS_LIMIT + "폴더 이상 " + Admin.WDL_BONUS_RATE + "%");
						pointDao.insertPoint(pointLog);
						
						memberDao.plusMinusPoint(userId, wdl_bonus_point);
					}
				} else if (Admin.HANDY_BONUS_USE && betting.getGameType().equals("handy") && betting.getGameGrade().equals(Code.USER_GRADE_NORMAL)) {
					if (betting.getSuccessCount() >= Admin.HANDY_BONUS_LIMIT) {
						Double handy_bonus_rate = Admin.HANDY_BONUS_RATE.doubleValue() * 0.01;
						Long handy_bonus_point = XwinUtil.calcExpectMoney(handy_bonus_rate, betting.getExpect());
						
						Point pointLog = new Point();
						pointLog.setUserId(userId);
						pointLog.setType(Code.POINT_TYPE_BONUS);
						pointLog.setDate(new Date());
						pointLog.setOldBalance(member.getPoint());
						pointLog.setMoney(handy_bonus_point);
						pointLog.setBalance(member.getPoint() + handy_bonus_point);
						pointLog.setBettingId(betting.getId());
						pointLog.setNote("핸디캡 " + Admin.HANDY_BONUS_LIMIT + "폴더 이상 " + Admin.HANDY_BONUS_RATE + "%");
						pointDao.insertPoint(pointLog);
						
						memberDao.plusMinusPoint(userId, handy_bonus_point);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (afterProcess) {
			// 포인트지급
			Double point = 0.0;
			if (member.getGrade().equals(Code.USER_GRADE_NORMAL))
				point = betting.getMoney() * 0.02;
			else if (member.getGrade().equals(Code.USER_GRADE_VIP))
				point = betting.getMoney() * 0.03;
			
			Member receiver = null;
			if (member.getIntroducerId() == null) {
				receiver = member;
			}
			else {
				receiver = memberDao.selectMember(member.getIntroducerId(), null);
			}
				
			memberDao.plusMinusPoint(receiver.getUserId(), point.longValue());
			
			Point pointLog = new Point();
			pointLog.setUserId(receiver.getUserId());
			pointLog.setType(Code.POINT_TYPE_BETTING);
			pointLog.setDate(new Date());
			pointLog.setOldBalance(receiver.getPoint());
			pointLog.setMoney(point.longValue());
			pointLog.setBalance(receiver.getPoint() + point.longValue());
			pointLog.setBettingId(betting.getId());
			pointLog.setNote(member.getNickName() + "(" + member.getUserId() + ")");
			pointLog.setBettingUserId(member.getUserId());
			
			pointDao.insertPoint(pointLog);
			
			//소개인 정보 갱신
			if (member.getIntroducerId() != null) {
				Member introducer = new Member();
				introducer.setUserId(member.getIntroducerId());
				introducer.setIntroduceBettingCount(1);
				introducer.setIntroduceBettingMoney(betting.getMoney());
				introducer.setIntroduceBettingPoint(point.longValue());
				
				memberDao.updateMemberIntroduce(introducer);
			}		
		}
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
						String message = "[No1Bet] " + betting.getNickName() + "님의 " + betting.getId() + "번 배팅이 " +
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
