
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	statusVals	= Request("statusVals")
	flag		= Request("flag")
	goPage		= Request("ThisPage")
	Response.Write flag&"<BR>"
	Response.end
	
	If flag = "1" Then
		For Each selcheck In Request("selcheck")
			RunSQL("UPDATE BetGame_TB Set VisbledBL=1 WHERE gIdx='"& Trim(selcheck) &"'")
			RunSQL("UPDATE SumBetGame_TB Set VisbledBL=1 WHERE gIdx='"& Trim(selcheck) &"'")
'			SQL = "DELETE BetGame_TB WHERE gIdx='"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
'			RunSQL(SQL)
		Next
		Call CloseDB()
	
	ElseIf flag = "2" Then
		For Each selcheck In Request("selcheck")
			RunSQL("UPDATE BetGame_TB Set VisbledBN=1 WHERE gCnt='"& Trim(selcheck) &"'")
			RunSQL("UPDATE SumBetGame_TB Set VisbledBN=1 WHERE gCnt='"& Trim(selcheck) &"'")
'			SQL = "DELETE BetGame_TB WHERE gCnt='"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
'			RunSQL(SQL)
		Next
		Call CloseDB()
		
	ElseIf flag = "3" Then
		For Each selcheck In Request("selcheck")
			RunSQL("UPDATE BetGame_TB Set VisbledDBN=1 WHERE convert(varchar(10),WriteDay,120 )='"& Trim(selcheck) &"'")
			RunSQL("UPDATE SumBetGame_TB Set VisbledDBN=1 WHERE convert(varchar(10),WriteDay,120 )='"& Trim(selcheck) &"'")
'			SQL = "DELETE BetGame_TB WHERE convert(varchar(10),WriteDay,120 )='"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
'			RunSQL(SQL)
		Next
		Call CloseDB()
	End If
	
	Call descment("",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Sect="& Request("Sect") ,"")		
%>
