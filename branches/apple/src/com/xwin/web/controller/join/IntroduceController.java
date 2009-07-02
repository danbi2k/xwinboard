package com.xwin.web.controller.join;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.SiteConfig;
import com.xwin.domain.comm.SmsWait;
import com.xwin.domain.game.Betting;
import com.xwin.domain.join.Invitation;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class IntroduceController extends XwinController
{
	public static final int ROWSIZE = 15;
	public static final List<String> statusList = new ArrayList<String>(2);
	
	static {
		statusList.add(Code.BET_STATUS_SUCCESS);
		statusList.add(Code.BET_STATUS_FAILURE);
	}
	
	public ModelAndView viewIntroduceForm(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("introducerId", member.getUserId());
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("statusList", statusList);
		
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		Integer bettingCount = bettingDao.selectBettingCount(param);
		
		param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("joinIdNull", "");
		Integer noJoinCount = invitationDao.selectInvitationCount(param);
		
		ModelAndView mv = new ModelAndView("join/introduce");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		mv.addObject("noJoinCount", noJoinCount);
		
		return mv;
	}
	
	public ModelAndView introduce(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		if (member.getIntroLetter() <= 0) {
			rx = new ResultXml(-1, "초대장 수가 부족합니다", null);
		} else {		
			String mobile = request.getParameter("mobile");
			
			String inviteKey = RandomStringUtils.randomAlphanumeric(5).toUpperCase();
			String userId = member.getUserId();
			
			Invitation invitation = new Invitation();
			invitation.setInviteKey(inviteKey);
			invitation.setUserId(userId);
			invitation.setSendDate(new Date());
			invitation.setMobile(mobile);
			
			invitationDao.insertInvitation(invitation);
			
			SmsWait smsWait = new SmsWait();
			smsWait.setPhone(mobile);
			smsWait.setCallback(member.getMobile());
			
			//smsWait.setMsg(inviteKey + " " + userId);
			//smsWaitDao.insertSmsWait(smsWait);
			
			smsWait.setMsg("[추천] http://" + SiteConfig.SITE_DOMAIN + "\n소개인ID : " + userId + "\n초대장 : " + inviteKey);
			smsWaitDao.insertSmsWait(smsWait);		
			
			member.setIntroLetter(member.getIntroLetter()-1);
			memberDao.updateMember(member);
			
			rx = new ResultXml(0, "초대장이 발송 되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));		
		return mv;
	}
	
	public ModelAndView introduceDetail(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("introducerId", member.getUserId());
		param.put("orderCol", "ID");
		param.put("orderBy", "DESC");
		List<Member> invitationList = memberDao.selectMemberList(param);	
		
		ModelAndView mv = new ModelAndView("join/introduceDetail");
		mv.addObject("invitationList", invitationList);	
		
		return mv;
	}
	
	public ModelAndView noJoinDetail(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("joinIdNull", "");
		List<Invitation> noJoinList = invitationDao.selectInvitationList(param);
		
		ModelAndView mv = new ModelAndView("join/noJoinDetail");
		mv.addObject("noJoinList", noJoinList);	
		
		return mv;
	}
}
