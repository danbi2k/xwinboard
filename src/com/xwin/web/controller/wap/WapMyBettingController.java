package com.xwin.web.controller.wap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class WapMyBettingController extends XwinController
{
	private final static int ROWSIZE = 5;
	
	public ModelAndView viewMyBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
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
		Integer totalCount =	bettingDao.selectBettingCount(param);
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/my_betting");
		mv.addObject("bettingList", bettingList);
		mv.addObject("totalCount", totalCount);
		return mv;
	}
	
	public ModelAndView viewMyBettingDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String bettingId = request.getParameter("bettingId");
		Betting betting = bettingDao.selectBetting(bettingId);
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/my_betting_detail");
		mv.addObject("betting", betting);
		return mv;
	}
}