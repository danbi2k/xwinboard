package com.xwin.infra.util;

import java.util.HashMap;
import java.util.Map;

public class Code
{	
	public static String LEAGUE_IMAGE_PATH	= "";
	private static final Map<String, String> valueMap = new HashMap<String, String>();
	private static final Map<String, String> keyMap = new HashMap<String, String>();
	
	public static final String USER_GRADE_NORMAL		= "UG001";
	public static final String USER_GRADE_VIP			= "UG002";
	public static final String USER_GRADE_ADMIN			= "UG100";
	
	public static final String USER_STATUS_NORMAL	 	= "US001";
	public static final String USER_STATUS_SECEDE_REQ 	= "US002";
	public static final String USER_STATUS_SECEDE		= "US003";
	
	public static final String BET_STATUS_RUN			= "BS001";
	public static final String BET_STATUS_SUCCESS		= "BS002";
	public static final String BET_STATUS_FAILURE		= "BS003";
	public static final String BET_STATUS_CANCEL		= "BS004";
	public static final String BET_STATUS_NOMATCH		= "BS005";
	public static final String BET_STATUS_COMMIT		= "BS006";
	public static final String BET_STATUS_HANDYDRAW		= "BS007";
	
	public static final String BET_CALC_DISABLE			= "BTC01";
	public static final String BET_CALC_ENABLE			= "BTC02";
	public static final String BET_CALC_COMMIT			= "BTC10";
	
	public static final String GAME_STATUS_READY		= "GS002";
	public static final String GAME_STATUS_RUN			= "GS003";
	public static final String GAME_STATUS_END			= "GS004";
	public static final String GAME_STATUS_CANCEL		= "GS005";
	
	public static final String MONEY_IN_REQUEST		= "MC001";
	public static final String MONEY_IN_SUCCESS		= "MC002";
	public static final String MONEY_IN_FAILURE		= "MC003";
	
	public static final String MONEY_OUT_REQUEST	= "ME001";
	public static final String MONEY_OUT_SUCCESS	= "ME002";
	public static final String MONEY_OUT_FAILURE	= "ME003";
	
	public static final String BANKBOOK_STATUS_NORMAL	= "BBS01";
	public static final String BANKBOOK_STATUS_UNUSED	= "BBS02";
	
	public static final String ACCOUNT_TYPE_BETTING		= "AT001";
	public static final String ACCOUNT_TYPE_JACKPOT		= "AT002";
	public static final String ACCOUNT_TYPE_MONEYIN		= "AT003";
	public static final String ACCOUNT_TYPE_MONEYOUT	= "AT004";
	public static final String ACCOUNT_TYPE_BETCANCEL	= "AT005";
	public static final String ACCOUNT_TYPE_NOMATCH		= "AT006";
	
	public static final String BETTING_STATUS_ACCEPT	= "BTS01";
	public static final String BETTING_STATUS_DENY		= "BTS02";
	
	public static final String BOARDITEM_TYPE_NOTICE		= "BIT01";
	public static final String BOARDITEM_TYPE_USER			= "BIT10";
	
	public static final String BOARDITEM_STATUS_NORMAL		= "BIS01";
	public static final String BOARDITEM_STATUS_REMOVE		= "BIS03";
	
	static 
	{
		put(BET_CALC_DISABLE, "정산불가");
		put(BET_CALC_ENABLE, "정산가능");
		put(BET_CALC_COMMIT, "정산완료");
		
		put(BOARDITEM_STATUS_NORMAL, "정상");
		put(BOARDITEM_STATUS_REMOVE, "삭제");
		
		put(BOARDITEM_TYPE_NOTICE, "공지");
		put(BOARDITEM_TYPE_USER, "일반");
		
		put(BETTING_STATUS_ACCEPT, "가능");
		put(BETTING_STATUS_DENY, "금지");
		
		put(ACCOUNT_TYPE_BETTING, "배팅출금");
		put(ACCOUNT_TYPE_JACKPOT, "배팅당첨");
		put(ACCOUNT_TYPE_MONEYIN, "머니충전");
		put(ACCOUNT_TYPE_MONEYOUT, "머니출금");
		put(ACCOUNT_TYPE_BETCANCEL,"배팅취소");
		put(ACCOUNT_TYPE_NOMATCH, "게임취소");
		
		put(BANKBOOK_STATUS_NORMAL, "정상");
		put(BANKBOOK_STATUS_UNUSED, "사용중지");
		
		put(MONEY_IN_REQUEST, "충전요청");
		put(MONEY_IN_SUCCESS, "충전성공");
		put(MONEY_IN_FAILURE, "충전실패");
		
		put(MONEY_OUT_REQUEST, "출금요청");
		put(MONEY_OUT_SUCCESS, "출금성공");
		put(MONEY_OUT_FAILURE, "환전실패");
		
		put(GAME_STATUS_READY, "경기대기");
		put(GAME_STATUS_RUN, "경기진행");
		put(GAME_STATUS_END, "경기종료");
		put(GAME_STATUS_CANCEL, "경기취소");
		
		put(BET_STATUS_RUN, "진행중");
		put(BET_STATUS_SUCCESS, "당첨");
		put(BET_STATUS_FAILURE, "미당첨");
		put(BET_STATUS_CANCEL, "배팅취소(환불)");
		put(BET_STATUS_NOMATCH, "경기취소(환불)");
		put(BET_STATUS_COMMIT, "정산완료");
		put(BET_STATUS_HANDYDRAW, "무승부(환불)");

		put(USER_GRADE_NORMAL, "일반");
		put(USER_GRADE_VIP, "VIP");
		put(USER_GRADE_ADMIN, "관리자");
		
		
		put(USER_STATUS_NORMAL, "정상");
		put(USER_STATUS_SECEDE_REQ, "탈퇴요청");
		put(USER_STATUS_SECEDE, "탈퇴");
		
		put("W", "승");
		put("D", "무");
		put("L", "패");
	}
	
	private static void put(String key, String value)
	{
		valueMap.put(key, value);
		keyMap.put(value, key);
	}
	
	public static String getValue(String key)
	{
		if (key == null)
			return "-";
		return valueMap.get(key);
	}
	
	public static String getKey(String value)
	{
		return keyMap.get(value);
	}
}
