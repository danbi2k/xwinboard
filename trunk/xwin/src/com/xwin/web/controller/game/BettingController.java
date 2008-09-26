package com.xwin.web.controller.game;

import java.util.Collection;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
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
		String _type = request.getParameter("type");
		String _bet = request.getParameter("bet");
		HttpSession session = request.getSession();
		
		Map<String, GameCartItem> cartMap =
			(Map<String, GameCartItem>)session.getAttribute("cartMap_" + _type);
		
		Integer bet = null;
		if (_bet != null && _bet.length() > 0)
			bet = Integer.parseInt(_bet);
		else
			bet = 0;
		
		CartCalc cc = getCartCalc(cartMap, bet);
		
		
		
		//CartCalc cc= getCartCalc(_rate, _bet);
		
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		//mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView calculateCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		String _bet = request.getParameter("bet");		
		HttpSession session = request.getSession();
		
		Map<String, GameCartItem> cartMap =
			(Map<String, GameCartItem>)session.getAttribute("cartMap_" + type);
		
		Integer bet = null;
		if (_bet != null && _bet.length() > 0)
			bet = Integer.parseInt(_bet);
		else
			bet = 0;
		
		CartCalc cc = getCartCalc(cartMap, bet);
		
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

	private CartCalc getCartCalc(Map cartMap, Integer bet)
	{
		Double totalRate = 1.0;
		
		Collection<GameCartItem> cartColl = cartMap.values();
		for (GameCartItem gci : cartColl) {
			Double rate = Double.parseDouble(gci.getRate());
			totalRate *= rate;
		}
		
		Double cutRate = XwinUtil.doubleCut(totalRate);
		
		Double _expect = Math.floor(cutRate * bet);
		Integer expect = _expect.intValue();
		
		Member member = memberDao.selectMember("xx");
		Integer balance = member.getBalance();
		
		Integer after = balance - expect;
		
		CartCalc cc = new CartCalc();
		
		cc.setRate(XwinUtil.to2Digit(cutRate));
		cc.setBalance(balance.toString());
		cc.setBet(bet.toString());
		cc.setAfter(after.toString());
		cc.setExpect(expect.toString());
		
		return cc;
	}
}
