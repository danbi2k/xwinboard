package com.xwin.web.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Point;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MyMoneyController extends XwinController
{
	int ROWSIZE = 15;
	
	public ModelAndView viewMyMoneyList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("userId", member.getUserId());
		param.put("isDeleted", "N");
		
		List<Account> accountList = accountDao.selectAccountList(param);
		Integer accountCount = accountDao.selectAccountCount(param);
		
		ModelAndView mv = new ModelAndView("user/my_money");
		mv.addObject("accountList", accountList);
		mv.addObject("accountCount", accountCount);
		return mv;
	}
	
	public ModelAndView deleteMyMoneyLog(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String id = request.getParameter("id");
		
		Account account = new Account();
		account.setId(id);
		account.setIsDeleted("Y");
		accountDao.updateAccount(account);
		
		ResultXml rx = new ResultXml(0, "sudah di hapus", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewMyPointList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("userId", member.getUserId());
		param.put("isDeleted", "N");
		
		List<Point> pointList = pointDao.selectPointList(param);
		Integer pointCount = pointDao.selectPointCount(param);
		
		ModelAndView mv = new ModelAndView("user/my_point");
		mv.addObject("pointList", pointList);
		mv.addObject("pointCount", pointCount);
		return mv;
	}
}
