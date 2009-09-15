package com.xwin.web.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BetToto;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Toto;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MyBettingController extends XwinController
{
	int ROWSIZE = 10;
	
	public ModelAndView viewMyBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ModelAndView mv = null;
		
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null) {
			mv = new ModelAndView("dummy");
			return mv;
		}
		

		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.BET_STATUS_CANCEL);
		param.put("isDeleted", "N");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Betting> bettingList =	bettingDao.selectBettingList(param);
		Integer bettingCount =	bettingDao.selectBettingCount(param);
		
		mv = new ModelAndView("user/my_betting");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		return mv;
	}
	
	public ModelAndView deleteMyBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String bettingId = request.getParameter("bettingId");
		Member member = (Member) request.getSession().getAttribute("Member");
		
		Betting betting =
			bettingDao.selectBettingByUserId(member.getUserId(), bettingId);
		
		if (betting != null) {
			if (betting.getStatus().equals(Code.BET_STATUS_RUN)) {
				rx = new ResultXml(0, "진행중인 배팅은 삭제하실수 없습니다", betting);
			} else {
				betting.setIsDeleted("Y");
				bettingDao.updateBetting(betting);
				rx = new ResultXml(0, "배팅 기록이 삭제되었습니다", betting);
			}
		} else {
			rx = new ResultXml(0, "taruhan yang tidak berlaku", betting);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));		
		return mv;
	}
	
	public ModelAndView deleteMyToto(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String betTotoId = request.getParameter("betTotoId");
		Member member = (Member) request.getSession().getAttribute("Member");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", betTotoId);
		BetToto betToto =
			betTotoDao.selectBetToto(param);
		
		if (betToto != null && betToto.getUserId().equals(member.getUserId())) {
			if (betToto.getRunStatus().equals(Code.BET_STATUS_RUN)) {
				rx = new ResultXml(0, "daftar belanja tidak bisa di hapus wakrtu pembelian", betToto);
			} else {
				betToto.setIsDeleted("Y");
				betTotoDao.updateBetToto(betToto);
				rx = new ResultXml(0, "rekor pembelian sudah di hapus", betToto);
			}
		} else {
			rx = new ResultXml(0, "유효하지 않은 배팅 입니다", betToto);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));		
		return mv;
	}
	
	public ModelAndView viewMyTotoList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		if (member == null)
			return new ModelAndView("dummy");	
		

		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.BET_STATUS_CANCEL);
		param.put("isDeleted", "N");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<BetToto> betTotoList =	betTotoDao.selectBetTotoList(param);
		Integer betTotoCount =	betTotoDao.selectBetTotoCount(param);
		
		ModelAndView mv = new ModelAndView("user/my_toto");
		mv.addObject("betTotoList", betTotoList);
		mv.addObject("betTotoCount", betTotoCount);
		return mv;
	}
	
	public ModelAndView viewMyTotoDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		if (member == null)
			return new ModelAndView("dummy");	
		
		String id = request.getParameter("id");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("userId", member.getUserId());
		
		BetToto betToto = betTotoDao.selectBetToto(param);		
		Toto toto = totoDao.selectTotoById(betToto.getTotoId());
		
		Long money = betToto.getMoney();
		Long totalMoney = XwinUtil.ntz(toto.getTotalMoney()) + XwinUtil.ntz(toto.getCarryOver());
		
		param = new HashMap<String, Object>();
		param.put("totoId", betToto.getTotoId());
		param.put("runStatus", Code.BET_STATUS_RUN);		
		param.put("markingString", betToto.getMarkingString());
		Long successMoneySum = XwinUtil.ntz(betTotoDao.selectBetTotoMoneySum(param));
		
		Double portion = money.doubleValue() / (successMoneySum.doubleValue());
		Double _expect = Math.ceil(portion * totalMoney.doubleValue());
		Long expect = _expect.longValue();
		Double rate = XwinUtil.doubleCut(expect.doubleValue() / money.doubleValue());		
		
		ModelAndView mv = new ModelAndView("user/my_toto_detail");
		mv.addObject("toto", toto);
		mv.addObject("betToto", betToto);
		mv.addObject("rateString", XwinUtil.to2Digit(rate));
		
		return mv;
	}
	
	public ModelAndView removeMyBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = new ResultXml(-1, null, null);
		String bettingId = request.getParameter("bettingId");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member.getMemberId() == 1) {
			Betting betting =
				bettingDao.selectBettingByUserId(member.getUserId(), bettingId);
			
			if (betting != null) {
				betting.setMemberId(0);
				bettingDao.updateBetting(betting);
				
				rx = new ResultXml(0, "to 0", null);	
			}
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));		
		return mv;
	}
}
