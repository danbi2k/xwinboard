package com.xwin.infra.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import sun.misc.BASE64Encoder;

public class XwinUtil
{
	private static final DecimalFormat float16Format = new DecimalFormat("0.0000000000000000");
	private static final DecimalFormat decimalFormat = new DecimalFormat("0.00");
	private static final SimpleDateFormat dateMinuteFormat = new SimpleDateFormat("yy-MM-dd HH:mm");
	private static final SimpleDateFormat dateSecondFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private static final SimpleDateFormat boardNoticeFormat = new SimpleDateFormat("MM/dd");
	private static final SimpleDateFormat boardItemFormat = new SimpleDateFormat("MM/dd HH:mm");
	private static final SimpleDateFormat myBettingFormat = new SimpleDateFormat("MM-dd HH:mm");
	
	public static String comma3(Integer num)
	{
		if (num == null)
			return "0";
		
		NumberFormat nf = NumberFormat.getInstance();
		return nf.format(num);
	}
	
	public static String comma3(Long num)
	{
		if (num == null)
			return "0";
		
		NumberFormat nf = NumberFormat.getInstance();
		return nf.format(num);
	}
	
	public static String comma3(Double num)
	{
		if (num == null)
			return "0";
		
		Long longNum = num.longValue();
		
		NumberFormat nf = NumberFormat.getInstance();
		return nf.format(longNum);
	}
	
	public static String comma3(String num)
	{
		if (num == null || num.length() == 0)
			return num;
		
		return comma3(Long.parseLong(num));
	}
	
	public static String getBoardItemDate(Date date)
	{
		return boardItemFormat.format(date);
	}
	
	public static String getBoardNoticeDate(Date date)
	{
		return boardNoticeFormat.format(date);
	}
	
	public static String getMMddDate(Date date)
	{
		return myBettingFormat.format(date);
	}
	
	public static Long calcExpectMoney(Double rate, Long money)
	{
		Double cutRate = doubleCut(rate);
		Double _expect = Math.ceil(cutRate * money);
		Long expect = _expect.longValue();
		
		return expect;
	}
	
	public static Calendar getOnlyDate(Calendar cal)
	{
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		return cal;
	}
	
	public static Date[] getDatePair(String dateStr) throws Exception
	{
		Date date = dateFormat.parse(dateStr);

		return getDatePair(date);
	}
	
	public static Date[] getDatePair(Date date) throws Exception
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal = getOnlyDate(cal);
		
		Date pair[] = new Date[2];
		pair[0] = cal.getTime();
		
		cal.add(Calendar.DATE, 1);
		cal.add(Calendar.MILLISECOND, -1);
		
		pair[1] = cal.getTime();
		
		return pair;
	}
	
	public static Date[] getMonthPair(Date date) throws Exception
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal = getOnlyDate(cal);
		cal.set(Calendar.DATE, 1);
		
		Date pair[] = new Date[2];
		pair[0] = cal.getTime();
		
		cal.add(Calendar.MONTH, 1);
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
	
	public static Date toDateFullTime(String dateStr)
	{
		if (dateStr == null)
			return null;
		
		Date date = null;		
		try {
			date = dateFormat.parse(dateStr);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			
			cal.add(Calendar.DATE, 1);
			cal.add(Calendar.MILLISECOND, -1);
			
			return cal.getTime();
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
	
	public static String nvl(Object obj, String defaultValue)
	{
		if (obj == null)
			return defaultValue;
		
		return obj.toString();
	}
	
	public static String arcNvl(String str)
	{
		if (str != null && str.length() == 0)
			return null;
		
		return str;
	}
	
	public static String numNvl(Object obj)
	{
		if (obj == null)
			return "0";
		
		return obj.toString();
	}
	
	public static Integer ntz(Integer obj)
	{
		if (obj == null)
			return 0;
		
		return obj;
	}
	
	public static Long ntz(Long obj)
	{
		if (obj == null)
			return 0L;
		
		return obj;
	}
	
	public static String to2Digit(Double x)
	{
		if (x == null)
			return null;
		
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
		else if (type == 2)
			ret = dateFormat.format(date);
		
		return ret;
	}
	
	public static Double doubleCut(Double x)
	{
//		Double y = x * 100.0;
//		y = Math.floor(y);
//		
//		y /= 100.0;
//		
//		return y;
		String str_x = float16Format.format(x);
		
		int dot_index = str_x.indexOf(".");
		String str_cut = str_x.substring(0, dot_index + 3);
		
		return Double.parseDouble(str_cut);
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
	
	public static String uploadContent(MultipartFile mf, String parentPath)
	{
		String orgFileName = mf.getOriginalFilename();
		int dotIndex = orgFileName.lastIndexOf('.');
		String ext = orgFileName.substring(dotIndex);
		
		String fileName = UUID.randomUUID().toString() + ext;
		
		try {
			InputStream is = mf.getInputStream();
			File dir = new File(parentPath);
			if (dir.exists() == false)
				dir.mkdir();
			
			String path = parentPath + File.separator + fileName;
			FileOutputStream fos = new FileOutputStream(path);
			
			int data = 0;
			while ((data = is.read()) != -1) {
				fos.write(data);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return fileName;
	}

	public static String bankTrim(String bankNumber) {
		if (bankNumber == null)
			return null;
		
		String retNumber = bankNumber.replaceAll(" ", "");
		retNumber = retNumber.replaceAll("-", "");
		retNumber = retNumber.trim();
		
		return retNumber;
	}
	
	public static String getAdminPassword(String message)
	{
		return getEncoded(message, "SHA-256");
	}
	
	public static String getUserPassword(String message)
	{
		return getEncoded(message, "SHA-1");
	}
	
	public static String getKeyPassword(String message)
	{
		if (message == null)
			return null;   
        try{
            MessageDigest md5 = MessageDigest.getInstance("SHA-256");
            md5.update(message.getBytes());
            byte[] md5Bytes = md5.digest(); 

            BASE64Encoder base64 = new BASE64Encoder();
            String encoded = base64.encode(md5Bytes); 
            
            return encoded.substring(6, 11).toLowerCase();           
            
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return null;
	}
	
	private static String getEncoded(String message, String algorithm)
	{
		if (message == null)
			return null;   
        try{
            MessageDigest md5 = MessageDigest.getInstance(algorithm);
            md5.update(message.getBytes());
            byte[] md5Bytes = md5.digest(); 

            BASE64Encoder base64 = new BASE64Encoder();
            String encoded = base64.encode(md5Bytes); 
            
            return encoded;           
            
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return null;
	}
	
	public static String makeAdminPin(Integer pin)
	{
		if (pin == null)
			return null;
		
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DATE);
		
		Integer adminPin = (pin * month) - date + 407;
		
		return adminPin.toString();
	}
}
