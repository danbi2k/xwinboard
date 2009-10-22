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
	private final static int ROWSIZE = 3;
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member member = (Member) request.getAttribute("Member");	
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));		
	
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.HOUR, 12);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		if (grade.equals(Code.USER_GRADE_VIP) && member.getGrade().equals(Code.USER_GRADE_VIP))
			param.put("grade", Code.USER_GRADE_VIP);
		else
			param.put("grade", Code.USER_GRADE_NORMAL);
		
		Map<String, List<Game>> gameListMap = new HashMap<String, List<Game>>();
		List<Game> gameList = gameDao.selectGameList(param);
		for (Game game : gameList) {
			String leagueId = game.getLeagueId();
			List<Game> leagueGameList = gameListMap.get(leagueId);
			if (leagueGameList == null) {
				leagueGameList = new ArrayList<Game>();
				gameListMap.put(leagueId, leagueGameList);
			}
			leagueGameList.add(game);
		}
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game");
		mv.addObject("gameListMap", gameListMap);

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
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		if (gameDate == null)
			gameDate = XwinUtil.toDateStr(new Date(), 2);
	
		Date[] datePair = XwinUtil.getDatePair(gameDate);
		Date fromDate = datePair[0];
		Date toDate = datePair[1];
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
	
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
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("wap/" + LANG_TYPE + "/game_result");
		mv.addObject("gameList", gameList);

		return mv; 
	}
}