package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.League;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.GameCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminGameController extends XwinController
{	
	public static final int ROWSIZE = 10;
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String betStatus = XwinUtil.arcNvl(request.getParameter("betStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", status);
		param.put("betStatus", betStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		if (gameDate != null) {
			Date[] pair = XwinUtil.getDatePair(gameDate);
			param.put("fromDate", pair[0]);
			param.put("toDate", pair[1]);
		}
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<League> leagueList = leagueDao.selectLeagueList();
		Integer gameCount = gameDao.selectGameCount(param);
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("gameList", gameList);
		mv.addObject("gameCount", gameCount);
		return mv;
	}
	
	public ModelAndView viewRegisterGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("admin/game/register_game");
		mv.addObject("leagueList", leagueList);
		return mv;
	}
	
	public ModelAndView viewUpdateGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		String id = request.getParameter("id");
		List<League> leagueList = leagueDao.selectLeagueList();
		Game game = gameDao.selectGame(id);
		
		ModelAndView mv = new ModelAndView("admin/game/update_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("game", game);
		return mv;
	}
	
	public ModelAndView registerGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		String type = (String) request.getParameter("type");
		
		Game game = new Game();
		game.setLeagueId(command.getLeagueId());
		game.setHomeTeam(command.getHomeTeam());
		game.setAwayTeam(command.getAwayTeam());
		game.setGameDate(XwinUtil.getDate(command.getGameDate(), command.getGameHour(), command.getGameMinute()));
		game.setWinRate(command.getWinRate());
		game.setDrawRate(command.getDrawRate());
		game.setLoseRate(command.getLoseRate());
				
		game.setStatus(Code.GAME_STATUS_READY);
		game.setBetStatus(Code.BETTING_STATUS_ACCEPT);
		game.setType(type);
		
		gameDao.insertGame(game);
		
		ResultXml rx = new ResultXml(0, "등록되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView updateGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		ResultXml rx = null;
		
		try {
			String type = (String) request.getParameter("type");
			
			Game game = new Game();
			game.setId(command.getGameId());
			game.setLeagueId(command.getLeagueId());
			game.setHomeTeam(command.getHomeTeam());
			game.setAwayTeam(command.getAwayTeam());
			game.setGameDate(XwinUtil.getDate(command.getGameDate(), command.getGameHour(), command.getGameMinute()));
			game.setWinRate(command.getWinRate());
			game.setDrawRate(command.getDrawRate());
			game.setLoseRate(command.getLoseRate());				
			game.setStatus(Code.GAME_STATUS_READY);
			game.setType(type);
			
			gameDao.updateGame(game);
			
			rx = new ResultXml(0, "수정되었습니다", null);
		} catch (Exception e) {
			rx = new ResultXml(-1, "서버오류", null);
			throw e;
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView getGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String status = null;//request.getParameter("status");
		String type = request.getParameter("type");
		
		List<Game> gameList = gameDao.selectGameList(type, status, null, null);
		
		ResultXml rx = new ResultXml(0, null, gameList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView runGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		ResultXml rx = null;		
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		
		gameDao.updateGameScoreNull(id, null, null, null, Code.GAME_STATUS_RUN);
		bettingDao.updateBettingStatus(id);
		
		rx = new ResultXml(0, "경기가 진행 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView endGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		String id = request.getParameter("id");
		String _homeScore = request.getParameter("homeScore");
		String _awayScore = request.getParameter("awayScore");
		String type = request.getParameter("type");
		
		Integer homeScore = null;
		Integer awayScore = null;
		
		ResultXml rx = null;
		
		try {
			homeScore = Integer.parseInt(_homeScore);
			awayScore = Integer.parseInt(_awayScore);
		} catch(NumberFormatException e) {}
		
		Game game = gameDao.selectGame(id);
		if (homeScore == null && awayScore == null) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		} else if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false) {
			rx = new ResultXml(-1, "경기진행 상태가 아닙니다", null);
		} else {
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
				else
					result = "D";
			}
			
			game.setHomeScore(homeScore);
			game.setAwayScore(awayScore);
			game.setResult(result);
			game.setStatus(Code.GAME_STATUS_END);
			
			gameDao.updateGame(game);			
			bettingDao.updateBettingStatus(id);
			
			List<Betting> bettingList = bettingDao.selectBettingByNoticeReaquired();
			if (bettingList != null) {
				for (Betting betting : bettingList) {
					Member member = memberDao.selectMember(betting.getUserId(), null);
					String message = betting.getNickName() + "님의 " + betting.getId() + "번 배팅이 " +
							Code.getValue(betting.getStatus()) + " 되었습니다.";
					if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
						message += "배당금 : " + XwinUtil.comma3(betting.getExpect());
					
					sendSmsConnector.sendSms(message, member.getMobile(), "000-000-0000");
					
					bettingService.calcuateBettingCommon(betting);
					
					betting.setIsNotice(Code.BET_NOTICE_COMMIT);
					bettingDao.updateBetting(betting);
				}
			}
			
			rx = new ResultXml(0, "경기가 종료 되었습니다", null);
		} 
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView cancelGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		ResultXml rx = null;		
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		
		Game game = new Game();
		game.setId(id);
		game.setHomeScore(null);
		game.setAwayScore(null);
		game.setResult(null);
		game.setWinRate(1.0);
		game.setDrawRate(1.0);
		game.setLoseRate(1.0);		
		game.setStatus(Code.GAME_STATUS_CANCEL);
		
		// 1. 켄슬된 게임의 승률을 1.0 으로 하고 상태를 CANCEL로
		gameDao.updateGameScoreNull(id, null, null, null, Code.GAME_STATUS_CANCEL);
		gameDao.updateGame(game);
		
		// 3. 관련 배팅 전체에 대해서 배팅률 재계산 해서 업데이트
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("gameId", game.getId());
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		
		for (Betting betting : bettingList) {
			List<BetGame> betGameList = betting.getBetGameList();
			Double totalRate = 0.0;
			for (BetGame betGame : betGameList)	{
				String guess = betGame.getGuess();
				Double selectRate = 0.0;
				if (guess.equals("W"))
					selectRate = betGame.getWinRate();
				else if (guess.equals("D"))
					selectRate = betGame.getDrawRate();
				else if (guess.equals("L"))
					selectRate = betGame.getLoseRate();
				
				if (totalRate == 0.0)
					totalRate = selectRate;
				else
					totalRate *= selectRate;
			}
			Long expect = XwinUtil.calcExpectMoney(totalRate, betting.getMoney());
			
			betting.setRate(totalRate);
			betting.setExpect(expect);
			bettingDao.updateBetting(betting);
		}
		

		bettingDao.updateBettingStatus(id);
		
		rx = new ResultXml(0, "경기가 취소 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView readyGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		
		ResultXml rx = null;	
		
		gameDao.updateGameScoreNull(id, null, null, null, Code.GAME_STATUS_READY);
		bettingDao.updateBettingStatus(id);
		
		rx = new ResultXml(0, "경기가 대기 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView changeBetStatus(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		String id = request.getParameter("id");
		String betStatus = request.getParameter("betStatus");
		String type = request.getParameter("type");
		
		Game game = new Game();
		game.setId(id);
		game.setBetStatus(betStatus);
		
		gameDao.updateGame(game);
		
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}