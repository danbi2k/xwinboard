package com.xwin.web.controller.join;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.comm.SmsWait;
import com.xwin.domain.join.Invitation;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class IntroduceController extends XwinController
{
	public ModelAndView viewIntroduceForm(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		
		if (member == null)
			return new ModelAndView("dummy");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member);
		param.put("joinId", "");
		//invitationDao.selectInvitationCount(param);
		
		ModelAndView mv = new ModelAndView("join/introduce");		
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
			rx = new ResultXml(-1, "추천장 수가 부족합니다", null);
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
			
			smsWait.setMsg("[추천] http://no1bet.net" + "\n추천인ID : " + userId + "\n추천장 : " + inviteKey);
			smsWaitDao.insertSmsWait(smsWait);		
			
			member.setIntroLetter(member.getIntroLetter()-1);
			memberDao.updateMember(member);
			
			rx = new ResultXml(0, "추천장이 발송 되었습니다", null);
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
		param.put("userId", member.getUserId());
		param.put("joinId", "");
		
		List<Invitation> invitationList = invitationDao.selectInvitationList(param);
		
		ModelAndView mv = new ModelAndView("join/introduceDetail");
		mv.addObject("invitationList", invitationList);	
		
		return mv;
	}
}
