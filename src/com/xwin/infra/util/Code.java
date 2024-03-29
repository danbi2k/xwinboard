package com.xwin.infra.util;

import java.util.HashMap;
import java.util.Map;

public class Code
{	
	public static String LEAGUE_IMAGE_PATH	= "";
	
	private static final Map<String, String> valueMap = new HashMap<String, String>();
	private static final Map<String, String> keyMap = new HashMap<String, String>();
	
	public static final int DENY_WRITE_BOARD		= 0x001 << 0;
	public static final int DENY_WRITE_QNA			= 0x001 << 1;	
	
	public static final String TRAN_TYPE_MONEYIN		= "TRT01";
	public static final String TRAN_TYPE_MONEYOUT		= "TRT02";
			
	public static final String BET_NOTICE_READY			= "BTN01";
	public static final String BET_NOTICE_COMMIT		= "BTN02";
	
	public static final String USER_GRADE_NORMAL		= "1";
	public static final String USER_GRADE_VIP			= "10";
	public static final String USER_GRADE_ADMIN			= "100";
	
	public static final String USER_STATUS_NORMAL	 	= "US001";
	public static final String USER_STATUS_SECEDE_REQ 	= "US002";
	public static final String USER_STATUS_SECEDE		= "US003";
	
	public static final String BET_STATUS_RUN			= "BS001";
	public static final String BET_STATUS_SUCCESS		= "BS002";
	public static final String BET_STATUS_FAILURE		= "BS003";
	public static final String BET_STATUS_CANCEL		= "BS004";
//	public static final String BET_STATUS_NOMATCH		= "BS005";
//	public static final String BET_STATUS_COMMIT		= "BS006";
//	public static final String BET_STATUS_HANDYDRAW		= "BS007";
	public static final String BET_STATUS_RETURN		= "BS008";
	
	public static final String RESULT_STATUS_RUN		= "RS001";
	public static final String RESULT_STATUS_SUCCESS	= "RS002";
	public static final String RESULT_STATUS_FAILURE	= "RS003";
	public static final String RESULT_STATUS_DRAW		= "RS004";
	public static final String RESULT_STATUS_CANCEL		= "RS005";
	
	public static final String BET_CALC_DISABLE			= "BTC01";
	public static final String BET_CALC_ENABLE			= "BTC02";
	public static final String BET_CALC_COMMIT			= "BTC10";
	
	public static final String GAME_STATUS_READY		= "GS002";
	public static final String GAME_STATUS_RUN			= "GS003";
	public static final String GAME_STATUS_END			= "GS004";
	public static final String GAME_STATUS_CANCEL		= "GS005";
	public static final String GAME_STATUS_DELETE		= "GS006";
	
	public static final String MONEY_IN_REQUEST			= "MC001";
	public static final String MONEY_IN_SUCCESS			= "MC002";
	public static final String MONEY_IN_CANCEL			= "MC003";
	public static final String MONEY_IN_DIRECT			= "MC004";
	public static final String MONEY_IN_CANCEL_TIMEOUT	= "MC005";
	
	public static final String MONEY_OUT_REQUEST	= "ME001";
	public static final String MONEY_OUT_SUCCESS	= "ME002";
	public static final String MONEY_OUT_CANCEL		= "ME003";
	public static final String MONEY_OUT_DIRECT		= "ME004";
	
	public static final String BANKBOOK_STATUS_NORMAL	= "BBS01";
	public static final String BANKBOOK_STATUS_UNUSED	= "BBS02";
	
	public static final String ACCOUNT_TYPE_BETTING		= "AT001";
	public static final String ACCOUNT_TYPE_JACKPOT		= "AT002";
	public static final String ACCOUNT_TYPE_MONEYIN		= "AT003";
	public static final String ACCOUNT_TYPE_MONEYOUT	= "AT004";
	public static final String ACCOUNT_TYPE_BETCANCEL	= "AT005";
	public static final String ACCOUNT_TYPE_NOMATCH		= "AT006";
	public static final String ACCOUNT_TYPE_MONEYIN_DIRECT		= "AT007";
	public static final String ACCOUNT_TYPE_MONEYOUT_DIRECT		= "AT008";
	public static final String ACCOUNT_TYPE_HANDYDRAW	= "AT009";
	public static final String ACCOUNT_TYPE_POINTCHARGE	= "AT010";
	public static final String ACCOUNT_TYPE_MONEYOUT_CANCEL	= "AT011";
	public static final String ACCOUNT_TYPE_BETTING_RETURN = "AT012";
	public static final String ACCOUNT_TYPE_BONUS		= "AT013";
	
	public static final String POINT_TYPE_MONEYIN		= "PNT01";
	public static final String POINT_TYPE_BETTING		= "PNT02";
	public static final String POINT_TYPE_BONUS			= "PNT03";
	public static final String POINT_TYPE_CASHCHARGE	= "PNT10";
	
	public static final String BETTING_STATUS_ACCEPT	= "BTS01";
	public static final String BETTING_STATUS_DENY		= "BTS02";
	
	public static final String GAME_DISPLAY_OPEN		= "GMD01";
	public static final String GAME_DISPLAY_CLOSE		= "GMD02";
	
	public static final String BOARDITEM_TYPE_NOTICE		= "BIT01";
	public static final String BOARDITEM_TYPE_USER			= "BIT10";
	
	public static final String BOARDITEM_STATUS_NORMAL		= "BIS01";
	public static final String BOARDITEM_STATUS_REMOVE		= "BIS03";
	
	public static final String REUSE_COMMENT_QNA			= "RUC01";
	public static final String REUSE_COMMENT_GAME			= "RUC02";
	
	public static final String ACCESS_USER_LOGIN			= "ACC01";
	public static final String ACCESS_ADMIN_LOGIN			= "ACC02";
	public static final String ACCESS_INSPECTION			= "ACC10";
	
	static 
	{
		put(TRAN_TYPE_MONEYIN, "입금");
		put(TRAN_TYPE_MONEYOUT, "출금");
		
		put(POINT_TYPE_MONEYIN, "충전포인트지급");
		put(POINT_TYPE_BETTING, "배팅포인트지급");
		put(POINT_TYPE_BONUS, "보너스포인트지급");
		put(POINT_TYPE_CASHCHARGE, "캐쉬충전차감");
		
		put(BET_CALC_DISABLE, "정산불가");
		put(BET_CALC_ENABLE, "정산가능");
		put(BET_CALC_COMMIT, "정산완료");
		
		put(BOARDITEM_STATUS_NORMAL, "정상");
		put(BOARDITEM_STATUS_REMOVE, "삭제");
		
		put(BOARDITEM_TYPE_NOTICE, "공지");
		put(BOARDITEM_TYPE_USER, "일반");
		
		put(BETTING_STATUS_ACCEPT, "배팅");
		put(BETTING_STATUS_DENY, "마감");
		
		put(GAME_DISPLAY_CLOSE, "미표시");
		put(GAME_DISPLAY_OPEN, "표시");
		
		put(ACCOUNT_TYPE_BETTING, "배팅출금");
		put(ACCOUNT_TYPE_JACKPOT, "배팅당첨");
		put(ACCOUNT_TYPE_MONEYIN, "머니충전");
		put(ACCOUNT_TYPE_MONEYOUT, "머니환전");
		put(ACCOUNT_TYPE_BETCANCEL,"배팅취소(환불)");
		put(ACCOUNT_TYPE_NOMATCH, "게임취소(환불)");
		put(ACCOUNT_TYPE_MONEYIN_DIRECT, "직충전");
		put(ACCOUNT_TYPE_MONEYOUT_DIRECT, "직차감");
		put(ACCOUNT_TYPE_HANDYDRAW, "무승부(환불)");
		put(ACCOUNT_TYPE_POINTCHARGE, "포인트충전");
		put(ACCOUNT_TYPE_MONEYOUT_CANCEL, "환전취소(환불)");
		put(ACCOUNT_TYPE_BETTING_RETURN, "배팅취소(환불)");
		put(ACCOUNT_TYPE_BONUS, "보너스");
		
		put(BANKBOOK_STATUS_NORMAL, "정상");
		put(BANKBOOK_STATUS_UNUSED, "사용중지");
		
		put(MONEY_IN_REQUEST, "충전요청");
		put(MONEY_IN_SUCCESS, "충전성공");
		put(MONEY_IN_CANCEL, "충전취소");
		put(MONEY_IN_DIRECT, "직충전");
		put(MONEY_IN_CANCEL_TIMEOUT, "시간초과");
		
		put(MONEY_OUT_REQUEST, "환전요청");
		put(MONEY_OUT_SUCCESS, "환전성공");
		put(MONEY_OUT_CANCEL, "환전취소");
		put(MONEY_OUT_DIRECT, "직차감");
		
		put(GAME_STATUS_READY, "경기대기");
		put(GAME_STATUS_RUN, "경기진행");
		put(GAME_STATUS_END, "경기종료");
		put(GAME_STATUS_CANCEL, "경기취소");
		put(GAME_STATUS_DELETE, "삭제");
		
		put(BET_STATUS_RUN, "진행중");
		put(BET_STATUS_SUCCESS, "당첨");
		put(BET_STATUS_FAILURE, "미당첨");
		put(BET_STATUS_CANCEL, "배팅취소(환불)");
//		put(BET_STATUS_NOMATCH, "경기취소(환불)");
//		put(BET_STATUS_COMMIT, "정산완료");
//		put(BET_STATUS_HANDYDRAW, "무승부(환불)");
		put(BET_STATUS_RETURN, "무승부(환불)");
		
		put(RESULT_STATUS_DRAW, "무승부");
		put(RESULT_STATUS_FAILURE, "미적중");
		put(RESULT_STATUS_SUCCESS, "적중");
		put(RESULT_STATUS_RUN, "진행중");
		put(RESULT_STATUS_CANCEL, "경기취소");

		put(USER_GRADE_NORMAL, "일반");
		put(USER_GRADE_VIP, "VIP");
		put(USER_GRADE_ADMIN, "관리자");
		
		
		put(USER_STATUS_NORMAL, "정상");
		put(USER_STATUS_SECEDE_REQ, "탈퇴요청");
		put(USER_STATUS_SECEDE, "탈퇴");
		
		put("W", "승");
		put("D", "무");
		put("L", "패");
		
		put("wdl", "승무패");
		put("handy", "핸디캡");
		
		put(REUSE_COMMENT_QNA, "고객센터댓글");
		put(REUSE_COMMENT_GAME, "게임공지");
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

