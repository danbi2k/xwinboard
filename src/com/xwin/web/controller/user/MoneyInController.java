package com.xwin.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.admin.BankBook;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MoneyInController extends XwinController
{
	int ROWSIZE = 15;
	
	public ModelAndView viewMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		List<BankBook> bankBookList =
			bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL);
		
		ModelAndView mv = new ModelAndView("user/money_in_req");
		mv.addObject("bankBookList", bankBookList);
		return mv;
	}
	
	public ModelAndView viewMoneyInRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
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
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.MONEY_IN_DIRECT);
		param.put("isRemoved", "N");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<MoneyIn> moneyInList =	moneyInDao.selectMoneyInList(param);
		Integer moneyInCount = moneyInDao.selectMoneyInCount(param);
		
		ModelAndView mv = new ModelAndView("user/money_in_req_list");
		mv.addObject("moneyInList", moneyInList);
		mv.addObject("moneyInCount", moneyInCount);
		return mv;
	}
	
	public ModelAndView moneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member =
			(Member) request.getSession().getAttribute("Member");
		String _money = request.getParameter("money");
		String _name = request.getParameter("name");
		String _bankBookId = request.getParameter("bankBookId");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("status", Code.MONEY_IN_REQUEST);
		Integer existCnt = moneyInDao.selectMoneyInCount(param);
		
		ResultXml rx = null;
		try {
			Long money = Long.parseLong(_money);
			
			if (money <= 0)
				rx = new ResultXml(-1, "harus masukan nomor lebih dari pada 0", null);
			else if (_name == null || _name.length() == 0)
				rx = new ResultXml(-1, "masuakan pembayaran", null);
			else if (existCnt > 0) {
				rx = new ResultXml(-1, "sudah ada permintaan isi yang di daftar", null);
			}
			else {			
				MoneyIn moneyIn = new MoneyIn();
				moneyIn.setUserId(member.getUserId());
				moneyIn.setMoney(money);
				moneyIn.setName(_name);
				moneyIn.setStatus(Code.MONEY_IN_REQUEST);
				moneyIn.setBankBookId(_bankBookId);
				moneyIn.setReqDate(new Date());
				moneyIn.setNickName(member.getNickName());
				moneyInDao.insertMoneyIn(moneyIn);
		
				rx = new ResultXml(0, "permintaan isi uang telah di terima", null);
			}
		} catch (NumberFormatException e) {
			rx = new ResultXml(-1, "masukan biaya yang anda akan bayar", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");		
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView cancelMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST) == false)
			rx = new ResultXml(0, "tidak ada permintaan isi", null);
		else {
			moneyIn.setStatus(Code.MONEY_IN_CANCEL);
			moneyIn.setProcDate(new Date());
			moneyInDao.updateMoneyIn(moneyIn);			
			rx = new ResultXml(0, "permintaan isi sudah di batal", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView removeMoneyInRequestLog(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST))
			rx = new ResultXml(0, "situasi yang tidak bisa di hapus", null);
		else {
			moneyIn.setIsRemoved("Y");
			moneyInDao.updateMoneyIn(moneyIn);			
			rx = new ResultXml(0, "rekor isi telah di hapus", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
}
