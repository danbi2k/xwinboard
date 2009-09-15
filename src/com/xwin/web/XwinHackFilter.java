package com.xwin.web;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.xwin.domain.log.HackingLog;
import com.xwin.domain.user.Member;
import com.xwin.infra.dao.HackingLogDao;

public class XwinHackFilter implements Filter
{
	private static HackingLogDao hackingLogDao = null;
	
	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException
	{		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		boolean isValid = true;
		
		try {
			String mode = request.getParameter("mode");
			Map param = request.getParameterMap();
			Set<String> keySet = param.keySet();
			for (String key : keySet) {
				if (key.equals("mode"))
					continue;
				
				String[] val = request.getParameterValues(key);
				for (String str : val) {
					String lower = str.toLowerCase();
					if (lower.contains("select") ||
						lower.contains("update") ||
						lower.contains("delete") ||
						lower.contains("alter") ||
						lower.contains("create") ||
						lower.contains("tbl_")) {	
						
						isValid = false;
						
						String userId = null;
						String nickName = null;
						try {
							HttpSession session = httpRequest.getSession();
							Member member = (Member) session.getAttribute("Member");
							if (member != null) {
								userId = member.getUserId();
								nickName = member.getNickName();
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						
						HackingLog hackingLog = new HackingLog();
						hackingLog.setDate(new Date());
						hackingLog.setNickName(nickName);
						hackingLog.setUserId(userId);
						hackingLog.setValue(str);
						hackingLog.setMode(mode);
						hackingLog.setIpAddress(request.getRemoteAddr());
						
						hackingLogDao.insertHackingLog(hackingLog);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (isValid)
			filterChain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		if (hackingLogDao == null) {
			WebApplicationContext ctx = 
				WebApplicationContextUtils.getRequiredWebApplicationContext(filterConfig.getServletContext());
			
			hackingLogDao = (HackingLogDao) ctx.getBean("hackingLogDao");
		}
	}
}
