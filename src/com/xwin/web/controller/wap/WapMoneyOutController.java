package com.xwin.web.controller.wap;

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
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapMoneyOutController extends XwinController
{
	public ModelAndView viewMoneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =	(Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		ModelAndView mv = new ModelAndView("wap/money_out_request");
		return mv;
	}

	public ModelAndView moneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =	(Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		member = memberDao.selectMember(member.getUserId(), null);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		Integer sum = XwinUtil.ntz(bettingDao.selectBettingMoneySum(param));
		
		ResultWap rw = null;
		String moneyStr = request.getParameter("money");
		String pin = request.getParameter("pin");
		
		Long money = null;
		try {
			money = Long.parseLong(moneyStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (money == null)
			rw = new ResultWap(-1, "숫자를 입력해 주세요", "sendcache.wap?mode=viewMoneyOutRequest", null);
		else if (money <= 0)
			rw = new ResultWap(-1, "환전 신청액을 다시 확인해 주세요", "sendcache.wap?mode=viewMoneyOutRequest", null);
		else if ((money % 10000) > 0) {
			rw = new ResultWap(-1, "10,000캐쉬 단위로 신청해 주세요", "sendcache.wap?mode=viewMoneyOutRequest", null);
		}
		else if (member.getPin().equals(pin) == false) {
			rw = new ResultWap(-1, "모바일 PIN 번호를 입력해 주세요", "sendcache.wap?mode=viewMoneyOutRequest", null);
		}
		else if (member.getBalance() < money) {
			rw = new ResultWap(-1, "캐쉬 잔고가 부족합니다", "sendcache.wap?mode=viewMoneyOutRequest", null);
		}
		else if (sum < member.getJoinBonus()) {
			rw = new ResultWap(-1, "회원님께서는 가입보너스 및 프랜드보너스로 받으신 " + XwinUtil.comma3(member.getJoinBonus()) + "캐쉬를 \n배팅에 사용하신 후에 환전이 가능합니다. \n현배팅액 : " + XwinUtil.comma3(sum), "sendcache.wap?mode=viewMoneyOutRequest", null);
		}
		else {
			MoneyOut moneyOut = new MoneyOut();
			moneyOut.setMoney(money);
			moneyOut.setUserId(member.getUserId());
			moneyOut.setStatus(Code.MONEY_OUT_REQUEST);
			moneyOut.setReqDate(new Date());
			moneyOut.setNickName(member.getNickName());
			moneyOut.setBankName(member.getBankName());
			moneyOut.setNumber(member.getBankNumber());
			moneyOut.setName(member.getBankOwner());
			
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
			
			rw = new ResultWap(0, "캐쉬 환전이 접수 되었습니다.", "main.wap", null);
		}
		
		ModelAndView mv = new ModelAndView("wap/error");
		mv.addObject("resultWap", rw);
		return mv;
	}
	
	public ModelAndView viewMoneyOutRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{		
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.MONEY_OUT_DIRECT);
		param.put("isRemoved", "N");
		param.put("fromRow", 0);
		param.put("rowSize", 3);
		
		List<MoneyOut> moneyOutList = moneyOutDao.selectMoneyOutList(param);
		
		ModelAndView mv = new ModelAndView("wap/money_out_request_list");
		mv.addObject("moneyOutList", moneyOutList);
		
		return mv;
	}
}