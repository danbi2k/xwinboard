
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
	
	
'	Response.Write cIdx
'	Response.end


	If flag = "CHECKDEL" Then		
		For Each selcheck In Request("selcheck")
			SQL = "DELETE FROM Game_TB WHERE Idx = '"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		Next
		Call descment("","CloseList.asp?CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KeyField="&Request("KeyField")&"&KeyWord="&Request("KeyWord")&"&Sect="&Request("Sect") ,"")
			
	End If
	Call CloseDB()	
%>
