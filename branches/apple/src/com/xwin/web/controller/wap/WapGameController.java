package com.xwin.web.controller.wap;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class WapGameController extends XwinController
{

	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		HttpSession session = request.getSession();
		
		session.setAttribute("gameFolder_" + type, new GameFolder(type));
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		if (grade.equals(Code.USER_GRADE_VIP) && member.getGrade().equals(Code.USER_GRADE_VIP))
			param.put("grade", Code.USER_GRADE_VIP);
		else
			param.put("grade", Code.USER_GRADE_NORMAL);
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game");
		mv.addObject("gameList", gameList);

		return mv; 
	}
	
	public ModelAndView viewGameResultList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
		
		if (gameDate == null)
			gameDate = XwinUtil.toDateStr(new Date(), 2);
	
		Date[] datePair = XwinUtil.getDatePair(gameDate);
		Date fromDate = datePair[0];
		Date toDate = datePair[1];
	
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		List<String> statusList = new ArrayList<String>();
		statusList.add(Code.GAME_STATUS_END);
		statusList.add(Code.GAME_STATUS_CANCEL);
		param.put("statusList", statusList);
		param.put("fromDate", fromDate);
		param.put("toDate", toDate);
		param.put("ORDERBY", "DESC");
		param.put("gradeLess", member.getGrade());
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game_result");
		mv.addObject("gameList", gameList);

		return mv; 
	}
}