
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	statusVals	= Request("statusVals")
	flag		= Request("flag")
	Response.Write cIdx
'	Response.end


	If flag = "STATUSCHANGE" Then		

		AstatusVals	= split(statusVals,"@")
		For i=0 To Ubound(AstatusVals)
			BstatusVals	= split(AstatusVals(i),"|")
			If Not isNone(AstatusVals(i)) Then
				SQL = "UPDATE Game_TB Set Status="& BstatusVals(1) &" WHERE Idx='"& BstatusVals(0) &"'"
'				Response.Write SQL&"<BR>"
				RunSQL(SQL)
			End If
		Next



		Call CloseDB() : Call descment("","List.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Sect="& Request("Sect") ,"")	

	End If
%>
