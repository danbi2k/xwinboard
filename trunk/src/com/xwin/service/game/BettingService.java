package com.xwin.service.game;

import java.util.Date;
import java.util.List;

import com.xwin.domain.admin.Account;
import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.service.admin.XwinService;

public class BettingService extends XwinService
{
	public void processBetting(GameFolder gameFolder, Member member)
	{
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		
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
}
