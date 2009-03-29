package com.xwin.web.controller.game;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BetToto;
import com.xwin.domain.game.League;
import com.xwin.domain.game.Toto;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class TotoController extends XwinController
{
	int ROWSIZE = 30;
	
	public ModelAndView viewToto(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);		
		Toto toto = totoDao.selectToto(param);
		
		Long totalMoney = null;
		Integer totalCount = null;
		if (toto != null) {
			param = new HashMap<String, Object>();
			param.put("totoId", toto.getId());
			param.put("notRunStatus", Code.BET_STATUS_CANCEL);
			Long totalMoneySum = XwinUtil.ntz(betTotoDao.selectBetTotoMoneySum(param));
			totalMoney = totalMoneySum - XwinUtil.calcExpectMoney(toto.getEarnRate() / 100.0, totalMoneySum);
			
			totalCount = betTotoDao.selectBetTotoCount(param);
		}
		
		ModelAndView mv = new ModelAndView("game/toto");
		mv.addObject("toto", toto);
		mv.addObject("totalMoney", totalMoney);
		mv.addObject("totalCount", totalCount);

		return mv; 
	}
	
	public ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String markingString = XwinUtil.arcNvl(request.getParameter("markingString"));
		String totoId = XwinUtil.arcNvl(request.getParameter("totoId"));
		String _money = XwinUtil.arcNvl(request.getParameter("money"));

		ResultXml rx = null;
		
		Integer money = 0;
		try {
			money = Integer.parseInt(_money);
		} catch (Exception e) {
			e.printStackTrace();
			rx = new ResultXml(-1, "구매금액을 확인하십시오", null);
		}
		
		BetToto betToto = new BetToto();
		betToto.setTotoId(totoId);
		betToto.setMarkingString(markingString);
		betToto.setMoney(money);
		betToto.setUserId(member.getUserId());
		betToto.setNickName(member.getNickName());
		betToto.setDate(new Date());
		betToto.setRate(0.0);
		betToto.setRunStatus(Code.BET_STATUS_RUN);
		betToto.setCalcStatus(Code.BET_CALC_DISABLE);
		
		betTotoDao.insertBetToto(betToto);
		rx = new ResultXml(0, "구매 하셨습니다", null);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;		
	}
	
	public ModelAndView viewTotoResultList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String totoDate = XwinUtil.arcNvl(request.getParameter("totoDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		if (type == null)
			type = "wdl";
		
		String grade = Code.USER_GRADE_NORMAL;
		if (type.equals("mix")) {
			grade = Code.USER_GRADE_VIP;
			type = null;
		}
		
		if (totoDate == null)
			totoDate = XwinUtil.toDateStr(new Date(), 2);
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Date fromDate = null;
		Date toDate = null;
		
		if (totoDate == null) {
			Calendar fromCal = Calendar.getInstance();
			Calendar toCal = Calendar.getInstance();
			fromCal = XwinUtil.getOnlyDate(fromCal);
			toCal = XwinUtil.getOnlyDate(toCal);
			
			fromCal.add(Calendar.DATE, -7);			
			toCal.add(Calendar.DATE, 1);
			toCal.add(Calendar.MILLISECOND, -1);
			
			fromDate = fromCal.getTime();
			toDate = toCal.getTime();			
		} else {
			Date[] datePair = XwinUtil.getDatePair(totoDate);
			fromDate = datePair[0];
			toDate = datePair[1];
		}
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("grade", grade);
		param.put("leagueId", leagueId);
		List<String> statusList = new ArrayList<String>();
		statusList.add(Code.GAME_STATUS_END);
		statusList.add(Code.GAME_STATUS_CANCEL);
		param.put("statusList", statusList);
		param.put("fromDate", fromDate);
		param.put("toDate", toDate);
		param.put("ORDERBY", "DESC");
//		param.put("gradeLess", member.getGrade());
		//param.put("fromRow", pIdx * ROWSIZE);
		//param.put("rowSize", ROWSIZE);
		
		List<Toto> totoList = totoDao.selectTotoList(param);		
		List<League> leagueList = leagueDao.selectLeagueList();		
		
		ModelAndView mv = new ModelAndView("toto/result");
		mv.addObject("totoList", totoList);
		mv.addObject("leagueList", leagueList);

		return mv; 
	}
	
	public ModelAndView getTotoList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		if (grade.equals(Code.USER_GRADE_VIP) && member.getGrade().equals(Code.USER_GRADE_VIP))
			param.put("grade", Code.USER_GRADE_VIP);
		else
			param.put("grade", Code.USER_GRADE_NORMAL);
		
		List<Toto> totoList = totoDao.selectTotoList(param);
		//Integer totoCount = totoDao.selectTotoCount(param);
		
		ResultXml resultXml = new ResultXml(0, null, totoList);

		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
}
