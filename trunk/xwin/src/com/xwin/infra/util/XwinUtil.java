package com.xwin.infra.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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
}
