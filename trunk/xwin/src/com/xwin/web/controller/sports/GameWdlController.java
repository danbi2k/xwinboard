package com.xwin.web.controller.sports;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.sports.GameWdl;
import com.xwin.service.sports.GameWdlService;

public class GameWdlController extends MultiActionController
{
	private GameWdlService gameWdlService = null;
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List<GameWdl> gameWdlList = gameWdlService.getGameWdlList();
		
		ModelAndView mv = new ModelAndView("game_wdl");
		mv.addObject("gameWdlList", gameWdlList);

		return mv; 
	}
	
	public void setGameWdlService(GameWdlService gameWdlService) {
		this.gameWdlService = gameWdlService;
	}
}
