package com.xwin.web.controller.game;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Point;
import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.AllCartItem;
import com.xwin.web.command.CartCalc;
import com.xwin.web.command.GameCartItem;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BettingController extends XwinController
{
	private static final long MAX_EXPECT = 3000000;
	
	public ModelAndView viewBettingCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		List<AllCartItem> allCartList = (List<AllCartItem>) request.getSession().getAttribute("allCartList");
		
		ModelAndView mv = new ModelAndView("game/betting_cart");
		mv.addObject(allCartList);
		
		return mv;
	}
	
	public ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String _type = request.getParameter("type");
		String _money = request.getParameter("money");
		HttpSession session = request.getSession();
		
		Member sessionMember = (Member) session.getAttribute("Member");		
		Member member = memberDao.selectMember(sessionMember.getUserId(), null);
		
		Map<String, GameCartItem> cartMap =
			(Map<String, GameCartItem>)session.getAttribute("cartMap_" + _type);
		
		Betting betting = new Betting();
		Long money = Long.parseLong(_money);		
		CartCalc cc = getCartCalc(cartMap, money, member.getBalance());
		
		Collection<GameCartItem> cartCol = cartMap.values();
		for (GameCartItem gci : cartCol) {
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
		
		if (cartCol.size() == 0) {
			rx = new ResultXml(-1, "경기를 선택 하십시오", null);
		}
		else if (cc.getMoney() < 5000) {
			rx = new ResultXml(-1, "최소 배팅 금액은 5,000원 입니다", null);
		}
		else if (cc.getMoney() > 1000000) {
			rx = new ResultXml(-1, "최대 배팅 금액은 1000,000원 입니다", null);
		}
		else if (cc.getExpect() > MAX_EXPECT) {
			rx = new ResultXml(-1, "배당금이 300만원을 초과 하였습니다", null);
		}
		else if (cc.getAfter() < 0) {
			rx = new ResultXml(-1, "잔액이 부족합니다", null);
		} else {
			betting.setUserId(member.getUserId());
			betting.setMoney(cc.getMoney());
			betting.setRate(cc.getRate());
			betting.setExpect(cc.getExpect());
			betting.setStatus(Code.BET_STATUS_RUN);
			betting.setTotalCount(cartMap.size());
			betting.setDate(new Date());
			betting.setGameType(_type);
			betting.setNickName(member.getNickName());
			
			String bettingId = bettingDao.insertBetting(betting);
			
			for (GameCartItem gci : cartCol) {
				BetGame betGame = new BetGame();
				betGame.setBettingId(bettingId);
				betGame.setId(gci.getGameId());
				betGame.setGuess(gci.getGuess());
				
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
			
			Double point = betting.getMoney() * 0.02;			
			memberDao.plusMinusPoint(member.getUserId(), point.longValue());
			
			Point pointLog = new Point();
			pointLog.setUserId(member.getUserId());
			pointLog.setType(Code.POINT_TYPE_BETTING);
			pointLog.setDate(new Date());
			pointLog.setOldBalance(member.getPoint());
			pointLog.setMoney(point.longValue());
			pointLog.setBalance(member.getPoint() + point.longValue());
			pointLog.setBettingId(betting.getId());
			
			pointDao.insertPoint(pointLog);
			
			session.removeAttribute("cartMap_" + _type);
			
			rx = new ResultXml(0, "배팅 하셨습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView calculateCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = getLoginMember(request);
		if (member == null) {
			return new ModelAndView("dummy");
		}
			
		String type = request.getParameter("type");
		String _money = request.getParameter("money");		
		HttpSession session = request.getSession();
		
		Map<String, GameCartItem> cartMap =
			(Map<String, GameCartItem>)session.getAttribute("cartMap_" + type);
		
		Long money = null;
		ResultXml rx = null;
		
		try {
			money = Long.parseLong(_money);
		} catch (Exception e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
		if (money != null) {
			CartCalc cc = getCartCalc(cartMap, money, member.getBalance());
			
			if (cc.getExpect() > MAX_EXPECT) {
				rx = new ResultXml(-1, "배당금이 300만원을 초과 하였습니다", cc);
			} else {
				rx = new ResultXml(0, null, cc);
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView addGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		Map<String, GameCartItem> cartMap = (Map<String, GameCartItem>) session.getAttribute("cartMap_" + type);
		Member member = (Member) session.getAttribute("Member");
		
		
		String gameId = request.getParameter("gameId");
		String guess = request.getParameter("guess");
		String _money = request.getParameter("money");
		
		
		Long money = 0L;
		if (_money != null)
			money = Long.parseLong(_money);
		
		CartCalc cc = getCartCalc(cartMap, money, member.getBalance());		
		Game game = gameDao.selectGame(gameId);
		Double thisRate = 0.0;
		if (guess.equals("W"))
			thisRate = game.getWinRate();
		else if (guess.equals("D"))
			thisRate = game.getDrawRate();
		else if (guess.equals("L"))
			thisRate = game.getLoseRate();
		
		int retCode = 0;
		String message = null;
		
		if (cartMap.size() >= 10 && cartMap.containsKey(gameId) == false) {
			cartMap.remove(game.getId());
			retCode = -1;
			message = "게임은 10개까지 선택 하실 수 있습니다";
		} else if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false ||
				game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT) == false) {
			cartMap.remove(game.getId());
			retCode = -2;
			message = "배팅 가능 상태가 아닙니다";
		} else if ((guess.equals("W") && game.getWinDeny().equals("Y") == false) ||
				(guess.equals("D") && game.getDrawDeny().equals("Y") == false) ||
				(guess.equals("L") && game.getLoseDeny().equals("Y") == false)) {
			cartMap.remove(game.getId());
			retCode = -1;
			message = "배팅 가능 상태가 아닙니다";
		}
		else if ((XwinUtil.calcExpectMoney(thisRate * cc.getRate(), money) + cc.getExpect()) > MAX_EXPECT) {
			cartMap.remove(game.getId());
			retCode = -1;
			message = "배당금이 300만원을 초과 하였습니다";
		} else {
			GameCartItem gci = new GameCartItem();
			gci.setGameId(gameId);
			gci.setHomeTeam(game.getHomeTeam());
			gci.setAwayTeam(game.getAwayTeam());
			if (guess.equals("W"))
				gci.setRate(game.getWinRateStr());
			else if (guess.equals("D"))
				gci.setRate(game.getDrawRateStr());
			else if (guess.equals("L"))
				gci.setRate(game.getLoseRateStr());
			gci.setGuess(guess);
			gci.setLeague(game.getLeagueName());
			
			cartMap.put(gameId, gci);
		}
		
		List<GameCartItem> itemList = new ArrayList<GameCartItem>(cartMap.size());
		itemList.addAll(cartMap.values());
		ResultXml rx = new ResultXml(retCode, message, itemList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		String gameId = request.getParameter("gameId");
		
		HttpSession session = request.getSession();
		Map<String, GameCartItem> cartMap = (Map<String, GameCartItem>) session.getAttribute("cartMap_" + type);
		
		cartMap.remove(gameId);
		
		List<GameCartItem> cartList = new ArrayList<GameCartItem>(cartMap.size());
		cartList.addAll(cartMap.values());
		
		ResultXml rx = new ResultXml(0, null, cartList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView emptyGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		session.removeAttribute("cartMap_" + type);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(new ResultXml(0, null, null)));
		return mv;
	}
	
	private CartCalc getCartCalc(Map<String, GameCartItem> cartMap, Long money, Long memberBalance)
	{
		Double totalRate = 0.0;
		
		Collection<GameCartItem> cartColl = cartMap.values();
		if (cartColl != null && cartColl.size() > 0) {
			totalRate = 1.0;
			for (GameCartItem gci : cartColl) {
				Double rate = Double.parseDouble(gci.getRate());
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
		
		CartCalc cc = new CartCalc();
		
		cc.setRate(cutRate);
		cc.setBalance(balance);
		cc.setMoney(money);
		cc.setAfter(after);
		cc.setExpect(expect);
		
		return cc;
	}
}
