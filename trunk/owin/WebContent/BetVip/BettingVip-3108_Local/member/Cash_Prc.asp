
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
		If isNone(Session("UId")) Then Call descment("","/","")
		
		Id		= Session("UId")
		cash	= reString(Request.Form("cash"),"sql")
		cash	= replace(cash,",","")
		cash	= reInt(cash,0)
		
		Depos	= reString(Request.Form("Depos"),"sql")
		flag	= reInt(Request.Form("flag"),0)
		bank01	= reString(Request.Form("bank01"),"sql")
		bank02	= reString(Request.Form("bank02"),"sql")
		Depos	= reString(Request.Form("Depos"),"sql")
		
		If isNone(cash) Then Call descment("","/","")
		If Not isInt(cash) Then Call descment("","/","")
		
		
		If flag=1 Then 'ȯ����û
			Session("UPoint") = NowMileage(Id, "Point")
			If reInt(Session("UPoint"),0) < cash Then Call descment("�߸��� ��û�Դϴ�.","/","")				
		
			SQL = "INSERT INTO Cash_TB (Id, TCash, ResultCash, RCash, Depos, Type, BankName, BankCode, Comment) "
			SQL = SQL &" VALUES('"& Id &"','"& Session("UPoint") &"','"& Session("UPoint")-cash &"','"& cash &"','"& Depos &"','"& flag &"','"& bank01 &"','"& bank02 &"','ȯ����û �� ȯ��')"
			RunSQL(SQL)
			Call MileageChange(Id, cash, 1 )
			Session("UPoint") = NowMileage(Id, "Point")
			
			
		Else
		
			If isNone(Depos) Then Call descment("�Ա��� �̸��� �Է��ϼ���.","back","")
			TCash = NowMileage(Id, "Point")
			SQL = "INSERT INTO Cash_TB (Id, RCash, Depos, Type, BankName, BankCode, ResultCash, Comment) VALUES('"& Id &"','"& cash &"','"& Depos &"','"& flag &"','"& bank01 &"','"& bank02 &"','"& TCash &"','������û')"
		End If
		
	
'		Response.Write SQL
		RunSQL(SQL)
'		Response.End
		
		Call CloseDB() : Call descment("�����մϴ�. ��û �Ϸ�Ǿ����ϴ�.","/","")
	
%>