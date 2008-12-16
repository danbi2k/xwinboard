
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	statusVals	= Request("statusVals")
	flag		= Request("flag")
	goPage		= IfElse(Request("ThisPage"),"bMem.asp")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
'	Response.Write goPage
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
		Call CloseDB() : Call descment("",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
		
	ElseIf flag = "SELECTDELETE" Then		

		For Each selcheck In Request("selcheck")
			SQL = "DELETE Game_TB WHERE Idx='"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		Next
		Call CloseDB() : Call descment("",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Sect="& Request("Sect") ,"")	

	ElseIf flag = "BMEMDELETE" Then
			Mdflag	= Request("Mdflag")	' 정산완료 삭제시 회원까지 삭제할지 여부 (1:삭제)
			SQL = "UPDATE BetGame_TB Set Visbled=1"& Mdflag &" WHERE convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& Request("f_date") &"',120 ) And convert(varchar(10),'"& Request("t_date") &"',120 ) "
			If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" = '"& KeyWord &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		Call CloseDB() : Call descment("",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Sect="& Request("Sect") ,"")	

	End If
%>
