package com.xwin.web.controller.admin;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.statistics.DealerSummary;
import com.xwin.domain.user.Dealer;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminDealerController extends XwinController
{
	public static final int ROWSIZE = 30;
	
	public ModelAndView viewAdminDealer(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.DEALER_STATUS_NORMAL);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		Integer dealerCount = dealerDao.selectDealerCount(param);
		List<Dealer> dealerList = dealerDao.selectDealerList(param);
		
		ModelAndView mv = new ModelAndView("admin/dealer/admin_dealer");
		mv.addObject("dealerList", dealerList);
		mv.addObject("dealerCount", dealerCount);
		return mv;
	}
	
	public ModelAndView viewRegisterDealerForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/dealer/register_dealer");
		return mv;
	}
	
	public ModelAndView registerDealer(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String dealerId = request.getParameter("dealerId");
		String password = request.getParameter("password");
		
		String bankName = XwinUtil.nvl(request.getParameter("bankName"));
		String bankNumber = XwinUtil.nvl(request.getParameter("bankNumber"));
		String bankOwner = XwinUtil.nvl(request.getParameter("bankOwner"));
		
		
		if (dealerId != null && password != null)
		{
			Dealer dealer = new Dealer();
			dealer.setDealerId(dealerId.trim());
			dealer.setPassword(XwinUtil.getUserPassword(password));
			dealer.setJoinDate(new Date());
			dealer.setStatus(Code.DEALER_STATUS_NORMAL);
			
			dealer.setBankName(bankName);
			dealer.setBankNumber(bankNumber);
			dealer.setBankOwner(bankOwner);
			
			dealerDao.insertDealer(dealer);
		}
		
		ModelAndView mv = new ModelAndView("redirect:adminDealer.aspx?mode=viewAdminDealer");
		return mv;
	}
	
	public ModelAndView viewDealerDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String dealerId = request.getParameter("dealerId");
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealerId);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		Dealer dealer = dealerDao.selectDealer(dealerId);		
		
		ModelAndView mv = new ModelAndView("admin/dealer/admin_dealer_detail");
		mv.addObject("dealer", dealer);
		
		return mv;
	}
	
	public ModelAndView checkExistDealerId(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String dealerId = request.getParameter("dealerId");
		ResultXml rx = null;
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealerId.trim());
		int count = dealerDao.selectDealerCount(param);
		
		if (count > 0)
			rx = new ResultXml(-1, "이미 등록된 총판 아이디 입니다", null);
		else
			rx = ResultXml.SUCCESS;
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewDealerSummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String dealerId = request.getParameter("dealerId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		Calendar cal = Calendar.getInstance();
		if (year == null)
			year = "" + cal.get(Calendar.YEAR);
		
		if (month == null)
			month = String.format("%02d", cal.get(Calendar.MONTH) + 1);

		Date[] monthPair = XwinUtil.getMonthPair(year + "-" + month);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealerId);
		param.put("fromDate", monthPair[0]);
		param.put("toDate", monthPair[1]);		
		List<DealerSummary> dealerSummaryList = bettingDao.selectDealerSummary(param);
		
		ModelAndView mv = new ModelAndView("admin/dealer/admin_dealer_summary");
		mv.addObject("dealerSummaryList", dealerSummaryList);
		return mv;
	}	
}
