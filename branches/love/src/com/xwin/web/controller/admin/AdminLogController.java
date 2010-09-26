package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.log.HackingLog;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminLogController extends XwinController
{
	public static final int ROWSIZE = 30;
	
	public ModelAndView viewHackingLog(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");

		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<HackingLog> hackingLogList = hackingLogDao.selectHackingLogList(param);
		Integer hackingLogCount = hackingLogDao.selectHackingLogCount(param);
		
		ModelAndView mv = new ModelAndView("admin/admin/hacking_log");
		mv.addObject("hackingLogList", hackingLogList);
		mv.addObject("hackingLogCount", hackingLogCount);
		
		return mv;
	}
	
	public ModelAndView saveHackingLogIsChecked(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String isChecked = request.getParameter("isChecked");
		
		HackingLog hackingLog = new HackingLog();
		hackingLog.setId(id);
		hackingLog.setIsChecked(isChecked);
		
		hackingLogDao.updateHackingLog(hackingLog);
		
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
}
