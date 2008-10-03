package com.xwin.infra.util;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class XwinUtil
{
	private static final DecimalFormat decimalFormat = new DecimalFormat("0.00");
	private static final SimpleDateFormat dateMinuteFormat = new SimpleDateFormat("yy-MM-dd HH:mm");
	private static final SimpleDateFormat dateSecondFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public static Date[] getDatePair(String dateStr) throws Exception
	{
		Date date = dateFormat.parse(dateStr);
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		Date pair[] = new Date[2];
		pair[0] = cal.getTime();
		
		cal.add(Calendar.DATE, 1);
		cal.add(Calendar.MILLISECOND, -1);
		
		pair[1] = cal.getTime();
		
		return pair;
	}
	
	public static String getHour(Date date)
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		return "" + cal.get(Calendar.HOUR_OF_DAY);
	}
	
	public static String getMinute(Date date)
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		return "" + cal.get(Calendar.MINUTE);
	}
	
	public static String Int2Digit(Integer x)
	{
		if (x < 10)
			return "0" + x;
		
		return "" + x;
	}
	
	public static Date toDate(String dateStr)
	{
		if (dateStr == null)
			return null;
		
		Date date = null;		
		try {
			date = dateFormat.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return date;
	}
	
	public static String nvl(Object obj)
	{
		if (obj == null)
			return "";
		
		return obj.toString();
	}
	
	public static String arcNvl(String str)
	{
		if (str != null && str.length() == 0)
			return null;
		
		return str;
	}
	
	public static String to2Digit(double x)
	{
		String ret = decimalFormat.format(doubleCut(x));
		return ret;
	}
	
	public static String toDateStr(Date date, Integer type)
	{
		if (date == null)
			return "";
		
		String ret = null;
		if (type == 0)
			ret = dateMinuteFormat.format(date);
		else if (type == 1)
			ret = dateSecondFormat.format(date);
		else
			ret = dateFormat.format(date);
		
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
	
	public static Date getDate(String date, Integer hour, Integer minute)
	{
		String[] parse = date.split("-");
		Calendar cal = Calendar.getInstance();		
		cal.set(Calendar.YEAR, Integer.parseInt(parse[0]));
		cal.set(Calendar.MONTH, Integer.parseInt(parse[1]) - 1);
		cal.set(Calendar.DATE, Integer.parseInt(parse[2]));
		cal.set(Calendar.HOUR_OF_DAY, hour);
		cal.set(Calendar.MINUTE, minute);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		return cal.getTime();
	}
}
