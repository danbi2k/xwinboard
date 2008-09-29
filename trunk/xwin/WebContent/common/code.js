var CODE_TABLE = new Object();
CODE_TABLE["GS001"] =  "준비중";
CODE_TABLE["GS002"] = "접수중";
CODE_TABLE["GS003"] = "진행중";
CODE_TABLE["GS004"] = "종료";
CODE_TABLE["GS005"] = "경기취소";

CODE_TABLE["BS001"] = "진행중";
CODE_TABLE["BS002"] = "적중";
CODE_TABLE["BS003"] = "실패";
CODE_TABLE["BS004"] = "환불(취소)";
CODE_TABLE["BS005"] = "경기취소";

CODE_TABLE["W"] = "승";
CODE_TABLE["D"] = "무";
CODE_TABLE["L"] = "패";

function C(key)
{
	var value =  CODE_TABLE[key];
	if (value == undefined)
		value = "";
	return value;
}