package com.xwin.domain.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.xwin.domain.XwinObject;
import com.xwin.domain.user.Member;
import com.xwin.infra.dao.MemberDao;

public class Admin extends XwinObject
{
	private static final long serialVersionUID = 3608655007121299776L;
	
	public static MemberDao memberDao = null;
	
	public static String NOTICE = "";
	public static String POPUP = "";
	public static String POPUPFLAG = "";
	
	public static String DENY_JOIN = "";
	public static String DENY_BOARD = "";
	public static String DENY_QNA = "";
	public static String DENY_CHARGE = "";
	public static String DENY_EXCHANGE = "";
	
	public static String SMS_REMAIN = "";
	
	public static String ADMIN_EMAIL = "";

	public static boolean HANDY_BONUS_USE = false;
	public static Integer HANDY_BONUS_LIMIT = 100;
	public static Integer HANDY_BONUS_RATE = 0;
	public static boolean WDL_BONUS_USE = false;
	public static Integer WDL_BONUS_LIMIT = 100;
	public static Integer WDL_BONUS_RATE = 0;
	
	public static Member getDbMember(String userId) {
		return memberDao.selectMember(userId, null);
	}
	
	public static Map<String, HttpSession> loginMap = new HashMap<String, HttpSession>();
}
