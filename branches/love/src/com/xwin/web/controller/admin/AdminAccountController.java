package com.xwin.web.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.SiteConfig;
import com.xwin.domain.admin.Account;
import com.xwin.domain.comm.SmsWait;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.domain.user.MoneyInOut;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminAccountController extends XwinController implements MessageSourceAware
{
	int ROWSIZE = 30;
	
	public ModelAndView viewMoneyInList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		
		String dateType = XwinUtil.nvl(request.getParameter("dateType"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search + "Like", "%" + keyword + "%");
		
		if (status != null && status.equals(Code.MONEY_IN_REQUEST)) {
			List<String> statusList = new ArrayList<String>(5);
			statusList.add(Code.MONEY_IN_REQUEST);
			statusList.add(Code.MONEY_IN_CANCEL);
			statusList.add(Code.MONEY_IN_CANCEL_TIMEOUT);
			param.put("statusList", statusList);
		} else {
			param.put("status", status);
		}
		
		param.put("grade", grade);
		
		if (dateType.equals("req")) {
			param.put("fromReqDate", XwinUtil.toDate(fromDate));
			param.put("toReqDate", XwinUtil.toDateFullTime(toDate));
		} else if (dateType.equals("proc")) {
			param.put("fromProcDate", XwinUtil.toDate(fromDate));
			param.put("toProcDate", XwinUtil.toDateFullTime(toDate));
		}
			
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("isDeleted", "N");
		
		List<MoneyIn> moneyInList = moneyInDao.selectMoneyInList(param);
		Integer moneyInCount = moneyInDao.selectMoneyInCount(param);
		Long totalSum = moneyInDao.selectMoneyInSum(param);
		
		if (totalSum == null)
			totalSum = 0L;
		
		ModelAndView mv = null;
		if (status.equals(Code.MONEY_IN_REQUEST))
			mv = new ModelAndView("admin/account/money_in_req");
		else if (status.equals(Code.MONEY_IN_SUCCESS))
			mv = new ModelAndView("admin/account/money_in");
		else if (status.equals(Code.MONEY_IN_DIRECT))
			mv = new ModelAndView("admin/account/money_direct");
		mv.addObject("moneyInOutList", moneyInList);
		mv.addObject("totalCount", moneyInCount);
		mv.addObject("totalSum", totalSum);
		
		return mv;
	}
	
	public ModelAndView viewMoneyOutList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		int ROWSIZE = 50;
		
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		
		String dateType = XwinUtil.nvl(request.getParameter("dateType"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search + "Like", "%" + keyword + "%");
		param.put("status", status);
		param.put("grade", grade);
		
		if (dateType.equals("req")) {
			param.put("fromReqDate", XwinUtil.toDate(fromDate));
			param.put("toReqDate", XwinUtil.toDateFullTime(toDate));
		} else if (dateType.equals("proc")) {
			param.put("fromProcDate", XwinUtil.toDate(fromDate));
			param.put("toProcDate", XwinUtil.toDateFullTime(toDate));
		}
		
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("isDeleted", "N");
		
		List<MoneyOut> moneyOutList = moneyOutDao.selectMoneyOutList(param);
		Integer moneyOutCount = moneyOutDao.selectMoneyOutCount(param);
		Long totalSum = moneyOutDao.selectMoneyOutSum(param);
		
		if (totalSum == null)
			totalSum = 0L;
		
		ModelAndView mv = null;
		if (status.equals(Code.MONEY_OUT_REQUEST))
			mv = new ModelAndView("admin/account/money_out_req");
		else if (status.equals(Code.MONEY_OUT_SUCCESS))
			mv = new ModelAndView("admin/account/money_out");
		else if (status.equals(Code.MONEY_OUT_DIRECT))
			mv = new ModelAndView("admin/account/money_direct");
		mv.addObject("moneyInOutList", moneyOutList);
		mv.addObject("totalCount", moneyOutCount);
		mv.addObject("totalSum", totalSum);
		
		return mv;
	}
	
	public ModelAndView viewMoneyInOutList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		
		String dateType = XwinUtil.nvl(request.getParameter("dateType"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search + "Like", "%" + keyword + "%");
		param.put("statusLike", "%"+status);
		
		param.put("grade", grade);
		
		if (dateType.equals("req")) {
			param.put("fromReqDate", XwinUtil.toDate(fromDate));
			param.put("toReqDate", XwinUtil.toDateFullTime(toDate));
		} else if (dateType.equals("proc")) {
			param.put("fromProcDate", XwinUtil.toDate(fromDate));
			param.put("toProcDate", XwinUtil.toDateFullTime(toDate));
		}
		
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("isDeleted", "N");
		
		List<MoneyInOut> moneyInOutList = moneyInOutDao.selectMoneyInOutList(param);
		Integer moneyInOutCount = moneyInOutDao.selectMoneyInOutCount(param);
		Long totalSum = 0L;
		if (status.contains("004"))
			totalSum = XwinUtil.ntz(moneyInOutDao.selectMoneyInSum(param)) + XwinUtil.ntz(moneyInOutDao.selectMoneyOutSum(param));
		else
			totalSum = XwinUtil.ntz(moneyInOutDao.selectMoneyInSum(param)) - XwinUtil.ntz(moneyInOutDao.selectMoneyOutSum(param));
		if (totalSum == null)
			totalSum = 0L;
		
		Integer n = (Integer) session.getAttribute("(Admin)");
		if (n != null) {
			totalSum = totalSum * n / 100L;
		}
		
		ModelAndView mv = null;
		if (status.contains("002"))
			mv = new ModelAndView("admin/account/money_in_out");
		else if (status.contains("004"))
			mv = new ModelAndView("admin/account/money_direct");
		mv.addObject("moneyInOutList", moneyInOutList);
		mv.addObject("totalCount", moneyInOutCount);
		mv.addObject("totalSum", totalSum);
		
		return mv;
	}
	
	public ModelAndView viewMoneyCalculation(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/account/money_calculation");
		return mv;
	}
	

	public ModelAndView acceptMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		String id = request.getParameter("id");
		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
			Member member = memberDao.selectMember(moneyIn.getUserId(), null);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYIN);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyIn.getMoney());
			account.setBalance(member.getBalance() + moneyIn.getMoney());
			account.setMoneyInId(moneyIn.getId());
			
			moneyIn.setStatus(Code.MONEY_IN_SUCCESS);
			moneyIn.setProcDate(new Date());
			
			accountDao.insertAccount(account);		
			memberDao.plusMinusBalance(member.getUserId(), moneyIn.getMoney());
			moneyInDao.updateMoneyIn(moneyIn);
			
			//포인트 지급
//			Double point = moneyIn.getMoney() * 0.05;			
//			memberDao.plusMinusPoint(member.getUserId(), point.longValue());
//			
//			Point pointLog = new Point();
//			pointLog.setUserId(member.getUserId());
//			pointLog.setType(Code.POINT_TYPE_MONEYIN);
//			pointLog.setDate(new Date());
//			pointLog.setOldBalance(member.getPoint());
//			pointLog.setMoney(point.longValue());
//			pointLog.setBalance(member.getPoint() + point.longValue());
//			pointLog.setMoneyInId(moneyIn.getId());
//			
//			pointDao.insertPoint(pointLog);
			
			/*
			String nickName = member.getNickName();
			String mobile = member.getMobile().replaceAll("-", "");
			String message = "[" + SiteConfig.SITE_NAME + "]" + nickName + " 님께 " + XwinUtil.comma3(moneyIn.getMoney()) + "원이 충전 되었습니다.";
			try {
				sendSmsConnector.sendSms(message, mobile, SiteConfig.SITE_PHONE);
			} catch (Exception e) {
				e.printStackTrace();
			}
			*/
			rx = new ResultXml(0, "충전되었습니다", null);
		} else {
			rx = new ResultXml(0, "충전요청 상태가 아닙니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
	
	public ModelAndView acceptMoneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		String id = request.getParameter("id");
		
		MoneyOut moneyOut = moneyOutDao.selectMoneyOut(id);
		if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST)) {			
			moneyOut.setStatus(Code.MONEY_OUT_SUCCESS);
			moneyOut.setProcDate(new Date());
			moneyOutDao.updateMoneyOut(moneyOut);
			
			Member member = memberDao.selectMember(moneyOut.getUserId(), null);
			
			if (member.getGetSms().equals("Y")) {
				String nickName = member.getNickName();
				String mobile = member.getMobile().replaceAll("-", "");
				String message = msgSrc.getMessage("SMS_EXCHANGE",
						new Object[]{SiteConfig.SITE_NICKSHORT, nickName, XwinUtil.comma3(moneyOut.getMoney())},
						SiteConfig.SITE_LOCALE);
				
				SmsWait smsWait = new SmsWait();
				smsWait.setMsg(message);
				smsWait.setPhone(mobile);
				smsWait.setCallback(SiteConfig.SITE_PHONE);
				
				smsWaitDao.insertSmsWait(smsWait);
			}
		
			rx = new ResultXml(0, "환전되었습니다", null);
		} else {
			rx = new ResultXml(0, "환전요청 상태가 아닙니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;	
	}
	
	public ModelAndView directCharging(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String _money = request.getParameter("money");
		String note = request.getParameter("note");
		
		Long money = null;
		try {
			money = Long.parseLong(_money);
		} catch (Exception e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
		if (money != null) {
			Member member = memberDao.selectMember(userId, null);
			
			MoneyIn moneyIn = new MoneyIn();
			moneyIn.setMoney(money);
			moneyIn.setProcDate(new Date());
			moneyIn.setStatus(Code.MONEY_IN_DIRECT);
			moneyIn.setGrade(member.getGrade());
			moneyIn.setUserId(userId);
			moneyIn.setNickName(member.getNickName());
			moneyIn.setNote(note);
			moneyIn.setSource(Code.SOURCE_WEB);
			moneyIn.setBankName("");
			moneyIn.setName("");
			moneyIn.setNumber("");
			moneyInDao.insertMoneyIn(moneyIn);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYIN_DIRECT);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(money);
			account.setBalance(member.getBalance() + money);
			account.setMoneyInId(moneyIn.getId());
			account.setNote(note);
			
			accountDao.insertAccount(account);
			
			memberDao.plusMinusBalance(userId, money);
			rx = new ResultXml(0, "직충전 되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
	
	public ModelAndView directMinusCharging(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String _money = request.getParameter("money");
		String note = request.getParameter("note");
		
		Long money = null;
		try {
			money = Long.parseLong(_money);
		} catch (Exception e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
		if (money != null) {
			Member member = memberDao.selectMember(userId, null);
			
			if (member.getBalance() < money) {
				rx = new ResultXml(-1, "잔액을 초과하였습니다", null);
			} 
			else {
				MoneyOut moneyOut = new MoneyOut();
				moneyOut.setMoney(money);
				moneyOut.setProcDate(new Date());
				moneyOut.setStatus(Code.MONEY_OUT_DIRECT);
				moneyOut.setGrade(member.getGrade());
				moneyOut.setUserId(userId);
				moneyOut.setNickName(member.getNickName());
				moneyOut.setNote(note);
				moneyOut.setSource(Code.SOURCE_WEB);
				moneyOut.setBankName("");
				moneyOut.setName("");
				moneyOut.setNumber("");
				moneyOutDao.insertMoneyOut(moneyOut);
				
				Account account = new Account();
				account.setUserId(member.getUserId());
				account.setType(Code.ACCOUNT_TYPE_MONEYOUT_DIRECT);
				account.setDate(new Date());
				account.setOldBalance(member.getBalance());
				account.setMoney(money * -1);
				account.setBalance(member.getBalance() - money);
				account.setMoneyInId(moneyOut.getId());
				
				accountDao.insertAccount(account);
				
				memberDao.plusMinusBalance(userId, money * -1);
				rx = new ResultXml(0, "직차감 되었습니다", null);
			}
		}	
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
	
	public ModelAndView deleteMoneyInList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String[] id = request.getParameterValues("id");
		
		if (id != null) {
			for (int i = 0 ; i < id.length ; i++)
				moneyInDao.deleteMoneyIn(id[i]);
		}
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView deleteMoneyOutList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String[] id = request.getParameterValues("id");
		
		if (id != null) {
			for (int i = 0 ; i < id.length ; i++)
				moneyOutDao.deleteMoneyOut(id[i]);
		}
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView saveMoneyInIsChecked(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String isChecked = request.getParameter("isChecked");
		
		MoneyIn moneyIn = new MoneyIn();
		moneyIn.setId(id);
		moneyIn.setIsChecked(isChecked);
		
		moneyInDao.updateMoneyIn(moneyIn);
		
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView saveMoneyOutIsChecked(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String isChecked = request.getParameter("isChecked");
		
		MoneyOut moneyOut = new MoneyOut();
		moneyOut.setId(id);
		moneyOut.setIsChecked(isChecked);
		
		moneyOutDao.updateMoneyOut(moneyOut);
		
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView cancelMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST) == false)
			rx = new ResultXml(0, "충전요청 상태가 아닙니다", null);
		else {
			moneyIn.setStatus(Code.MONEY_IN_CANCEL);
			moneyIn.setProcDate(new Date());
			moneyInDao.updateMoneyIn(moneyIn);			
			rx = new ResultXml(0, "충전 신청이 취소되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView cancelMoneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");
		MoneyOut moneyOut = moneyOutDao.selectMoneyOut(id);		
		if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST) == false)
			rx = new ResultXml(0, "환전요청 상태가 아닙니다", null);
		else {
			Member member = memberDao.selectMember(moneyOut.getUserId(), null);
			
			moneyOut.setStatus(Code.MONEY_OUT_CANCEL);
			moneyOut.setProcDate(new Date());
			moneyOutDao.updateMoneyOut(moneyOut);			
			rx = new ResultXml(0, "환전 신청이 취소되었습니다", null);
			
			Account account = new Account();
			account.setUserId(moneyOut.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYOUT_CANCEL);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyOut.getMoney());
			account.setBalance(member.getBalance() + moneyOut.getMoney());
			account.setMoneyOutId(moneyOut.getId());
			
			accountDao.insertAccount(account);
			
			memberDao.plusMinusBalance(member.getUserId(), moneyOut.getMoney());
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView checkBankBookInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String bankName = request.getParameter("bankName");
		String bankNumber = request.getParameter("bankNumber");
		String bankOwner = request.getParameter("bankOwner");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bankName", bankName);
		param.put("bankNumber", bankNumber);
		param.put("bankOwner", bankOwner);		
		
		List <Member> dupList = memberDao.selectMemberList(param);
		
		ResultXml rx = new ResultXml(0, null, dupList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	private MessageSource msgSrc = null;

	public void setMessageSource(MessageSource messageSource) {
		msgSrc = messageSource;		
	}
}
