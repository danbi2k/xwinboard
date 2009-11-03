package com.xwin.web.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;

public class HomeController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		param.put("fromRow", 0);
		param.put("rowSize", 9);
		param.put("grade", 1);
		param.put("type", "wdl");
		List<Game> wdlList = gameDao.selectGameList(param);
		
		param.put("type", "handy");
		List<Game> handyList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("home");
		mv.addObject("wdlList", wdlList);
		mv.addObject("handyList", handyList);
		
		return mv;
	}
}