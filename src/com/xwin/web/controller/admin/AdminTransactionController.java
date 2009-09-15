package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Transaction;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminTransactionController extends XwinController
{
	int ROWSIZE = 30;
	
	public ModelAndView viewTransactionList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String isCharge = XwinUtil.arcNvl(request.getParameter("isCharge"));

		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String note = XwinUtil.arcNvl(request.getParameter("note"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search, keyword);
		
		param.put("type", type);
		param.put("isCharge", isCharge);
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		if (note != null && note.equals("Y"))
			param.put("noteIsNotNull", "");
		else if (note != null && note.equals("N"))
			param.put("noteIsNull", "");
			
		
		List<Transaction> transactionList = transactionDao.selectTransactionList(param);
		Integer transactionCount = transactionDao.selectTransactionCount(param);
		Long totalSum = transactionDao.selectTransactionSum(param);
		
		if (totalSum == null)
			totalSum = 0L;
		
		ModelAndView mv = new ModelAndView("admin/account/transaction");
		
		mv.addObject("transactionList", transactionList);
		mv.addObject("totalCount", transactionCount);
		mv.addObject("totalSum", totalSum);
		
		return mv;
	}
	
	public ModelAndView cancelIsCharge(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		Transaction tran = new Transaction();
		tran.setId(id);
		tran.setIsCharge("C");
		tran.setNote("관리자충전");
		
		transactionDao.updateTransaction(tran);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		ResultXml rx = new ResultXml(0, "관리자충전 되었습니다", null);
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
