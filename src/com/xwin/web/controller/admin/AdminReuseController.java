package com.xwin.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.common.ReuseComment;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminReuseController extends XwinController
{
	public ModelAndView viewReuseCommentList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		List<ReuseComment> reuseCommentList = reuseCommentDao.selectReuseCommentList(type);
		
		ModelAndView mv = new ModelAndView("admin/admin/admin_reuse");
		mv.addObject(reuseCommentList);
		
		return mv;
	}
	
	public ModelAndView writeReuseComment(HttpServletRequest request,
			HttpServletResponse response, ReuseComment reuseComment) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		reuseCommentDao.insertReuseComment(reuseComment);
		
		ResultXml rx = new ResultXml(0, "저장 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteReuseComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		reuseCommentDao.deleteReuseComment(id);

		ResultXml rx = new ResultXml(0, "삭제 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView getReuseComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		ReuseComment reuseComment = reuseCommentDao.selectReuseComment(id);

		ResultXml rx = new ResultXml(0, reuseComment.getComment(), null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
