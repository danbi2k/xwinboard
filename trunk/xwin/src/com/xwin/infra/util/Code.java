package com.xwin.infra.util;

import java.util.HashMap;
import java.util.Map;

public class Code
{	
	private static final Map<String, String> valueMap = new HashMap<String, String>();
	private static final Map<String, String> keyMap = new HashMap<String, String>();
	
	static 
	{
		put("GS001", "�غ���");
		put("GS002", "������");
		put("GS003", "������");
		put("GS004", "����");
		put("GS005", "������");
		
		put("BS001", "������");
		put("BS002", "����");
		put("BS003", "����");
		put("BS004", "���(ȯ��)");
		put("BS005", "������");
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
