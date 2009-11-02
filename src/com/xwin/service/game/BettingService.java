package com.xwin.service.game;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Point;
import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.service.admin.XwinService;

public class BettingService extends XwinService
{
	public void processBetting(GameFolder gameFolder, Member member, String source)
	{
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		String signature = makeBettingSignature(itemList);
		
		Betting betting = new Betting();
		
		betting.setUserId(member.getUserId());
		betting.setMoney(gameFolder.getMoney());
		betting.setRate(gameFolder.getRate());
		betting.setExpect(gameFolder.getExpect());
		betting.setStatus(Code.BET_STATUS_RUN);
		betting.setDate(new Date());
		betting.setGameType(gameFolder.getType());
		betting.setNickName(member.getNickName());
		betting.setIntroducerId(member.getIntroducerId());
		betting.setMemberId(member.getMemberId());
		betting.setSignature(signature);
		betting.setSource(source);
		
		String bettingId = bettingDao.insertBetting(betting);
		
		for (GameFolderItem gfi : itemList) {
			BetGame betGame = new BetGame();
			betGame.setBettingId(bettingId);
			betGame.setId(gfi.getId());
			betGame.setGuess(gfi.getGuess());
			betGame.setWinRate(gfi.getWinRate());
			betGame.setDrawRate(gfi.getDrawRate());
			betGame.setLoseRate(gfi.getLoseRate());
			betGame.setSelRate(gfi.getSelRate());
			betGame.setResultStatus(Code.RESULT_STATUS_RUN);
			
			betGameDao.insertBetGame(betGame);
		}
		
		Account account = new Account();
		account.setUserId(member.getUserId());
		account.setType(Code.ACCOUNT_TYPE_BETTING);
		account.setDate(new Date());
		account.setOldBalance(member.getBalance());
		account.setMoney(betting.getMoney() * -1);
		account.setBalance(member.getBalance() - betting.getMoney());
		account.setBettingId(betting.getId());
		
		accountDao.insertAccount(account);			
		memberDao.plusMinusBalance(member.getUserId(), betting.getMoney() * -1);

		if (logger.isInfoEnabled()) {
			logger
					.info("betting(HttpServletRequest, HttpServletResponse) - betting=\n"
							+ betting);
		}
		
		
		//애플 지급
		Double betting_point_rate = 0.01;
		int size = itemList.size();
		if (size >= 4)
			betting_point_rate = 0.02;
		if (size >= 7)
			betting_point_rate = 0.03;
		if (size >= 10)
			betting_point_rate = 0.05;
		
		Double point = betting.getMoney() * betting_point_rate;
		memberDao.plusMinusPoint(member.getUserId(), point.longValue());
		
		Point pointLog = new Point();
		pointLog.setUserId(member.getUserId());
		pointLog.setType(Code.POINT_TYPE_BETTING);
		pointLog.setDate(new Date());
		pointLog.setOldBalance(member.getPoint());
		pointLog.setMoney(point.longValue());
		pointLog.setBalance(member.getPoint() + point.longValue());
		pointLog.setBettingId(betting.getId());
		pointLog.setNote(size + "폴더 배팅 " + (int)(betting_point_rate * 100) + "% 애플");
		pointLog.setBettingUserId(member.getUserId());
		
		pointDao.insertPoint(pointLog);
		member.setPoint(pointLog.getBalance());
		
		//추천인 애플지급
		String introducerId = member.getIntroducerId();
		if (introducerId != null) {
			Member introducer = memberDao.selectMember(introducerId, null);
			Double intro_point_rate = 0.02;
			
			Double intro_point = betting.getMoney() * intro_point_rate;
			memberDao.plusMinusPoint(introducerId, intro_point.longValue());
			
			Point introPointLog = new Point();
			introPointLog.setUserId(introducer.getUserId());
			introPointLog.setType(Code.POINT_TYPE_BETTING);
			introPointLog.setDate(new Date());
			introPointLog.setOldBalance(introducer.getPoint());
			introPointLog.setMoney(intro_point.longValue());
			introPointLog.setBalance(introducer.getPoint() + intro_point.longValue());
			introPointLog.setBettingId(betting.getId());
			introPointLog.setNote("프랜드(" + member.getUserId() + ") 배팅 " + (int)(intro_point_rate*100) + "% 애플");
			introPointLog.setBettingUserId(member.getUserId());
			
			pointDao.insertPoint(introPointLog);
		}
		
		// 모바일 애플 지급
		if (source.equals(Code.SOURCE_WAP)) {
			Double mobile_point_rate = 0.01;
			
			Double mobile_point = betting.getMoney() * mobile_point_rate;
			memberDao.plusMinusPoint(member.getUserId(), mobile_point.longValue());
			
			Point mobilePointLog = new Point();
			mobilePointLog.setUserId(member.getUserId());
			mobilePointLog.setType(Code.POINT_TYPE_BETTING);
			mobilePointLog.setDate(new Date());
			mobilePointLog.setOldBalance(member.getPoint());
			mobilePointLog.setMoney(mobile_point.longValue());
			mobilePointLog.setBalance(member.getPoint() + mobile_point.longValue());
			mobilePointLog.setBettingId(betting.getId());
			mobilePointLog.setNote("모바일 배팅 " + (int)(mobile_point_rate * 100) + "% 애플");
			mobilePointLog.setBettingUserId(member.getUserId());
			
			pointDao.insertPoint(mobilePointLog);
			member.setPoint(mobilePointLog.getBalance());
		}
	}

	public boolean checkBettingAccept(GameFolder gameFolder)
	{
		boolean accept = true;
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		for (GameFolderItem gfi : itemList) {
			Game game = gameDao.selectGame(gfi.getId());
			String guess = gfi.getGuess();
			if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false ||
					game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT) == false ||
					(guess.equals("W") && game.getWinDeny().equals("Y") == false) ||
					(guess.equals("D") && game.getDrawDeny().equals("Y") == false) ||
					(guess.equals("L") && game.getLoseDeny().equals("Y") == false)
					)
			{
				accept = false;
			}
		}
			
		return accept;
	}

	public Integer checkDuplicateBetting(GameFolder gameFolder, String userId)
	{
		Integer duplicate = 1;
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("signature", makeBettingSignature(gameFolder.getGameFolderItemList()));
		param.put("status", Code.BET_STATUS_RUN);
//		Integer count = bettingDao.selectBettingCount(param);
//		
//		if (count > 0)
//			duplicate = true;
		
		Integer moneySum = XwinUtil.ntz(bettingDao.selectBettingMoneySum(param));
		Integer expectSum = XwinUtil.ntz(bettingDao.selectBettingExpectSum(param));
		
		if (moneySum + gameFolder.getMoney() > 1000000)
			duplicate = -1;
		else if (expectSum + gameFolder.getExpect() > 3000000)
			duplicate = -2;
			
		return duplicate;
	}
	
	public String makeBettingSignature(List<GameFolderItem> itemList)
	{
		List<String> idGuessList = new ArrayList<String>(itemList.size());
		for (GameFolderItem gfi : itemList) {
			idGuessList.add(gfi.getId() + gfi.getGuess());
		}
		Collections.sort(idGuessList);
		String signature = "";
		for (String idGuess : idGuessList) {
			signature += idGuess;
		}
		
		return signature;
	}
}
