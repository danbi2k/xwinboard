package com.xwin.web.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Betting;
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
			rx = new ResultXml(0, "유효하지 않은 배팅 입니다", betting);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));		
		return mv;
	}
}
