package com.xwin.infra.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class XwinUtil
{
	private static final DecimalFormat decimalFormat = new DecimalFormat("#.##");
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static String to2Digit(double x)
	{
		String ret = decimalFormat.format(x);
		return ret;
	}
	
	public static String toDate(Date date)
	{
		String ret = dateFormat.format(date);
		return ret;
	}
}
