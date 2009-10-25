package com.xwin.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Admin;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MoneyOutController extends XwinController
{
	int ROWSIZE = 15;
	
	public ModelAndView viewMoneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ModelAndView mv = new ModelAndView("user/money_out_req");
		return mv;
	}
	
	public ModelAndView viewMoneyOutRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
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
		param.put("notStatus", Code.MONEY_OUT_DIRECT);
		param.put("isRemoved", "N");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<MoneyOut> moneyOutList = moneyOutDao.selectMoneyOutList(param);
		Integer moneyOutCount = moneyOutDao.selectMoneyOutCount(param);
		
		ModelAndView mv = new ModelAndView("user/money_out_req_list");
		mv.addObject("moneyOutList", moneyOutList);
		mv.addObject("moneyOutCount", moneyOutCount);
		
		return mv;
	}
	
	public synchronized ModelAndView moneyOutRequest(HttpServletRequest request,
			HttpServletResponse response, MoneyOut moneyOut) throws Exception
	{
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		
		Member member =	(Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("dummy");
		
		member = memberDao.selectMember(member.getUserId(), null);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		Integer sum = XwinUtil.ntz(bettingDao.selectBettingMoneySum(param));
		
		ResultXml rx = null;
		String password = request.getParameter("password");
		
		if (moneyOut.getMoney() <= 0)
			rx = new ResultXml(-1, "환전 신청액을 다시 확인해 주세요", null);
		else if ((moneyOut.getMoney() % 10000) > 0) {
			rx = new ResultXml(-1, "10,000캐쉬 단위로 신청해 주세요", null);
		}
		else if (member.getPassword().equals(XwinUtil.getUserPassword(password)) == false) {
			rx = new ResultXml(-1, "로그인 패스워드를 입력해 주세요", null);
		}
		else if (member.getBalance() < moneyOut.getMoney()) {
			rx = new ResultXml(-1, "캐쉬 잔고가 부족합니다", null);
		}
		else if (sum < member.getJoinBonus()) {
			rx = new ResultXml(-1, "회원님께서는 가입보너스 및 프랜드보너스로 받으신 " + XwinUtil.comma3(member.getJoinBonus()) + "캐쉬를 \n배팅에 사용하신 후에 환전이 가능합니다. \n현배팅액 : " + XwinUtil.comma3(sum), null);
		}
		else {
			moneyOut.setUserId(member.getUserId());
			moneyOut.setStatus(Code.MONEY_OUT_REQUEST);
			moneyOut.setReqDate(new Date());
			moneyOut.setNickName(member.getNickName());
			moneyOut.setBankName(member.getBankName());
			moneyOut.setNumber(member.getBankNumber());
			moneyOut.setName(member.getBankOwner());
			moneyOut.setSource(Code.SOURCE_WEB);
			
			moneyOutDao.insertMoneyOut(moneyOut);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYOUT);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyOut.getMoney() * -1);
			account.setBalance(member.getBalance() - moneyOut.getMoney());
			account.setMoneyOutId(moneyOut.getId());
			
			accountDao.insertAccount(account);		
			memberDao.plusMinusBalance(member.getUserId(), moneyOut.getMoney() * -1);
			
			member.setBalance(member.getBalance() - moneyOut.getMoney());
			
			rx = new ResultXml(0, "캐쉬 환전이 접수 되었습니다.", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView removeMoneyOutRequestLog(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyOut moneyOut = moneyOutDao.selectMoneyOut(id);		
		if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST))
			rx = new ResultXml(0, "진행중인 내역은 삭제가 되지 않습니다", null);
		else {
			moneyOut.setIsRemoved("Y");
			moneyOutDao.updateMoneyOut(moneyOut);			
			rx = new ResultXml(0, "환전 내역이 삭제되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
}
