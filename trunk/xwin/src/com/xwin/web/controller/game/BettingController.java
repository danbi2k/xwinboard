package com.xwin.web.controller.game;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
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
	
	public ModelAndView viewBettingCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		//List<AllCartItem> allCartList = (List<AllCartItem>) request.getSession().getAttribute("allCartList");
		
		ModelAndView mv = new ModelAndView("game/betting_cart");
		//mv.addObject(allCartList);
		
		return mv;
	}
	
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
		HttpSession session = request.getSession();
		
		Member sessionMember = (Member) session.getAttribute("Member");		
		Member member = memberDao.selectMember(sessionMember.getUserId(), null);
		
		GameFolder gameFolder =
			(GameFolder)session.getAttribute("gameFolder_" + _type);
		
		Betting betting = new Betting();
		Long money = Long.parseLong(_money);		
		FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());
		
		Collection<GameFolderItem> folderCol = gameFolder.values();
		for (GameFolderItem gci : folderCol) {
			Game game = gameDao.selectGame(gci.getGameId());
			String guess = gci.getGuess();
			if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false ||
					game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT) == false ||
					(guess.equals("W") && game.getWinDeny().equals("Y") == false) ||
					(guess.equals("D") && game.getDrawDeny().equals("Y") == false) ||
					(guess.equals("L") && game.getLoseDeny().equals("Y") == false)
					) {
				rx = new ResultXml(-2, "배팅 가능한 상태가 아닌 경기가 포함되어 있습니다", null);
				
				ModelAndView mv = new ModelAndView("xmlFacade");
				mv.addObject("resultXml", XmlUtil.toXml(rx));
				
				return mv;
			}
		}
		
		if (folderCol.size() == 0) {
			rx = new ResultXml(-1, "경기를 선택 하십시오", null);
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
		else if (fc.getAfter() < 0) {
			rx = new ResultXml(-1, "잔액이 부족합니다", null);
		} else {
			betting.setUserId(member.getUserId());
			betting.setMoney(fc.getMoney());
			betting.setRate(fc.getRate());
			betting.setExpect(fc.getExpect());
			betting.setStatus(Code.BET_STATUS_RUN);
			betting.setDate(new Date());
			betting.setGameType(_type);
			betting.setNickName(member.getNickName());
			betting.setIntroducerId(member.getIntroducerId());
			
			String bettingId = bettingDao.insertBetting(betting);
			
			for (GameFolderItem gci : folderCol) {
				BetGame betGame = new BetGame();
				betGame.setBettingId(bettingId);
				betGame.setId(gci.getGameId());
				betGame.setGuess(gci.getGuess());
				betGame.setWinRate(gci.getWinRate());
				betGame.setDrawRate(gci.getDrawRate());
				betGame.setLoseRate(gci.getLoseRate());
				betGame.setSelRate(gci.getSelRate());
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
			
//			Double point = 0.0;
//			if (member.getGrade().equals(Code.USER_GRADE_NORMAL))
//				point = betting.getMoney() * 0.02;
//			else if (member.getGrade().equals(Code.USER_GRADE_VIP))
//				point = betting.getMoney() * 0.03;
//			
//			String receiveId = null;
//			if (member.getIntroducerId() == null)
//				receiveId = member.getUserId();
//			else
//				receiveId = member.getIntroducerId();
//				
//			memberDao.plusMinusPoint(receiveId, point.longValue());
//			
//			Point pointLog = new Point();
//			pointLog.setUserId(receiveId);
//			pointLog.setType(Code.POINT_TYPE_BETTING);
//			pointLog.setDate(new Date());
//			pointLog.setOldBalance(member.getPoint());
//			pointLog.setMoney(point.longValue());
//			pointLog.setBalance(member.getPoint() + point.longValue());
//			pointLog.setBettingId(betting.getId());
//			pointLog.setNote(member.getNickName() + "(" + member.getUserId() + ")");
//			pointLog.setBettingUserId(member.getUserId());
//			
//			pointDao.insertPoint(pointLog);
			
			session.removeAttribute("gameFolder_" + _type);
			
			rx = new ResultXml(0, "배팅 하셨습니다", null);
			Member betMember = (Member) session.getAttribute("Member");
			betMember.setBettingDate(new Date());
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));

		if (logger.isInfoEnabled()) {
			logger
					.info("betting(HttpServletRequest, HttpServletResponse) - betting=\n"
							+ betting);
		}

		return mv;
	}
	
	public ModelAndView calculateCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = getLoginMember(request);
		if (member == null) {
			return new ModelAndView("dummy");
		}
			
		String type = request.getParameter("type");
		String _money = request.getParameter("money");		
		HttpSession session = request.getSession();
		
		GameFolder gameFolder =
			(GameFolder)session.getAttribute("gameFolder_" + type);
		
		Long money = null;
		ResultXml rx = null;
		
		try {
			money = Long.parseLong(_money);
		} catch (Exception e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
		if (money != null) {
			FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());
			
			if (fc.getExpect() > MAX_EXPECT) {
				rx = new ResultXml(-1, "배당금이 300만원을 초과 하였습니다", fc);
			} else {
				rx = new ResultXml(0, null, fc);
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView addGameCart(HttpServletRequest request,
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
		else if ((XwinUtil.calcExpectMoney(thisRate * fc.getRate(), money) + fc.getExpect()) > MAX_EXPECT) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "배당금이 300만원을 초과 하였습니다";
		} else {
			GameFolderItem gci = new GameFolderItem();
			gci.setGameId(gameId);
			gci.setHomeTeam(game.getHomeTeam());
			gci.setAwayTeam(game.getAwayTeam());
			gci.setWinRate(game.getWinRate());
			gci.setDrawRate(game.getDrawRate());
			gci.setLoseRate(game.getLoseRate());
			gci.setSelRate(thisRate);
			gci.setGuess(guess);
			gci.setLeague(game.getLeagueName());
			
			gameFolder.put(gameId, gci);
		}
		
		List<GameFolderItem> itemList = new ArrayList<GameFolderItem>(gameFolder.size());
		itemList.addAll(gameFolder.values());
		ResultXml rx = new ResultXml(retCode, message, itemList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteGameCart(HttpServletRequest request,
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
		
		List<GameFolderItem> cartList = new ArrayList<GameFolderItem>(gameFolder.size());
		cartList.addAll(gameFolder.values());
		
		ResultXml rx = new ResultXml(0, null, cartList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView getGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		
		List<GameFolderItem> cartList = new ArrayList<GameFolderItem>(gameFolder.size());
		cartList.addAll(gameFolder.values());
		
		ResultXml rx = new ResultXml(0, null, cartList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView emptyGameCart(HttpServletRequest request,
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
		Double totalRate = 0.0;
		
		Collection<GameFolderItem> folderColl = gameFolder.values();
		if (folderColl != null && folderColl.size() > 0) {
			totalRate = 1.0;
			for (GameFolderItem gci : folderColl) {
				Double rate = null;
				if (gci.getGuess().equals("W"))
					rate = gci.getWinRate();
				else if (gci.getGuess().equals("D"))
					rate = gci.getDrawRate();
				else if (gci.getGuess().equals("L"))
					rate = gci.getLoseRate();
				
				totalRate *= rate;
			}
		}
		Double cutRate = XwinUtil.doubleCut(totalRate);
		Long expect = XwinUtil.calcExpectMoney(cutRate, money);		
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
