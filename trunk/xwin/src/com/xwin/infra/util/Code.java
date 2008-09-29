package com.xwin.infra.util;

import java.util.HashMap;
import java.util.Map;

public class Code
{	
	private static final Map<String, String> valueMap = new HashMap<String, String>();
	private static final Map<String, String> keyMap = new HashMap<String, String>();
	
	static 
	{
		put("GS001", "준비중");
		put("GS002", "접수중");
		put("GS003", "진행중");
		put("GS004", "종료");
		put("GS005", "경기취소");
		
		put("BS001", "진행중");
		put("BS002", "적중");
		put("BS003", "실패");
		put("BS004", "취소(환불)");
		put("BS005", "경기취소");
	}
	
	private static void put(String key, String value)
	{
		valueMap.put(key, value);
		keyMap.put(value, key);
	}
	
	public static String getValue(String key)
	{
		return valueMap.get(key);
	}
	
	public static String getKey(String value)
	{
		return keyMap.get(value);
	}
}
