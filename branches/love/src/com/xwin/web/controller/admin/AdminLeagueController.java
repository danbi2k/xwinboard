package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.League;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.LeagueCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminLeagueController extends XwinController
{	
	public static final int ROWSIZE = 30;
	
	public ModelAndView viewLeagueList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search, "%" + keyword + "%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<League> leagueList = leagueDao.selectLeagueList(param);
		Integer leagueCount = leagueDao.selectLeagueCount(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_league");
		mv.addObject("leagueList", leagueList);
		mv.addObject("leagueCount", leagueCount);
		
		return mv;
	}
	
	public ModelAndView viewRegisterLeagueForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/game/register_league");
		return mv;
	}
	
	public ModelAndView viewUpdateLeagueForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		League league = leagueDao.selectLeagueById(id);
		
		ModelAndView mv = new ModelAndView("admin/game/update_league");
		mv.addObject("league", league);
		return mv;
	}
	
	public ModelAndView registerLeague(HttpServletRequest request,
			HttpServletResponse response, LeagueCommand command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		MultipartFile mf = command.getImage();
		String fileName = XwinUtil.uploadContent(mf, Code.LEAGUE_IMAGE_PATH);
		
		ModelAndView mv = null;
		try {
			League league = new League();
			league.setName(command.getName());
			league.setImage(fileName);
			
			leagueDao.insertLeague(league);		
			
			mv = new ModelAndView("redirect:adminLeague.aspx?mode=viewLeagueList");
		} catch (Exception e) {
			e.printStackTrace();
			mv = new ModelAndView("admin/game/register_league");
			mv.addObject("EXIST", command.getName());
		}
		
		return mv;
	}
	
	public ModelAndView updateLeague(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		
		League league = new League();
		league.setName(name);
		league.setId(id);
		
		leagueDao.updateLeague(league);		
		
		List<League> leagueList = leagueDao.selectLeagueList();
		ModelAndView mv = new ModelAndView("admin/game/admin_league");
		mv.addObject("leagueList", leagueList);
		
		return mv;
	}
	
	
	public ModelAndView getLeagueList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ResultXml rx = new ResultXml(0, null, leagueList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView removeLeague(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		leagueDao.removeLeague(id);
		
		ResultXml rx = new ResultXml(0, "sudah di hapus", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml",XmlUtil.toXml(rx));
		
		return mv;
	}
}