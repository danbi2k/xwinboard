
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
		If reInt(Session("APoint"),0) < 20000 Then Call descment("����Ʈ�� ĳ���� ��ȯ�� 20,000 �̻��ϋ� ��ȯ�˴ϴ�","back","")		
		
		Call CashChange(strId, APoint, 5, 5, "����Ʈ ĳ����ȯ","")
				
		Session("APoint") = 0
		Session("UPoint") = NowMileage(Id, "Point")
		Call CloseDB() : Call descment("�����մϴ�. ��ȯ �Ϸ�Ǿ����ϴ�.","/","")
	
%>