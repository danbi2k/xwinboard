package com.xwin.web.controller.admin;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.service.sports.GameWdlService;

public class ManageGameWdlController extends MultiActionController
{
	private GameWdlService gameWdlService = null;

	public void setGameWdlService(GameWdlService gameWdlService) {
		this.gameWdlService = gameWdlService;
	}
}
