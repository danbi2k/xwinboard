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
import com.xwin.domain.user.Member;
import com.xwin.infra.dao.AdminDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.util.Code;

public class XwinInitServlet extends HttpServlet
{
	private static final long serialVersionUID = -4949465242872613328L;

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
		//String imagePath = "D:/Apache2.2/htdocs/images/league";
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
		
		Admin.SMS_REMAIN = adminDao.selectAdmin("SMS_REMAIN");
		
		Admin.HANDY_BONUS_USE = adminDao.selectAdmin("HANDY_BONUS_USE").equals("Y");
		Admin.HANDY_BONUS_LIMIT = Integer.parseInt(adminDao.selectAdmin("HANDY_BONUS_LIMIT").trim());
		Admin.HANDY_BONUS_RATE = Integer.parseInt(adminDao.selectAdmin("HANDY_BONUS_RATE").trim());
		Admin.WDL_BONUS_USE = adminDao.selectAdmin("WDL_BONUS_USE").equals("Y");
		Admin.WDL_BONUS_LIMIT = Integer.parseInt(adminDao.selectAdmin("WDL_BONUS_LIMIT").trim());
		Admin.WDL_BONUS_RATE = Integer.parseInt(adminDao.selectAdmin("WDL_BONUS_RATE").trim());
		
		Admin.BETTING_POINT_USE = adminDao.selectAdmin("BETTING_POINT_USE").equals("Y");
		Admin.BETTING_POINT_RATE = Integer.parseInt(adminDao.selectAdmin("BETTING_POINT_RATE").trim());
		
		MemberDao memberDao = (MemberDao) wac.getBean("memberDao");
		Admin.memberDao = memberDao;
		
		Member admin = memberDao.selectMember("*****", null);
		Admin.ADMIN_EMAIL = admin.getEmail();
	}

	public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
