package com.xwin.web.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;

public class IndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("toDate", cal.getTime());
		param.put("fromRow", 0);
		param.put("rowSize", 15);
		param.put("status", Code.GAME_STATUS_READY);
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("gameList", gameList);
		return mv;
	}

}
