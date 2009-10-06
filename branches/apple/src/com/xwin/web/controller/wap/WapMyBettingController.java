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
import com.xwin.web.controller.XwinController;

public class WapMyBettingController extends XwinController
{
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.BET_STATUS_CANCEL);
		param.put("isDeleted", "N");
		param.put("fromRow", 0);
		param.put("rowSize", 5);
		
		List<Betting> bettingList =	bettingDao.selectBettingList(param);
		Integer bettingCount =	bettingDao.selectBettingCount(param);
		
		ModelAndView mv = new ModelAndView("wap/my_betting");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		return mv;
	}
}