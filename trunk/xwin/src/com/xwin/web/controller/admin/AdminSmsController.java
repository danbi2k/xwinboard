package com.xwin.web.controller.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminSmsController extends XwinController
{
	public ModelAndView viewSendSms(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/admin/sendSms");
		
		return mv;
	}
	
	public ModelAndView sendSms(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String phone = request.getParameter("phone");
		String message = request.getParameter("message");
		String callback = request.getParameter("callback");
		
		sendSmsConnector.sendSms(message, phone, callback);		
		
		ResultXml rx = new ResultXml(0, "전송되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView sendSmsAllMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String message = request.getParameter("message");
		String callback = request.getParameter("callback");
		
		List<Member> memberList = memberDao.selectMemberList(null);
		if (memberList != null) {
			List<String> phoneList = new ArrayList<String>(memberList.size());
			for (Member member : memberList) {
				phoneList.add(member.getMobile().replaceAll("-", ""));
			}
			
//			List<String> phoneList = new ArrayList<String>(3);
//			phoneList.add("01040139992");
//			phoneList.add("0162611848");
//			phoneList.add("01020699997");
			
			sendSmsConnector.sendSmsList(message, phoneList, callback);
			
		}		
		
		ResultXml rx = new ResultXml(0, "전송되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
