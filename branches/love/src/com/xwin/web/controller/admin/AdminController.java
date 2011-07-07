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
import com.xwin.domain.user.Member;
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
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		Indicator indicator = new Indicator();
		indicator.setCenterIndi(boardDao.selectUnAnsweredQna(Code.USER_GRADE_NORMAL).toString());
		indicator.setVipIndi(boardDao.selectUnAnsweredQna(Code.USER_GRADE_VIP).toString());
		
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_IN_REQUEST);
		param.put("isChecked", "N");
		param.put("grade", Code.USER_GRADE_VIP);
		indicator.setChargingIndi(moneyInDao.selectMoneyInCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_OUT_REQUEST);
		param.put("isChecked", "N");
		param.put("grade", Code.USER_GRADE_VIP);
		indicator.setExchangeIndi(moneyOutDao.selectMoneyOutCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_IN_REQUEST);
		param.put("isChecked", "N");
		param.put("grade", Code.USER_GRADE_OTHER);
		indicator.setDealerChargingIndi(moneyInDao.selectMoneyInCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_OUT_REQUEST);
		param.put("isChecked", "N");
		param.put("grade", Code.USER_GRADE_OTHER);
		indicator.setDealerExchangeIndi(moneyOutDao.selectMoneyOutCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("isChecked", "N");
		indicator.setHackingIndi(hackingLogDao.selectHackingLogCount(param).toString());
		
		indicator.setOverUnderWarn(gameDao.selectOverUnderWarning().toString());
		
//		indicator.setWdlIndi(Admin.SYNC_COUNT_WDL.toString());
//		indicator.setHandyIndi(Admin.SYNC_COUNT_HANDY.toString());
		
		ResultXml rx = new ResultXml(0, null, indicator);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/notice");
		
		return mv;
	}
	
	public ModelAndView saveNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
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
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String grade = request.getParameter("grade");
		if (grade == null)
			grade = Code.USER_GRADE_VIP;
		
		String popup = "";
		String popupFlag = "";
		
		if (grade.equals(Code.USER_GRADE_VIP)) {
			popup = adminDao.selectAdmin("VIP_POPUP");
			popupFlag = adminDao.selectAdmin("VIP_POPUPFLAG");
		} else {
			popup = adminDao.selectAdmin("NOM_POPUP");
			popupFlag = adminDao.selectAdmin("NOM_POPUPFLAG");
		}
		
		ModelAndView mv = new ModelAndView("admin/admin/popup");
		mv.addObject("popup", popup);
		mv.addObject("popupFlag", popupFlag);
		
		return mv;
	}
	
	public ModelAndView savePopup(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String popup = request.getParameter("popup");
		String popupFlag = request.getParameter("popupFlag");
		String grade = request.getParameter("grade");
		
		if (grade.equals(Code.USER_GRADE_VIP)) {
			adminDao.updateAdmin("VIP_POPUP", popup);
			adminDao.updateAdmin("VIP_POPUPFLAG", popupFlag);
		} else {
			adminDao.updateAdmin("NOM_POPUP", popup);
			adminDao.updateAdmin("NOM_POPUPFLAG", popupFlag);
		}
		
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
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		List<BankBook> bankBookList = bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL);
		
		ModelAndView mv = new ModelAndView("admin/admin/admin_bankbook");
		mv.addObject("bankBookList", bankBookList);
		
		return mv;
	}
	
	public ModelAndView saveBankBook(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String bankName = request.getParameter("bankName");
		String name = request.getParameter("name");
		String number = request.getParameter("number");
		String grade = request.getParameter("grade");
		
		BankBook bankBook = new BankBook();
		bankBook.setBankName(bankName);
		bankBook.setName(name);
		bankBook.setNumber(number);
		bankBook.setStatus(Code.BANKBOOK_STATUS_NORMAL);
		bankBook.setGrade(grade);
		
		bankBookDao.insertBankBook(bankBook);
		
		ResultXml rx = new ResultXml(0, "등록되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteBankBook(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
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
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
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
	
	public ModelAndView changeQnaPlay(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String qnaPlay = XwinUtil.arcNvl(request.getParameter("qnaPlay"));
		HttpSession session = request.getSession();
		
		String QNA_PLAY = "on";
		if (qnaPlay == null)
			QNA_PLAY = (String) session.getAttribute("QNA_PLAY");
		else {
			QNA_PLAY = qnaPlay;
			session.setAttribute("QNA_PLAY", qnaPlay);
		}
		
		ResultXml rx = new ResultXml(0, QNA_PLAY, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewMaintanance(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/admin/maintanance");
		
		return mv;
	} 
	
	public ModelAndView deleteMoneyInOutData(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String date = request.getParameter("date");
		maintananceDao.deleteMoneyInData(date);
		maintananceDao.deleteMoneyOutData(date);
		maintananceDao.deleteTransactionData(date);
		
		ResultXml rx = new ResultXml(0, "삭제 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	} 
	
	public ModelAndView deleteAccountData(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String date = request.getParameter("date");
		maintananceDao.deleteAccountData(date);
		maintananceDao.deletePointData(date);
		
		ResultXml rx = new ResultXml(0, "삭제 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	} 
	
	public ModelAndView deleteBettingData(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String date = request.getParameter("date");
		maintananceDao.deleteBetGameData(date);
		maintananceDao.updateBoardWithBetting(date);
		maintananceDao.deleteBettingData(date);
		
		ResultXml rx = new ResultXml(0, "삭제 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
