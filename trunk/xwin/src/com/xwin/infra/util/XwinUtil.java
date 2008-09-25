package com.xwin.infra.util;

import java.text.DecimalFormat;

public class XwinUtil
{
	private static final DecimalFormat format = new DecimalFormat("#.##");
	
	public static String float2Digit(double x)
	{
		String ret = format.format(x);
		return ret;
	}
}
