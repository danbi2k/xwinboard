package com.xwin.web.controller.external;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Transaction;
import com.xwin.domain.comm.SmsWait;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.League;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class ExternalController extends XwinController
{
	public ModelAndView setTransaction(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String xml = request.getParameter("transactionList");
		
		List<Transaction> transactionList = (List<Transaction>) XmlUtil.fromXml(xml);
		
		if (transactionList != null) {
			for (Transaction transaction : transactionList) {
				try {
					transactionDao.insertTransaction(transaction);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(ResultXml.SUCCESS));
		
		return mv;
	}
	
	public ModelAndView getSmsWaitList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<SmsWait> smsWaitList = smsWaitDao.selectSmsWaitList();
		
		if (smsWaitList != null && smsWaitList.size() > 0) {
			SmsWait smsWait = smsWaitList.get(0);
			smsWaitDao.deleteSmsWaitList(smsWait.getId());
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(smsWaitList));
		
		return mv;
	}
	

	
	public ModelAndView getAllNormalPhoneNumber(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.USER_STATUS_NORMAL);
		List<Member> memberList = memberDao.selectMemberList(param);
		List<String> phoneList = new ArrayList<String>(memberList.size());
		if (memberList != null) {
			for (Member member : memberList) {
				phoneList.add(member.getMobile().replaceAll("-", ""));
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(phoneList));
		
		return mv;
	}
	
	public ModelAndView getGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		param.put("fromDate", new Date());
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(gameList));
		
		return mv;
	}
	
	public ModelAndView getLeagueList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(leagueList));
		
		return mv;
	}
}
