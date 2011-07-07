package com.xwin.web.controller.dealer;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Betting;
import com.xwin.domain.join.Invitation;
import com.xwin.domain.statistics.DealerSummary;
import com.xwin.domain.user.Dealer;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class DealerController extends XwinController
{
	public static final int ROWSIZE = 40;
	
	public ModelAndView viewDealerInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("dealer/dealer_info");
		
		return mv;
	}
	
	public ModelAndView changePassword(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		String password = (String) request.getParameter("password");
		String password1 = (String) request.getParameter("password1");
		
		ResultXml rx = null;
		
		if (XwinUtil.getUserPassword(password).equals(dealer.getPassword())) {
			dealer.setPassword(XwinUtil.getUserPassword(password1));
			dealerDao.updateDealer(dealer);;
		
			rx = new ResultXml(0, "비밀번호가 변경 되었습니다", null);
		} else {
			rx = new ResultXml(-1, "현재 비밀번호가 일치하지 않습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewInvitationForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealer.getDealerId());
		param.put("joinIdNull", "");
		List<Invitation> noJoinList = invitationDao.selectInvitationList(param);
		
		ModelAndView mv = new ModelAndView("dealer/invitation_form");
		mv.addObject("noJoinList", noJoinList);
		
		return mv;		
	}
	
	public ModelAndView sendInvitation(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		String mobile = request.getParameter("mobile");
		
		String inviteKey = RandomStringUtils.randomAlphanumeric(5).toUpperCase();
		
		Invitation invitation = new Invitation();
		invitation.setInviteKey(inviteKey);
		invitation.setDealerId(dealer.getDealerId());
		invitation.setSendDate(new Date());
		invitation.setMobile(mobile.trim());
		
		invitationDao.insertInvitation(invitation);
		
		try {
			sendSmsConnector.sendSms("초대장 : " + inviteKey, mobile, "1588");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ResultXml rx = new ResultXml(0, "지급 되었습니다", null);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;		
	}
	
	public ModelAndView viewBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		String gameType = XwinUtil.arcNvl(request.getParameter("gameType"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String focusSearch = XwinUtil.arcNvl(request.getParameter("focusSearch"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gameType", gameType);
		param.put("status", status);
		param.put("dealerId", dealer.getDealerId());
		
		if (focusSearch != null)
			param.put(focusSearch, keyword);
		else if (keyword != null)
			param.put(search+"Like", "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		Integer bettingCount = bettingDao.selectBettingCount(param);
		
		ModelAndView mv = new ModelAndView("dealer/dealer_betting_list");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		
		return mv;
	}
	
	public ModelAndView viewBettingDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		Betting betting = bettingDao.selectBetting(id);
		if (dealer.getDealerId().equals(betting.getDealerId()) == false)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("dealer/dealer_betting_detail");
		mv.addObject("betting", betting);
		
		return mv;
	}
	
	public ModelAndView viewMemberList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String orderCol = XwinUtil.arcNvl(request.getParameter("orderCol"));
		String orderBy = XwinUtil.arcNvl(request.getParameter("orderBy"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		if (orderCol == null)
			orderCol = "BALANCE";
		if (orderBy == null)
			orderBy = "DESC";
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealer.getDealerId());
		param.put("status", Code.USER_STATUS_NORMAL);
		Integer normalCount = memberDao.selectMemberCount(param);
		param.put("status", Code.USER_STATUS_SECEDE_REQ);		
		Integer secedeReqCount = memberDao.selectMemberCount(param);
		param.put("status", Code.USER_STATUS_SECEDE);		
		Integer secedeCount = memberDao.selectMemberCount(param);
		
		param.clear();		
		
		param.put("grade", Code.USER_GRADE_OTHER);
		param.put("dealerId", dealer.getDealerId());
		param.put("status", status);
		param.put("orderCol", orderCol);
		param.put("orderBy", orderBy);
		
		if (keyword != null)
			param.put(search, "%" + keyword + "%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		Integer memberCount = memberDao.selectMemberCount(param);
		List<Member> memberList = memberDao.selectMemberList(param);
		
		ModelAndView mv = new ModelAndView("dealer/dealer_member");
		mv.addObject("memberList", memberList);
		mv.addObject("memberCount", memberCount);
		mv.addObject("normalCount", normalCount);
		mv.addObject("secedeReqCount", secedeReqCount);
		mv.addObject("secedeCount", secedeCount);
		return mv;
	}
	
	public ModelAndView viewDealerSummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Dealer dealer = (Dealer) request.getSession().getAttribute("Dealer");		
		if (dealer == null)
			return new ModelAndView("admin_dummy");
		
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		Calendar cal = Calendar.getInstance();
		if (year == null)
			year = "" + cal.get(Calendar.YEAR);
		
		if (month == null)
			month = String.format("%02d", cal.get(Calendar.MONTH) + 1);

		Date[] monthPair = XwinUtil.getMonthPair(year + "-" + month);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealer.getDealerId());
		param.put("fromDate", monthPair[0]);
		param.put("toDate", monthPair[1]);		
		List<DealerSummary> dealerSummaryList = bettingDao.selectDealerSummary(param);
		
		ModelAndView mv = new ModelAndView("dealer/dealer_summary");
		mv.addObject("dealerSummaryList", dealerSummaryList);
		return mv;
	}
}
