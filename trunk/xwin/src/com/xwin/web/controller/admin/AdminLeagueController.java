package com.xwin.web.controller.admin;

import java.util.List;

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
	public ModelAndView viewLeagueList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		
		if (keyword == null)
			search = null;
		
		List<League> leagueList = leagueDao.selectLeagueList(search, keyword);
		ModelAndView mv = new ModelAndView("admin/game/admin_league");
		mv.addObject("leagueList", leagueList);
		
		return mv;
	}
	
	public ModelAndView viewRegisterLeagueForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/game/register_league");
		return mv;
	}
	
	public ModelAndView viewUpdateLeagueForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		League league = leagueDao.selectLeagueById(id);
		
		ModelAndView mv = new ModelAndView("admin/game/update_league");
		mv.addObject("league", league);
		return mv;
	}
	
	public ModelAndView registerLeague(HttpServletRequest request,
			HttpServletResponse response, LeagueCommand command) throws Exception
	{
		MultipartFile mf = command.getImage();
		String fileName = XwinUtil.uploadContent(mf, Code.LEAGUE_IMAGE_PATH);
		
		League league = new League();
		league.setName(command.getName());
		league.setImage(fileName);
		
		leagueDao.insertLeague(league);		
		
		ModelAndView mv = new ModelAndView("redirect:adminLeague.aspx?mode=viewLeagueList");
		
		return mv;
	}
	
	public ModelAndView updateLeague(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
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
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ResultXml rx = new ResultXml(0, null, leagueList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView removeLeague(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		
		leagueDao.removeLeague(id);
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml",XmlUtil.toXml(rx));
		
		return mv;
	}
}