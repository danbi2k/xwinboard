
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	Dim arrName(40), arrValue(40)
	
	IntIdx		= Request("Idx")
	flag		= Request("flag")
	cIdx		= Request("cIdx")
	rMoney		= Request("rMoney")
	ResuFlag	= Request("ResuFlag")
	
	
'	Response.Write cIdx
'	Response.end


	If flag = "MODIFY" Then		
		RunSQL("UPDATE BetGame_TB Set rMoney="& rMoney &", ResuFlag="& ResuFlag &" WHERE Idx='"& cIdx &"'")
'		Response.Write SQL
'		Response.End		
		Call CloseDB() : Call descment("","bMem.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
		
	ElseIf flag = "DELETE" Then	
	
		RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& IntIdx &"'")
		Call descment("삭제되었습니다.","bMem.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect"),"")	
	
	Else
		
		SQL = insertDB("Game_TB", arrName, arrValue)
'		Response.Write SQL
'		Response.End
		RunSQL(SQL)
		
		Call CloseDB() : Call descment("","List.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&KD1="& Request("KD1") &"&KD2="& Request("KD2") &"&Sect="& Request("Sect"),"")	
				
	End If
	Call CloseDB()	
%>
