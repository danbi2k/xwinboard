package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminBettingController extends XwinController
{
	public static final int ROWSIZE = 20;
	
	public ModelAndView viewBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String gameType = XwinUtil.arcNvl(request.getParameter("gameType"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String betDate = XwinUtil.arcNvl(request.getParameter("betDate"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gameType", gameType);
		param.put("status", status);

		if (keyword != null) param.put(search+"LIKE", "%"+keyword+"%");
		if (betDate != null) {
			Date[] pair = XwinUtil.getDatePair(betDate);
			param.put("fromDate", pair[0]);
			param.put("toDate", pair[1]);
		}
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		Integer bettingCount = bettingDao.selectBettingCount(param);
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		
		return mv;
	}
	
	public ModelAndView calculateBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String message = "";
		Integer code = 0;
		
		String id = request.getParameter("id");
		//String gameType= request.getParameter("gameType");
		Betting betting = bettingDao.selectBetting(id);
		String gameType = betting.getGameType();
		
		if (gameType.equals("wdl")) {
			if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS) == false) {
				code = -1;
				message = "배팅이 적중 상태가 아닙니다";
			} else {
				calculateWdl(betting);
				message = "정산되었습니다";
			}
		}
		else if (gameType.equals("handy")) {
			if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS) == false ||
					betting.getStatus().equals(Code.BET_STATUS_HANDYDRAW) == false) {
				code = -1;
				message = "정산 가능 상태가 아닙니다";
			} else {
				calculateHandy(betting);
				message = "정산되었습니다";
			}
		}
				
		ResultXml rx = new ResultXml(code, message, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}

	public void calculateWdl(Betting betting) {
		String userId = betting.getUserId();
		Member member = memberDao.selectMember(userId, null);
					
		betting.setStatus(Code.BET_STATUS_COMMIT);
		bettingDao.updateBetting(betting);
		
		Account account = new Account();
		account.setUserId(userId);
		account.setType(Code.ACCOUNT_TYPE_JACKPOT);
		account.setDate(new Date());
		account.setOldBalance(member.getBalance());
		account.setMoney(betting.getExpect());
		account.setBalance(member.getBalance() + betting.getExpect());
		account.setBettingId(betting.getId());
		accountDao.insertAccount(account);
		
		memberDao.plusMinusBalance(userId, betting.getExpect());
	}
	
	public void calculateHandy(Betting betting) {
		String userId = betting.getUserId();
		Member member = memberDao.selectMember(userId, null);
		
		betting.setStatus(Code.BET_STATUS_COMMIT);
		bettingDao.updateBetting(betting);
		
		Account account = new Account();
		account.setUserId(userId);
		account.setType(Code.ACCOUNT_TYPE_JACKPOT);
		account.setDate(new Date());
		account.setOldBalance(member.getBalance());
		account.setMoney(betting.getExpect());
		account.setBalance(member.getBalance() + betting.getExpect());
		account.setBettingId(betting.getId());
		accountDao.insertAccount(account);
		
		memberDao.plusMinusBalance(userId, betting.getExpect());
	}
	
	public void calculateAllCancel(Betting betting) {
		String userId = betting.getUserId();
		Member member = memberDao.selectMember(userId, null);
					
		betting.setStatus(Code.BET_STATUS_COMMIT);
		bettingDao.updateBetting(betting);
		
		Account account = new Account();
		account.setUserId(userId);
		account.setType(Code.ACCOUNT_TYPE_JACKPOT);
		account.setDate(new Date());
		account.setOldBalance(member.getBalance());
		account.setMoney(betting.getExpect());
		account.setBalance(member.getBalance() + betting.getExpect());
		account.setBettingId(betting.getId());
		accountDao.insertAccount(account);
		
		memberDao.plusMinusBalance(userId, betting.getExpect());
	}
	
	public ModelAndView cancelBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String message = "";
		Integer code = 0;
		
		String id = request.getParameter("id");
		Betting betting = bettingDao.selectBetting(id);
		
		if (betting.getStatus().equals(Code.BET_STATUS_COMMIT)) {
			code = -1;
			message = "배팅이 취소 가능 상태가 아닙니다";
		} else {		
			String userId = betting.getUserId();
			Member member = memberDao.selectMember(userId, null);
			
			Account account = new Account();
			account.setUserId(userId);
			account.setType(Code.ACCOUNT_TYPE_BETCANCEL);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(betting.getMoney());
			account.setBalance(member.getBalance() + betting.getMoney());
			account.setBettingId(betting.getId());
			accountDao.insertAccount(account);
			
			betting.setStatus(Code.BET_STATUS_CANCEL);
			bettingDao.updateBetting(betting);			

			memberDao.plusMinusBalance(userId, betting.getMoney());			
			message = "취소 되었습니다";
		}
		
		ResultXml rx = new ResultXml(code, message, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView getBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String _pageIndex = request.getParameter("pageIndex");
		Integer pageIndex = null;
		try {
			pageIndex = Integer.parseInt(_pageIndex);
		} catch (Exception e) {
			pageIndex = 0;
		}
		List<Betting> bettingList =	bettingDao.selectBettingList();
		
		ResultXml resultXml = new ResultXml(0, null, bettingList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));		
		return mv;
	}
}
