package com.xwin.web.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.web.controller.XwinController;

public class AdminBoardController extends XwinController
{
	public ModelAndView viewNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String notice = adminDao.selectAdmin("NOTICE");
		ModelAndView mv = new ModelAndView("admin/board/notice");
		
		mv.addObject(notice);
		return mv;
	}
}
