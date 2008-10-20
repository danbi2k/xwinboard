package com.xwin.web;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.xwin.domain.admin.Admin;
import com.xwin.infra.dao.AdminDao;
import com.xwin.infra.util.Code;

public class XwinInitServlet extends HttpServlet {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	public void init(ServletConfig servletConfig) throws ServletException {
		ServletContext ctx = servletConfig.getServletContext();
		String imagePath = ctx.getRealPath("images/league");
		Code.LEAGUE_IMAGE_PATH = imagePath;

		WebApplicationContext wac = 
			WebApplicationContextUtils.getRequiredWebApplicationContext(ctx);
		
		AdminDao adminDao = (AdminDao) wac.getBean("adminDao");
		Admin.NOTICE = adminDao.selectAdmin("NOTICE");
		Admin.POPUP = adminDao.selectAdmin("POPUP");
		Admin.POPUPFLAG = adminDao.selectAdmin("POPUPFLAG");
		
		Admin.DENY_JOIN = adminDao.selectAdmin("DENY_JOIN");
		Admin.DENY_BOARD = adminDao.selectAdmin("DENY_BOARD");
		Admin.DENY_QNA = adminDao.selectAdmin("DENY_QNA");
		Admin.DENY_CHARGE = adminDao.selectAdmin("DENY_CHARGE");
		Admin.DENY_EXCHANGE = adminDao.selectAdmin("DENY_EXCHANGE");
	}

	public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
