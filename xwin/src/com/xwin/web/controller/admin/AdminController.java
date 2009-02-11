package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.admin.BankBook;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.Indicator;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminController extends XwinController
{
	public ModelAndView getIndicator(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		Indicator indicator = new Indicator();
		indicator.setCenterIndi(boardDao.selectUnAnsweredQna(Code.USER_GRADE_NORMAL).toString());
		indicator.setVipIndi(boardDao.selectUnAnsweredQna(Code.USER_GRADE_VIP).toString());
		
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_IN_REQUEST);
		param.put("isChecked", "N");
		indicator.setChargingIndi(moneyInDao.selectMoneyInCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_OUT_REQUEST);
		param.put("isChecked", "N");
		indicator.setExchangeIndi(moneyOutDao.selectMoneyOutCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("isChecked", "N");
		indicator.setHackingIndi(hackingLogDao.selectHackingLogCount(param).toString());

		ResultXml rx = new ResultXml(0, null, indicator);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/notice");
		
		return mv;
	}
	
	public ModelAndView saveNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String notice = request.getParameter("notice");
		adminDao.updateAdmin("NOTICE", notice);
		
		Admin.NOTICE = notice;
		
		ResultXml rx = new ResultXml(0, "저장되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");		
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewPopup(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/popup");
		
		return mv;
	}
	
	public ModelAndView savePopup(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String popup = request.getParameter("popup");
		String popupFlag = request.getParameter("popupFlag");
		
		adminDao.updateAdmin("POPUP", popup);
		adminDao.updateAdmin("POPUPFLAG", popupFlag);
		
		Admin.POPUP = popup;
		Admin.POPUPFLAG = popupFlag;
		
		ResultXml rx = new ResultXml(0, "저장되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");		
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewBankBookList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		List<BankBook> bankBookList = bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL);
		
		ModelAndView mv = new ModelAndView("admin/admin/admin_bankbook");
		mv.addObject("bankBookList", bankBookList);
		
		return mv;
	}
	
	public ModelAndView saveBankBook(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String bankName = request.getParameter("bankName");
		String name = request.getParameter("name");
		String number = request.getParameter("number");
		
		BankBook bankBook = new BankBook();
		bankBook.setBankName(bankName);
		bankBook.setName(name);
		bankBook.setNumber(number);
		bankBook.setStatus(Code.BANKBOOK_STATUS_NORMAL);
		
		bankBookDao.insertBankBook(bankBook);
		
		ResultXml rx = new ResultXml(0, "등록되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteBankBook(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String[] id = request.getParameterValues("id");
		
		BankBook bankBook = new BankBook();
		bankBook.setStatus(Code.BANKBOOK_STATUS_UNUSED);
		
		for (int i = 0 ; i < id.length ; i++) {
			bankBook.setId(id[i]);
			bankBookDao.updateBankBook(bankBook);
		}
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView changeExPlay(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String exPlay = XwinUtil.arcNvl(request.getParameter("exPlay"));
		HttpSession session = request.getSession();
		
		String EX_PLAY = "on";
		if (exPlay == null)
			EX_PLAY = (String) session.getAttribute("EX_PLAY");
		else {
			EX_PLAY = exPlay;
			session.setAttribute("EX_PLAY", exPlay);
		}
		
		ResultXml rx = new ResultXml(0, EX_PLAY, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
