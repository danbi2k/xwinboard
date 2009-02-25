package com.xwin.web.controller.game;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BettingCart;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.FolderCalc;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BettingController extends XwinController
{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(BettingController.class);

	private static final long MAX_EXPECT = 3000000;
	
	public synchronized ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String _type = request.getParameter("type");
		String _money = request.getParameter("money");
		String _action = request.getParameter("action");
		HttpSession session = request.getSession();
		
		Member sessionMember = (Member) session.getAttribute("Member");		
		Member member = memberDao.selectMember(sessionMember.getUserId(), null);
		BettingCart bettingCart = (BettingCart) session.getAttribute("BettingCart");
		
		GameFolder gameFolder =
			(GameFolder)session.getAttribute("gameFolder_" + _type);
		
		Long money = Long.parseLong(_money);		
		FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		if (itemList.size() == 0) {
			rx = new ResultXml(-1, "경기를 선택 하십시오", null);
		}
		else if (bettingService.checkBettingAccept(gameFolder) == false) {
			rx = new ResultXml(-2, "배팅 가능한 상태가 아닌 경기가 포함되어 있습니다", null);
		}
		else if (fc.getMoney() < 5000) {
			rx = new ResultXml(-1, "최소 배팅 금액은 5,000원 입니다", null);
		}
		else if (fc.getMoney() > 1000000) {
			rx = new ResultXml(-1, "최대 배팅 금액은 1000,000원 입니다", null);
		}
		else if (fc.getExpect() > MAX_EXPECT) {
			rx = new ResultXml(-1, "배당금이 300만원을 초과 하였습니다", null);
		}
		else if (_action.equals("betting") && fc.getAfter() < 0) {
			rx = new ResultXml(-1, "잔액이 부족합니다", null);
		}
		else if (_action.equals("betting")) {
			bettingService.processBetting(gameFolder, member);
			
			session.removeAttribute("gameFolder_" + _type);
			
			rx = new ResultXml(0, "배팅 하셨습니다", null);
			Member betMember = (Member) session.getAttribute("Member");
			betMember.setBettingDate(new Date());
		}
		else if (_action.equals("cart")) {
			bettingCart.add(gameFolder);
			
			rx = new ResultXml(0, "배팅카트에 추가 되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));

		return mv;
	}
	
	public ModelAndView addGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		Member member = (Member) session.getAttribute("Member");		
		
		String gameId = request.getParameter("gameId");
		String guess = request.getParameter("guess");
		String _money = request.getParameter("money");		
		
		Long money = 0L;
		if (_money != null)
			money = Long.parseLong(_money);
		
		FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());		
		Game game = gameDao.selectGame(gameId);
		Double thisRate = null;
		if (guess.equals("W"))
			thisRate = game.getWinRate();
		else if (guess.equals("D"))
			thisRate = game.getDrawRate();
		else if (guess.equals("L"))
			thisRate = game.getLoseRate();
		
		int retCode = 0;
		String message = null;
		
		if (gameFolder.size() >= 10 && gameFolder.containsKey(gameId) == false) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "게임은 10개까지 선택 하실 수 있습니다";
		} else if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false ||
				game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT) == false) {
			gameFolder.remove(game.getId());
			retCode = -2;
			message = "배팅 가능 상태가 아닙니다";
		} else if ((guess.equals("W") && game.getWinDeny().equals("Y") == false) ||
				(guess.equals("D") && game.getDrawDeny().equals("Y") == false) ||
				(guess.equals("L") && game.getLoseDeny().equals("Y") == false)) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "배팅 가능 상태가 아닙니다";
		}
		else if (XwinUtil.calcExpectMoney(thisRate * fc.getRate(), money) > MAX_EXPECT) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "배당금이 300만원을 초과 하였습니다";
		} else {
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
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		ResultXml rx = new ResultXml(retCode, message, itemList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		String gameId = request.getParameter("gameId");
		
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		
		gameFolder.remove(gameId);
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		
		ResultXml rx = new ResultXml(0, null, itemList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView getGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		
		ResultXml rx = new ResultXml(0, null, itemList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView emptyGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		session.removeAttribute("gameFolder_" + type);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(new ResultXml(0, null, null)));
		return mv;
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
