package com.xwin.web.controller.wap;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.FolderCalc;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapGameController extends XwinController
{
	private final static int ROWSIZE = 5;
	private static final long MAX_EXPECT = 3000000;
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));		
	
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.HOUR, 8);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		if (grade.equals(Code.USER_GRADE_VIP) && member.getGrade().equals(Code.USER_GRADE_VIP))
			param.put("grade", Code.USER_GRADE_VIP);
		else
			param.put("grade", Code.USER_GRADE_NORMAL);
		
		Map<String, List<Game>> gameListMap = new HashMap<String, List<Game>>();
		List<Game> gameList = gameDao.selectGameList(param);
		for (Game game : gameList) {
			String leagueId = game.getLeagueId();
			List<Game> leagueGameList = gameListMap.get(leagueId);
			if (leagueGameList == null) {
				leagueGameList = new ArrayList<Game>();
				gameListMap.put(leagueId, leagueGameList);
			}
			leagueGameList.add(game);
		}
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game_mem");
		mv.addObject("gameListMap", gameListMap);

		return mv; 
	}
	
	public ModelAndView viewGameResultList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		
		if (gameDate == null)
			gameDate = XwinUtil.toDateStr(new Date(), 2);
	
		Date[] datePair = XwinUtil.getDatePair(gameDate);
		Date fromDate = datePair[0];
		Date toDate = datePair[1];
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
	
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		List<String> statusList = new ArrayList<String>();
		statusList.add(Code.GAME_STATUS_END);
		statusList.add(Code.GAME_STATUS_CANCEL);
		param.put("statusList", statusList);
		param.put("leagueId", leagueId);
		param.put("fromDate", fromDate);
		param.put("toDate", toDate);
		param.put("ORDERBY", "DESC");
		param.put("gradeLess", member.getGrade());
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Game> gameList = gameDao.selectGameList(param);
		Integer totalCount = gameDao.selectGameCount(param);
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game_result");
		mv.addObject("gameList", gameList);
		mv.addObject("totalCount", totalCount);

		return mv; 
	}
	
	public ModelAndView viewGameListByLeague(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));	
		String leagueId = XwinUtil.arcNvl(request.getParameter("league_id"));
		String selectList[] = request.getParameterValues("game_list");
		GameFolder gameFolder = makeGameFolder(selectList, type);		
	
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.HOUR, 8);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		if (grade.equals(Code.USER_GRADE_VIP) && member.getGrade().equals(Code.USER_GRADE_VIP))
			param.put("grade", Code.USER_GRADE_VIP);
		else
			param.put("grade", Code.USER_GRADE_NORMAL);
		
		Map<String, List<Game>> gameListMap = new HashMap<String, List<Game>>();
		Map<String, String> leagueListMap = new HashMap<String, String>();
		
		List<Game> gameList = gameDao.selectGameList(param);
		for (Game game : gameList) {
			String gameLeagueId = game.getLeagueId();
			String gameLeagueName = game.getLeagueName();
			if (leagueListMap.get(gameLeagueId) == null) {
				leagueListMap.put(gameLeagueId, gameLeagueName);
			}
			
			if (gameLeagueId.equals(leagueId)) {			
				List<Game> leagueGameList = gameListMap.get(leagueId);
				if (leagueGameList == null) {
					leagueGameList = new ArrayList<Game>();
					gameListMap.put(leagueId, leagueGameList);
				}
				leagueGameList.add(game);
			}
		}
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game_srv");
		mv.addObject("gameListMap", gameListMap);
		mv.addObject("leagueListMap", leagueListMap);
		mv.addObject("gameFolder", gameFolder);

		return mv; 
	}

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
		
		String UP_URL = "betlog.wap?mode=viewMyBettingList&token="+token;	
		
		Long money = Long.parseLong(_money);		
		GameFolder gameFolder = makeGameFolder(selectList, _type);				
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
			bettingService.processBetting(gameFolder, member, Code.SOURCE_WAP);			
			rw = new ResultWap(0, "배팅에 성공하였습니다\n회원님의 대박을 기원합니다", UP_URL, null);
		}
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
		mv.addObject("resultWap", rw);

		return mv;
	}
	
	public GameFolder makeGameFolder(String[] selectList, String type)
	{
		if (selectList == null)
			return null;
		
		GameFolder gameFolder = new GameFolder(type);
		
		for (int i = 0 ; i < selectList.length ; i++) {
			System.out.println(i + " : " + selectList[i]);
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
				gfi.setLeagueId(game.getLeagueId());
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