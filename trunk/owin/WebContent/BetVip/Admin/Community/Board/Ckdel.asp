<!--	#include virtual=/common/asp/Connect.asp		-->
<!--	#include virtual=/common/asp/UtilityClass.asp		-->
<%
TableName	= Request("TableName")
	For Each selcheck In Request("selcheck")
		SQL = "DELETE FROM "& TableName &" WHERE Idx = '"& Trim(selcheck) &"'"
'		Response.Write SQL&"<BR>"
		RunSQL(SQL)
	Next
	Call descment("","List.asp?TableName="&TableName&"&CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KeyField="&Request("KeyField")&"&KeyWord="&Request("KeyWord")&"&Sect="&Request("Sect") ,"")
%>

