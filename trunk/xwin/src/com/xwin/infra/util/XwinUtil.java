package com.xwin.infra.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class XwinUtil
{
	private static final DecimalFormat decimalFormat = new DecimalFormat("0.00");
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yy-MM-dd HH:mm");
	
	public static String to2Digit(double x)
	{
		String ret = decimalFormat.format(doubleCut(x));
		return ret;
	}
	
	public static String toDate(Date date)
	{
		if (date == null)
			return "";
		String ret = dateFormat.format(date);
		return ret;
	}
	
	public static Double doubleCut(Double x)
	{
		Double y = x * 100.0;
		y = Math.floor(y);
		
		y /= 100.0;
		
		return y;
	}
	
	public static Date getDate(Integer year, Integer month, Integer date, Integer hour, Integer minute)
	{
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.DATE, date);
		cal.set(Calendar.HOUR_OF_DAY, hour);
		cal.set(Calendar.MINUTE, minute);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		return cal.getTime();
	}
}
