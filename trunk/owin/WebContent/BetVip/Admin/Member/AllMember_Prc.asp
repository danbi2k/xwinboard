
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	
	IntIdx		= Request("Idx")
	flag		= Request("flag")
	vipFlag		= Request("vipFlag")
	
	
'	Response.Write cIdx
'	Response.end


	If flag = "ALLCHANGEDOMAIN" Then		
		For Each selcheck In Request("selcheck")


			If Request("VipFlag") = "okbet365.com" Then

				SQLs = "SELECT * FROM Member_TB WHERE Id = '"& Trim(selcheck) &"'"
				Set objRs = RunSQLReturnRS(SQLs)
				If Not objRs.EOF or Not objRs.BOF Then
					strId	= objRs("Id")	: strName	= objRs("Name")
					strPwd	= objRs("Pwd")	: strCell	= objRs("Cell")
					strMail	= objRs("Mail") : IntPoint	= objRs("Point")
				End If
				objRs.Close() : Set objRs = Nothing
				
				If Not isNone(strId) And Not isNone(strName) And Not isNone(strPwd) Then					
					SQLsVip = "SELECT Id FROM Member_TB WHERE Id = '"& strId &"'"
					Set objRsVip = RunSQLReturnRSKor(SQLs)
					
					If objRsVip.EOF or objRsVip.BOF Then
'						SQLVIP = "INSERT INTO Member_TB(Id, Name, Pwd, Cell, Mail, Point, VipFlag) VALUES('"& reString(strId,"sql") &"','"& reString(strName,"sql") &"','"& reString(strPwd,"sql") &"','"& reString(strCell,"sql") &"','"& reString(strMail,"sql") &"','"& reString(IntPoint,"sql") &"', '"& Request("VipFlag") &"')"
						SQLVIP = "INSERT INTO Member_TB(Id, Name, Pwd, Cell, Mail, VipFlag) VALUES('"& reString(strId,"sql") &"','"& reString(strName,"sql") &"','"& reString(strPwd,"sql") &"','"& reString(strCell,"sql") &"','"& reString(strMail,"sql") &"', '"& Request("VipFlag") &"')"
						RunSQLKor(SQLVIP)
					Else
'						Call descment(strId&" 회원은 이미 VIP회원으로 등록된 회원입니다","back","")
						SQLVIP = "UPDATE Member_TB Set VipFlag='"& Request("VipFlag") &"' WHERE Id = '"& reString(strId,"sql") &"'"
					End If

					objRsVip.Close() : Set objRsVip = Nothing
				End If
				
			End If

			SQL = "UPDATE Member_TB Set VipFlag='"& Request("VipFlag") &"' WHERE Id = '"& Trim(selcheck) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)

		Next
		Call descment("","MemberList.asp?CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KeyField="&Request("KeyField")&"&KeyWord="&Request("KeyWord")&"&Sect="&Request("Sect") ,"")
			
	End If
	Call CloseDB()	
%>
