package com.xwin.web.controller.game;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BettingCart;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BettingCartController extends XwinController
{
	public ModelAndView viewBettingCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		BettingCart bettingCart = (BettingCart) request.getSession().getAttribute("BettingCart");
		
		ModelAndView mv = new ModelAndView("game/betting_cart");
		mv.addObject(bettingCart);
		
		return mv;
	}
	
	public ModelAndView deleteGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String _folderIndex = request.getParameter("folderIndex");
		Integer folderIndex = Integer.parseInt(_folderIndex);
		
		BettingCart bettingCart = (BettingCart) request.getSession().getAttribute("BettingCart");
		bettingCart.remove(folderIndex);
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteAllGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		BettingCart bettingCart = (BettingCart) request.getSession().getAttribute("BettingCart");
		bettingCart.clear();
		
		ResultXml rx = new ResultXml(0, "전체 삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		member = memberDao.selectMember(member.getUserId(), null);
		
		String[] folderIndex = request.getParameterValues("folderIndex");		
		BettingCart bettingCart = (BettingCart) request.getSession().getAttribute("BettingCart");
		
		List<GameFolder> selectList = new ArrayList<GameFolder>();
		for (int i = 0 ; i < folderIndex.length ; i++) {
			int index = Integer.parseInt(folderIndex[i]);
			GameFolder gameFolder = bettingCart.get(index);
			selectList.add(gameFolder);
		}
		
		ResultXml rx = null; 
		boolean keepGoing = true;
		Long sum = 0L;
		for (GameFolder gameFolder : selectList) {
			if (bettingService.checkBettingAccept(gameFolder) == false) {
				bettingCart.remove(gameFolder);
				keepGoing = false;
			}
			
			sum += gameFolder.getMoney();
		}
		
		if (keepGoing == false) {
			rx = new ResultXml(0, "배팅이 불가능한 내역이 있습니다.\n해당 내역은 배팅카트에서 자동 삭제됩니다.", null);
		} else if (member.getBalance() - sum < 0) {
			rx = new ResultXml(0, "잔액이 부족합니다.", null);
		} else {
			for (GameFolder gameFolder : selectList) {
				bettingService.processBetting(gameFolder, member);
				bettingCart.remove(gameFolder);
			}
			
			rx = new ResultXml(0, "배팅 하셨습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
