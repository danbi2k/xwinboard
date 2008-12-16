
<%
'	Option Explicit
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.expires = -1
	Response.buffer = true
	
	Server.ScriptTimeOut = 90000
%>	
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<%
	Dim arrName(40), arrValue(40)
	
	IntIdx		= Request("Idx")
	flag		= Request("flag")
	ScFlag		= Request("ScFlag")
	goPage		= "List.asp"
	If ScFlag = "2" Then goPage = "CloseList.asp"
'	Response.Write goPage
'	Response.End

'	arrName(0)	= "year"		: arrValue(0)	= reString(Request("year"),"sql")
'	arrName(1)	= "mon"			: arrValue(1)	= reString(Request("mon"),"sql")
'	arrName(2)	= "day"			: arrValue(2)	= reString(Request("day"),"sql")
'	arrName(3)	= "hour"		: arrValue(3)	= reString(Request("hour"),"sql")
'	arrName(4)	= "min"			: arrValue(4)	= reString(Request("min"),"sql")
	arrName(5)	= "gName"		: arrValue(5)	= reString(Request("gName"),"sql")
	arrName(6)	= "League"		: arrValue(6)	= reString(Request("League"),"sql")
	arrName(7)	= "hTname"		: arrValue(7)	= reString(Request("hTname"),"sql")
	
	arrName(8)	= "hAllot"		: arrValue(8)	= reString(Request("hAllot"),"sql")
	arrName(9)	= "hCap"		: arrValue(9)	= reString(Request("hCap"),"sql")
	arrName(10)	= "HcapAllotl"	: arrValue(10)	= reString(Request("HcapAllotl"),"sql")
	arrName(11)	= "vTname"		: arrValue(11)	= reString(Request("vTname"),"sql")
	arrName(12)	= "vAllot"		: arrValue(12)	= reString(Request("vAllot"),"sql")
	arrName(13)	= "rtel"		: arrValue(13)	= reString(Request("rtel"),"sql")
	arrName(14)	= "gsDate"		: arrValue(14)	= reString(Request("year"),"sql") &"-"& reString(Request("mon"),"sql") &"-"& reString(Request("day"),"sql") &" "& reString(Request("hour"),"sql") &":"& reString(Request("min"),"sql")
	arrName(15)	= "Sect"		: arrValue(15)	= reString(Request("Sect"),"sql")
	arrName(16)	= "Status"		: arrValue(16)	= reInt(Request("Status"),1)
	arrName(17)	= "hcont"		: arrValue(17)	= Request("hcont")
	arrName(18)	= "vcont"		: arrValue(18)	= Request("vcont")
	arrName(21)	= "event"		: arrValue(21)	= Request("event")
	arrName(22)	= "gResult"		: arrValue(22)	= Request("gResult")
	
	
'	Response.Write arrValue(15)
'	Response.end
	If flag <> "DELETE" Then	
		If isNone(arrValue(5)) or isNone(arrValue(6)) or isNone(reString(Request("year"),"sql")) or isNone(reString(Request("mon"),"sql")) or isNone(reString(Request("day"),"sql")) or isNone(reString(Request("hour"),"sql")) or isNone(reString(Request("min"),"sql")) 	Then Call descment("필수정보 공백","back","")
		If not isDate(arrValue(14)) Then Call descment("경기날짜 형식이 올바르지 않습니다.","back","")
	End If

	If flag = "MODIFY" Then		
		arrName(19)	= "Upflag"		: arrValue(19)	= Request("Upflag")
		arrName(20)	= "UpAllot"		: arrValue(20)	= Request("UpAllot")
		
		Set Rsss = RunSQLReturnRs("SELECT ChangId FROM Game_TB WHERE Idx=" & IntIdx &"")
		If Len(Rsss(0)) < 400 Then
		arrName(23)	= "ChangId"		: arrValue(23)	= Rsss(0) &","& Session("SYS_ID")
		End If
		Rsss.Close : Set Rsss = Nothing
		
		SQL = updateDB("Game_TB", arrName, arrValue) & " WHERE Idx = " & IntIdx &""
'		Response.Write SQL
'		Response.End
		RunSQL(SQL)
		
		
		SQL = updateDB("Game_TB", arrName, arrValue) & " WHERE Idx = " & IntIdx &""
		RunSQL("UPDATE BetGame_TB Set Status='"& arrValue(16) &"', rtel='"& arrValue(13) &"' WHERE gIdx='"& IntIdx &"'")
'		Response.Write SQL
'		Response.End

'		Response.Write arrValue(16) &"<BR>"
'		Response.Write Request("Sect") &"<BR>"
'		Response.End



		If arrValue(21) = 0 Then		' 이벤트 경기아니릴 경우 처리...
			If arrValue(16) = 4 Then	' 경기취소일경우 처리...
				Call GameCanCel(IntIdx)	' 취소처리 함수

				If Request("Sect") = 5 Then		'승무패 경기일 경우 자동마감처리...
					If arrValue(22) <> 0 Then	'경기결과가 경기중이 아닐떄 자동마감처리...
						Call GameAutoClose(IntIdx)
					End If
				End If
					
			Else	
				If Request("Sect") = 5 Then		'승무패 경기일 경우 자동마감처리...
					If arrValue(22) <> 0 Then	'승무패 이고 이벤트 경기가 아닐경우 경기결과가 경기중이 아닐떄 자동마감처리...
						Call GameAutoClose2(IntIdx, reInt(arrValue(22),0))
					End If
					
				End If
			End If
			
		Else	' 이벤트 경기처리...
			If Request("Sect") = 5 Then		'승무패 경기일 경우 자동마감처리...
				If arrValue(22) <> 0 Then	'경기결과가 경기중이 아닐떄 자동마감처리...
					Call GameAutoClose2Event(IntIdx, reInt(arrValue(22),0))
				End If
			End If
		
		End If
		
		Call CloseDB() : Call descment("","Write.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("goPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&KD1="& Request("KD1") &"&KD2="& Request("KD2") &"&Sect="& Request("Sect") &"&Idx="& Request("Idx") &"&flag="& Request("flag") &"&ScFlag="& ScFlag,"")	
		
	ElseIf flag = "DELETE" Then	
		SQL = "DELETE FROM Game_TB WHERE Idx='"& Request("Idx") &"'"
		SQLKor = "DELETE FROM Game_TB WHERE RefIdx='"& Request("Idx") &"'"
		RunSQL(SQL)
'		RunSQLKor(SQLKor)
		Call descment("삭제되었습니다.",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Classs="& Request("Classs") &"&Sect="& Request("Sect") &"&ScFlag="& ScFlag,"")	
	
	Else
		
		SQL = insertDB("Game_TB", arrName, arrValue)
		RunSQL(SQL)

		Set objRs = RunSQLReturnRs("SELECT Max(Idx) FROM Game_TB ")
		RefIdx = objRs(0)

		arrName(24)	= "RefIdx"		: arrValue(24)	= RefIdx
'		Response.Write SQL
'		Response.End
'		SQLVip = insertDB("Game_TB", arrName, arrValue)
'		RunSQLKor(SQLVip)
		
		Call CloseDB() : Call descment("",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&KD1="& Request("KD1") &"&KD2="& Request("KD2") &"&Sect="& Request("Sect") &"&ScFlag="& ScFlag,"")	
				
	End If
	Call CloseDB()	
%>
