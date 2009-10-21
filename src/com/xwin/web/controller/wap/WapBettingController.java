package com.xwin.web.controller.wap;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.FolderCalc;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapBettingController extends XwinController
{
	
	private static final long MAX_EXPECT = 3000000;

	public ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String _type = request.getParameter("type");
		String _money = request.getParameter("money");
		String token = request.getParameter("token");
		String selectList[] = request.getParameterValues("game_list");
		
		String UP_URL = "play.wap?mode=viewGameList&type="+_type+"&token="+token;	
		
		Long money = Long.parseLong(_money);		
		GameFolder gameFolder = makeGameFolder(selectList, _type, money);				
		FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());
		
		ResultWap rw = null;
		Integer retVal = 0;		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		if (itemList.size() == 0) {
			rw = new ResultWap(-1, "선택하신 게임이 없습니다", UP_URL, null);
		}
		else if (bettingService.checkBettingAccept(gameFolder) == false) {
			rw = new ResultWap(-2, "일부 게임이 배팅 마감 상태 입니다", UP_URL, null);
		}
		else if (fc.getMoney() < 5000) {
			rw = new ResultWap(-1, "5,000캐쉬 이상 배팅 하셔야 합니다", UP_URL, null);
		}
		else if (fc.getMoney() > 1000000) {
			rw = new ResultWap(-1, "1,000,000캐쉬 이상은 배팅 하실 수 없습니다", UP_URL, null);
		}
		else if (fc.getExpect() > MAX_EXPECT) {
			rw = new ResultWap(-1, "예상 배당금은 3000,000캐쉬 이하만 허용 됩니다", UP_URL, null);
		}
		else if (fc.getAfter() < 0) {
			rw = new ResultWap(-1, "캐쉬 잔고가 부족합니다", UP_URL, null);
		}
		else if ((retVal = bettingService.checkDuplicateBetting(gameFolder, member.getUserId())) < 0) {
			if (retVal == -1)
				rw = new ResultWap(-1, "중복배팅입니다\n배팅금액 1,000,000캐쉬 초과", UP_URL, null);
			else
				rw = new ResultWap(-1, "중복배팅입니다\n배당금액 3,000,000캐쉬 초과", UP_URL, null);
		}
		else {
			bettingService.processBetting(gameFolder, member);			
			rw = new ResultWap(0, "배팅에 성공하였습니다\n회원님의 대박을 기원합니다", UP_URL, null);
		}
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
		mv.addObject("resultWap", rw);

		return mv;
	}
	
	public GameFolder makeGameFolder(String[] selectList, String type, Long _money)
	{
		GameFolder gameFolder = new GameFolder(type);
		
		for (int i = 0 ; i < selectList.length ; i++) {
			if (selectList[i].equals("0") == false) {
				String selectItem[] = selectList[i].split("_");
				String guess = selectItem[0];
				String gameId = selectItem[1];
				Game game = gameDao.selectGame(gameId);
				
				Double thisRate = null;
				if (guess.equals("W"))
					thisRate = game.getWinRate();
				else if (guess.equals("D"))
					thisRate = game.getDrawRate();
				else if (guess.equals("L"))
					thisRate = game.getLoseRate();
				
				GameFolderItem gfi = new GameFolderItem();
				gfi.setId(gameId);
				gfi.setHomeTeam(game.getHomeTeam());
				gfi.setAwayTeam(game.getAwayTeam());
				gfi.setWinRate(game.getWinRate());
				gfi.setDrawRate(game.getDrawRate());
				gfi.setLoseRate(game.getLoseRate());
				gfi.setSelRate(thisRate);
				gfi.setGuess(guess);
				gfi.setLeagueName(game.getLeagueName());
				gfi.setType(game.getType());
				gfi.setGameDate(game.getGameDate());
				
				gameFolder.put(gameId, gfi);
			}
		}
		
		return gameFolder;
	}
	
	private FolderCalc getFolderCalc(GameFolder gameFolder, Long money, Long memberBalance)
	{
		gameFolder.setMoney(money);
		gameFolder.calculate();
		
		Double cutRate = gameFolder.getRate();
		Long expect = gameFolder.getExpect();
		Long balance = memberBalance;		
		Long after = null;
		if (cutRate > 0)
			after = balance - money;
		else
			after = balance;
		
		FolderCalc fc = new FolderCalc();
		
		fc.setRate(cutRate);
		fc.setBalance(balance);
		fc.setMoney(money);
		fc.setAfter(after);
		fc.setExpect(expect);
		
		return fc;
	}
}