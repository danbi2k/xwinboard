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

import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.CartCalc;
import com.xwin.web.command.GameCartItem;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BettingController extends XwinController
{
	public ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		
		String _type = request.getParameter("type");
		String _money = request.getParameter("money");
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("Member");
		
		Map<String, GameCartItem> cartMap =
			(Map<String, GameCartItem>)session.getAttribute("cartMap_" + _type);
		
		Betting betting = new Betting();
		Integer money = Integer.parseInt(_money);		
		CartCalc cc = getCartCalc(cartMap, money, member.getBalance());
		
		if (Integer.parseInt(cc.getAfter()) < 0) {
			rx = new ResultXml(-1, "잔액이 부족합니다.", null);
		} else {		
			betting.setUserId(member.getUserId());
			betting.setMoney(Integer.parseInt(cc.getMoney()));
			betting.setRate(Double.parseDouble(cc.getRate()));
			betting.setExpect(Integer.parseInt(cc.getExpect()));
			betting.setStatus(Code.BET_STATUS_RUN);
			betting.setTotalCount(cartMap.size());
			betting.setDate(new Date());
			
			String bettingId = bettingDao.insertBetting(betting);
			
			Collection<GameCartItem> cartCol = cartMap.values();
			for (GameCartItem gci : cartCol) {
				BetGame betGame = new BetGame();
				betGame.setBettingId(bettingId);
				betGame.setId(gci.getGameId());
				betGame.setGuess(gci.getGuess());
				
				betGameDao.insertBetGame(betGame);
			}
			
			memberDao.updateBalance(member.getUserId(), cc.getAfter());
			
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
		String type = request.getParameter("type");
		String _money = request.getParameter("money");		
		HttpSession session = request.getSession();
		
		Map<String, GameCartItem> cartMap =
			(Map<String, GameCartItem>)session.getAttribute("cartMap_" + type);
		
		Member member = (Member) session.getAttribute("Member");
		
		Integer money = Integer.parseInt(_money);
		
		CartCalc cc = getCartCalc(cartMap, money, member.getBalance());
		
		ResultXml rx = new ResultXml(0, null, cc);		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView createBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Betting betting = new Betting();
		betting.setUserId("xx");
		betting.setRate(4.33);
		betting.setMoney(150000);
		betting.setDate(new Date());
		
		String bettingId = bettingDao.insertBetting(betting);
		
		BetGame betGame = new BetGame();
		betGame.setBettingId(bettingId);
		betGame.setId("1");
		betGame.setGuess("W");
		
		betGameDao.insertBetGame(betGame);
		
		betGame = new BetGame();
		betGame.setBettingId(bettingId);
		betGame.setId("2");
		betGame.setGuess("L");
		
		betGameDao.insertBetGame(betGame);
		
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(new ResultXml(0, null, null)));
		
		return mv;
	}
	
	private CartCalc getCartCalc(Map cartMap, Integer money, Integer memberBalance)
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
		
		Double _expect = Math.floor(cutRate * money);
		Integer expect = _expect.intValue();
		
		Integer balance = memberBalance;
		
		Integer after = balance - expect;
		
		CartCalc cc = new CartCalc();
		
		cc.setRate(XwinUtil.to2Digit(cutRate));
		cc.setBalance(balance.toString());
		cc.setMoney(money.toString());
		cc.setAfter(after.toString());
		cc.setExpect(expect.toString());
		
		return cc;
	}
}
