package com.xwin.domain;

import java.util.Locale;

import com.xwin.infra.util.Code;

public class SiteConfig extends XwinObject
{
	private static final long serialVersionUID = -3188943696296998618L;

	public static String SITE_GRADE = Code.USER_GRADE_VIP;
	
	public static Locale SITE_LOCALE = Locale.KOREA;
	public static boolean PIN_LOGIN = false;	
	
	public static String SITE_NAME = "드래곤월드";
	public static String SITE_NICKNAME = "Dragon World";
	public static String SITE_NICKSHORT = "DW";
	public static String SITE_DOMAIN = "dw-top.net";
	public static String SITE_PHONE = "17317071";
	public static String SITE_COLOR = "darkred";
	
	public void setSITE_GRADE(String SITE_GRADE) {
		SiteConfig.SITE_GRADE = SITE_GRADE;
		
		if (SiteConfig.SITE_GRADE.equals(Code.USER_GRADE_NORMAL)) {
			SiteConfig.SITE_NAME = "블루드래곤";
			SiteConfig.SITE_NICKNAME = "Blue Dragon";
			SiteConfig.SITE_NICKSHORT = "BD";
			SiteConfig.SITE_DOMAIN = "bd-top.net";
			SiteConfig.SITE_COLOR = "#026597";
		}
	}
}
