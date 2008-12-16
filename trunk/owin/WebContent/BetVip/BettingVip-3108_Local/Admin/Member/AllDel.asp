
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	
	IntIdx		= Request("Idx")
	flag		= Request("flag")
	cIdx		= Request("cIdx")
	rMoney		= Request("rMoney")
	ResuFlag	= Request("ResuFlag")
	goldhits	= Request("goldhits")
	ThisPage	= Request("ThisPage")
	
'	Response.Write cIdx
'	Response.end


	If flag = "CHECKDEL" Then
		For Each selcheck In Request("selcheck")
			SQL = "UPDATE Cash_TB Set Visbled=1, ChId='"& Session("SYS_ID") &"', DDay=getDate() WHERE Idx='"& Trim(selcheck) &"'"
'			SQL = "DELETE FROM Cash_TB WHERE Idx = '"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		Next
		Call descment("","CashList.asp?CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KeyField="&Request("KeyField")&"&KeyWord="&Request("KeyWord")&"&Sect="&Request("Sect")&"&KD1="&Request("KD1") ,"")
	
	ElseIf flag = "SUBMEMBERCHECKDEL" Then
		For Each selcheck In Request("selcheck")
			SQL = "DELETE FROM Admin_TB WHERE Idx = '"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		Next
		Call descment("",ThisPage&"?CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KeyField="&Request("KeyField")&"&KeyWord="&Request("KeyWord")&"&Sect="&Request("Sect")&"&KD1="&Request("KD1") ,"")
		
				
	ElseIf flag = "MEMBERCHECKDEL" Then
		For Each selcheck In Request("selcheck")
			SQL = "DELETE FROM Member_TB WHERE Id = '"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		Next
		Call descment("",ThisPage&"?CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KeyField="&Request("KeyField")&"&KeyWord="&Request("KeyWord")&"&Sect="&Request("Sect")&"&KD1="&Request("KD1") ,"")
						
	End If
	Call CloseDB()	
%>
