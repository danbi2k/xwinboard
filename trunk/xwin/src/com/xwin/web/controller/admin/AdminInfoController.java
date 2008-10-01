package com.xwin.web.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminInfoController extends XwinController
{
	public ModelAndView viewAdminInfo(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;		
		ModelAndView mv = new ModelAndView("admin/admin_info");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView updateAdminInfo(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		Member admin = (Member) request.getSession().getAttribute("Admin");
		
		admin.setPassword(command.getPassword());
		admin.setNickName(command.getNickName());
		admin.setMobile(command.getMobile());
		admin.setEmail(command.getEmail());
		
		memberDao.updateMember(admin);		
		
		ResultXml rx = new ResultXml(0, "관리자 정보가 변경 되었습니다", null);		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}
