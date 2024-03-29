package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminInfoController extends XwinController
{
	public ModelAndView viewAdminInfo(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/admin_info");
		return mv;
	}
	
	public ModelAndView updateAdminInfo(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		Member admin = (Member) request.getSession().getAttribute("Admin");
		
		admin.setPassword(command.getPassword());
		admin.setPin(command.getPin());
		admin.setNickName(command.getNickName());
		admin.setMobile(command.getMobile());
		admin.setEmail(command.getEmail());
		
		memberDao.updateMember(admin);
		
		Admin.ADMIN_EMAIL = admin.getEmail();
		
		ResultXml rx = new ResultXml(0, "관리자 정보가 변경 되었습니다", null);		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView viewSecurity(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("passwordExpire", "Y");
		param.put("satus", Code.USER_STATUS_NORMAL);
		Integer remainCount = memberDao.selectMemberCount(param);
		
		param.put("passwordExpire", "C");
		Integer changeCount = memberDao.selectMemberCount(param);
		
		ModelAndView mv = new ModelAndView("admin/admin/admin_security");
		mv.addObject("remainCount", remainCount);
		mv.addObject("changeCount", changeCount);
		
		return mv;
	}
	
	public ModelAndView changeSecurity(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String DENY_JOIN = request.getParameter("DENY_JOIN");
		String DENY_BOARD = request.getParameter("DENY_BOARD");
		String DENY_QNA = request.getParameter("DENY_QNA");
		String DENY_CHARGE = request.getParameter("DENY_CHARGE");
		String DENY_EXCHANGE = request.getParameter("DENY_EXCHANGE");
		
		adminDao.updateAdmin("DENY_JOIN", DENY_JOIN);
		adminDao.updateAdmin("DENY_BOARD", DENY_BOARD);
		adminDao.updateAdmin("DENY_QNA", DENY_QNA);
		adminDao.updateAdmin("DENY_CHARGE", DENY_CHARGE);
		adminDao.updateAdmin("DENY_EXCHANGE", DENY_EXCHANGE);
		
		Admin.DENY_JOIN = DENY_JOIN;
		Admin.DENY_BOARD = DENY_BOARD;
		Admin.DENY_QNA = DENY_QNA;
		Admin.DENY_CHARGE = DENY_CHARGE;
		Admin.DENY_EXCHANGE = DENY_EXCHANGE;
		
		
		
		ResultXml rx = new ResultXml(0, "변경 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView requestChangePassword(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		Member member = new Member();
		member.setPasswordExpire("Y");
		member.setStatus(Code.USER_STATUS_NORMAL);
		
		memberDao.updateMemberPasswordExpire(member);
		
		ResultXml rx = new ResultXml(0, "요청 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView viewBonus(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/admin_bonus");
		return mv;
	}
	
	public ModelAndView changeBonus(HttpServletRequest request, 
			HttpServletResponse response, Member command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String HANDY_BONUS_USE = request.getParameter("HANDY_BONUS_USE");
		String HANDY_BONUS_LIMIT = request.getParameter("HANDY_BONUS_LIMIT");
		String HANDY_BONUS_RATE = request.getParameter("HANDY_BONUS_RATE");

		String WDL_BONUS_USE = request.getParameter("WDL_BONUS_USE");
		String WDL_BONUS_LIMIT = request.getParameter("WDL_BONUS_LIMIT");
		String WDL_BONUS_RATE = request.getParameter("WDL_BONUS_RATE");
		
		String MIX_BONUS_USE = request.getParameter("MIX_BONUS_USE");
		String MIX_BONUS_LIMIT = request.getParameter("MIX_BONUS_LIMIT");
		String MIX_BONUS_RATE = request.getParameter("MIX_BONUS_RATE");
		
		String BETTING_POINT_USE = request.getParameter("BETTING_POINT_USE");
		String BETTING_POINT_RATE = request.getParameter("BETTING_POINT_RATE");
		
		ResultXml rx = null;
		
		try {
			Admin.HANDY_BONUS_USE = HANDY_BONUS_USE.equals("Y");
			Admin.HANDY_BONUS_LIMIT = Integer.parseInt(HANDY_BONUS_LIMIT.trim());
			Admin.HANDY_BONUS_RATE = Integer.parseInt(HANDY_BONUS_RATE.trim());
			
			Admin.WDL_BONUS_USE = WDL_BONUS_USE.equals("Y");
			Admin.WDL_BONUS_LIMIT = Integer.parseInt(WDL_BONUS_LIMIT.trim());
			Admin.WDL_BONUS_RATE = Integer.parseInt(WDL_BONUS_RATE.trim());
			
			Admin.MIX_BONUS_USE = MIX_BONUS_USE.equals("Y");
			Admin.MIX_BONUS_LIMIT = Integer.parseInt(MIX_BONUS_LIMIT.trim());
			Admin.MIX_BONUS_RATE = Integer.parseInt(MIX_BONUS_RATE.trim());
			
			Admin.BETTING_POINT_USE = BETTING_POINT_USE.equals("Y");
			Admin.BETTING_POINT_RATE = Integer.parseInt(BETTING_POINT_RATE.trim());
			
			adminDao.updateAdmin("HANDY_BONUS_USE", HANDY_BONUS_USE);
			adminDao.updateAdmin("HANDY_BONUS_LIMIT", HANDY_BONUS_LIMIT);
			adminDao.updateAdmin("HANDY_BONUS_RATE", HANDY_BONUS_RATE);
			
			adminDao.updateAdmin("WDL_BONUS_USE", WDL_BONUS_USE);
			adminDao.updateAdmin("WDL_BONUS_LIMIT", WDL_BONUS_LIMIT);
			adminDao.updateAdmin("WDL_BONUS_RATE", WDL_BONUS_RATE);
			
			adminDao.updateAdmin("MIX_BONUS_USE", MIX_BONUS_USE);
			adminDao.updateAdmin("MIX_BONUS_LIMIT", MIX_BONUS_LIMIT);
			adminDao.updateAdmin("MIX_BONUS_RATE", MIX_BONUS_RATE);
			
			adminDao.updateAdmin("BETTING_POINT_USE", BETTING_POINT_USE);
			adminDao.updateAdmin("BETTING_POINT_RATE", BETTING_POINT_RATE);
			
			rx = new ResultXml(0, "변경 되었습니다", null);
		} catch (Exception e) {
			rx = new ResultXml(0, "숫자를 입력하세요", null);
		}		
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}
