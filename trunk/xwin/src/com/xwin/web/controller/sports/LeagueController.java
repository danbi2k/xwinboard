package com.xwin.web.controller.sports;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.sports.League;
import com.xwin.infra.util.XmlUtil;
import com.xwin.service.sports.LeagueService;
import com.xwin.web.command.LeagueCommand;

public class LeagueController extends MultiActionController
{	
	public ModelAndView createLeague(HttpServletRequest request, HttpServletResponse response)
	{		
		String name = request.getParameter("name");
		String type = request.getParameter("type");
		
		League league = new League(null, name, type);
		leagueService.createLeague(league);
		
		return new ModelAndView("");
	}
	
	public ModelAndView manageLeague(HttpServletRequest request, HttpServletResponse response)
	{
		return new ModelAndView("admin/manageLeague");
	}
	
	public ModelAndView createLeague(HttpServletRequest request, HttpServletResponse response,
			LeagueCommand command)
	{
		League league = new League();
		BeanUtils.copyProperties(command, league);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		
		mv.addObject("resultXML", XmlUtil.toXML(league));
		
		return mv;
	}

	public ModelAndView getLeagueList(HttpServletRequest request, HttpServletResponse response)
	{
		List<League> leagueList = leagueService.getLeagueList();
		ModelAndView mv = new ModelAndView("xmlFacade");
		
		mv.addObject("resultXML", XmlUtil.toXML(leagueList));
		
		return mv;
	}

	private LeagueService leagueService = null;
	
	public void setLeagueService(LeagueService leagueService) {
		this.leagueService = leagueService;
	}	
}
