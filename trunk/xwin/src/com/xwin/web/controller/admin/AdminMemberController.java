package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Access;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminMemberController extends XwinController
{
	public static final int ROWSIZE = 20;
	
	public ModelAndView viewAdminMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("grade", grade);
		if (keyword != null) param.put(search, "%" + keyword + "%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		Integer memberCount = memberDao.selectMemberCount(param);
		List<Member> memberList = memberDao.selectMemberList(param);		
		
		ModelAndView mv = new ModelAndView("admin/member/admin_member");
		mv.addObject("memberList", memberList);
		mv.addObject("memberCount", memberCount);
		return mv;
	}
	
	public ModelAndView viewMemberDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String userId = request.getParameter("userId");
				
		Member member = memberDao.selectMember(userId, null);
		
		ModelAndView mv = new ModelAndView("admin/member/admin_member_detail");
		mv.addObject("member", member);
		return mv;
	}
	
	public ModelAndView viewAccessList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Access> accessList = accessDao.selectAccessList(param);
		Integer accessCount = accessDao.selectAccessCount(param);
		ModelAndView mv = new ModelAndView("admin/member/member_access");
		mv.addObject("accessList", accessList);
		mv.addObject("accessCount", accessCount);
		
		return mv;
	}
	
	public ModelAndView updateMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String userId = request.getParameter("userId");
		String status = request.getParameter("status");
		String grade = request.getParameter("grade");
		
		Member member = memberDao.selectMember(userId, null);
		member.setStatus(status);
		member.setGrade(grade);
		
		memberDao.updateMember(member);
		
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
