var CODE_TABLE = new Object();
CODE_TABLE["GS002"] = "경기대기";
CODE_TABLE["GS003"] = "경기진행";
CODE_TABLE["GS004"] = "경기종료";
CODE_TABLE["GS005"] = "경기취소";

CODE_TABLE["BTS01"] = "배팅";
CODE_TABLE["BTS02"] = "마감";

CODE_TABLE["BS001"] = "진행중";
CODE_TABLE["BS002"] = "당첨";
CODE_TABLE["BS003"] = "미당첨";
CODE_TABLE["BS004"] = "취소<br>(환불)";
CODE_TABLE["BS005"] = "배팅취소<br>(환불)";
CODE_TABLE["BS006"] = "정산완료";
CODE_TABLE["BS007"] = "무승부<br>(환불)";
CODE_TABLE["BS008"] = "배팅취소<br>(환불)";

CODE_TABLE["W"] = "승";
CODE_TABLE["D"] = "무";
CODE_TABLE["L"] = "패";

CODE_TABLE["US001"] = "정상";
CODE_TABLE["US002"] = "탈퇴요청";
CODE_TABLE["US003"] = "탈퇴";

function C(key)
{
	var value =  CODE_TABLE[key];
	if (value == undefined)
		value = "";
	return value;
}