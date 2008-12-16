
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
		If isNone(Session("UId")) Then Call descment("","/","")
		
		strId	= Session("UId")
		APoint	= replace(Session("APoint"),",","")
		strIp	= Request.ServerVariables("REMOTE_ADDR")
		If isNone(APoint) or isNone(strId)  Then Call descment("","/","")
		If Not isInt(APoint) Then Call descment("","/","")				
		If reInt(Session("APoint"),0) < 20000 Then Call descment("포인트를 캐쉬로 전환은 20,000 이상일떄 전환됩니다","back","")		
		
		Call CashChange(strId, APoint, 5, 5, "포인트 캐쉬전환","")
				
		Session("APoint") = 0
		Session("UPoint") = NowMileage(Id, "Point")
		Call CloseDB() : Call descment("감사합니다. 전환 완료되었습니다.","/","")
	
%>