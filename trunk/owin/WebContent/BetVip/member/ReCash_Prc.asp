
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
		If isNone(Session("UId")) Then Call descment("","/","")
		
		Id		= Session("UId")
		cash	= reString(Request.Form("cash"),"sql")
		cash	= replace(cash,",","")
		Depos	= reString(Request.Form("Depos"),"sql")
		strIp	= Request.ServerVariables("REMOTE_ADDR")
		If isNone(cash) or isNone(Depos)  Then Call descment("","/","")
		If Not isInt(cash) Then Call descment("","/","")				
		
		
		SQL = "INSERT INTO Cash_TB (Id,RCash,Depos,Ip) VALUES('"& Id &"','"& cash &"','"& Depos &"','"& strIp &"')"
'		Response.Write SQL
		RunSQL(SQL)
'		Response.End
		Call CloseDB() : Call descment("감사합니다. 신청 완료되었습니다.","/","")
	
%>