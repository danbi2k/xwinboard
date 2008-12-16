
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%
	strId	= reString(Request("Idd"),"sql")
	strPwd	= reString(Request("Pwdd"),"sql")
	refPage	= Request("refPage")
	SQL = "SELECT sPwd,Ssection FROM Admin_TB WHERE sId='"& strId &"'"
	Set objRs = RunSQLReturnRs(SQL)
	If objRs.EOF or objRs.BOF Then
		Call CloseDB()
		Call descment("일치된 자료를 찾을수 없습니다.","back","")
	Else
		If objRs("sPwd") <> strPwd Then 
			
			Call descment("일치된 자료를 찾을수 없습니다.","back","")
		Else
			Session.Timeout = 1440
			Session("SYS_ID") = strId
			Session("SYS_Ssection") = reInt(objRs("Ssection"),1)
			Call CloseDB()
			If isNone(refPage) Then
				Call descment("","Index.asp","")
			Else
				Call descment("",refPage,"")
			End If
		End If
	End If
	Call CloseDB()
%>
