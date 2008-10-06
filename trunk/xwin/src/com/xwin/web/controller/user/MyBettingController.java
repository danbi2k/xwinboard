package com.xwin.web.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MyBettingController extends XwinController
{
	public ModelAndView viewMyBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("user/my_betting");	
		return mv;
	}
	
	public ModelAndView viewMyBettingDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String bettingId = request.getParameter("bettingId");
		Member member = (Member) request.getSession().getAttribute("Member");
		
		Betting betting =
			bettingDao.selectBettingByUserId(member.getUserId(), bettingId);
		
		ModelAndView mv = new ModelAndView("user/my_betting_detail");
		mv.addObject("betting", betting);
		return mv;
	}
	
	public ModelAndView getMyBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		
		String _pageIndex = request.getParameter("pageIndex");
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String gameType = XwinUtil.arcNvl(request.getParameter("gameType"));
		Integer pageIndex = null;
		try {
			pageIndex = Integer.parseInt(_pageIndex);
		} catch (Exception e) {
			pageIndex = 0;
		}
		List<Betting> bettingList =
			bettingDao.selectBettingListByUserId(member.getUserId(), status, gameType, pageIndex);
		
		ResultXml resultXml = new ResultXml(0, null, bettingList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));		
		return mv;
	}
	
	public ModelAndView getMyBettingDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String bettingId = request.getParameter("bettingId");
		Member member = (Member) request.getSession().getAttribute("Member");
		
		Betting betting =
			bettingDao.selectBettingByUserId(member.getUserId(), bettingId);
		
		ResultXml resultXml = new ResultXml(0, null, betting);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));		
		return mv;
	}
}
