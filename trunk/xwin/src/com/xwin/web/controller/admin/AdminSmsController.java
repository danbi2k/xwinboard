package com.xwin.web.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.comm.SmsWait;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminSmsController extends XwinController
{
	public ModelAndView viewSendSms(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/sendSms");
		
		return mv;
	}
	
	public ModelAndView sendSms(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String phone = request.getParameter("phone");
		String message = request.getParameter("message");
		String callback = request.getParameter("callback");
		
		SmsWait smsWait = new SmsWait();
		smsWait.setMsg(message);
		smsWait.setPhone(phone);
		smsWait.setCallback(callback);
		
		smsWaitDao.insertSmsWait(smsWait);		
		
		ResultXml rx = new ResultXml(0, "전송되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView sendSmsAllMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String message = request.getParameter("message");
		String callback = request.getParameter("callback");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.USER_STATUS_NORMAL);
		List<Member> memberList = memberDao.selectMemberList(param);
		if (memberList != null) {
			List<String> phoneList = new ArrayList<String>(memberList.size());
			for (Member member : memberList) {
				phoneList.add(member.getMobile().replaceAll("-", ""));
			}
			
			sendSmsConnector.sendSmsList(message, phoneList, callback);
			
		}		
		
		ResultXml rx = new ResultXml(0, "전송되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView searchPhoneNumber(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(search, keyword);
		
		Member member = memberDao.selectMember(param);
		
		String message = "";
		if (member != null)
			message = member.getMobile();		
		
		ResultXml rx = new ResultXml(0, message, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
