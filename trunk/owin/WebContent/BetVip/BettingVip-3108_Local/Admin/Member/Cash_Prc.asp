
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual="/common/asp/MemberClass.asp"		-->
<%
If Session("SYS_Ssection")<>0 Then Call descment("","back","")
	strId	= Request("Id")
	IntIdx	= Request("Idx")
	Cash	= rePlace(Request("Cash"),",","")
	strName	= Request("Name")
	Sect	= Request("Sect")
	flag	= Request("flag")
'	Response.write Cash &":C<BR>"
'	Response.write strId &":C<BR>"
'	Response.write IntIdx &":C<BR>"
'	Response.write flag &":C<BR>"
'	Response.End
	
	
	If flag = "CHECKCASHOUT" Then
	
		For Each selcheck In Request("selcheck")

			SQL = "UPDATE Cash_TB Set Status=1 WHERE Idx='"& Trim(selcheck) &"' "
'			Response.write SQL1 &":SQL<BR>"
			RunSQL(SQL)
		Next
		Call descMent("���� ���� �Ǿ����ϴ�.","CashList.asp?Sect="&Sect&"&CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KD1="&Request("KD1"),"")
		
		
	ElseIf flag = "CHECKCASHOUTUNIT" Then
	
		SQL = "UPDATE Cash_TB Set Status='"& Request("senum") &"' WHERE Idx='"& IntIdx &"' "
'		Response.write SQL1 &":SQL<BR>"
		RunSQL(SQL)
		Call descMent("���� �Ǿ����ϴ�.","CashList.asp?Sect="&Sect&"&CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KD1="&Request("KD1"),"")		
		
		
		
	ElseIf flag = "CHECKCASHIN" Then
		For Each selcheck In Request("selcheck")
			RCash = "" : TCash = "" : strId = ""
			sSQL = " SELECT RCash, Id FROM Cash_TB WHERE Idx='"& Trim(selcheck) &"' "
'			Response.Write sSQL&":sSQL<BR>"
			Set objRs = RunSQLReturnRs(sSQL)
			If Not (objRs.EOF or objRs.BOF) Then : RCash = reInt(objRs("RCash"),0) : strId = reString(objRs("Id"),"sql")
			objRs.Close : Set objRs = Nothing
'			PlusPoint = RCash+(RCash/100)*2
			PlusPoint = RCash
			
			If Not isNone(RCash) or Not isNone(strId) Then 
				Call CashChange2(strId, PlusPoint, 0, 3, "�����Ϸ�", Trim(selcheck))
			End If
			Call CloseDB()
		Next
		Call descMent("���� ���� �Ǿ����ϴ�.","CashList.asp?Sect="&Sect&"&CurPage="&Request("CurPage")&"&CurBlock="&Request("CurBlock")&"&KD1="&Request("KD1"),"")
		
		
		
	Else
		sSQL = " SELECT RCash FROM Cash_TB WHERE Idx='"& IntIdx &"' "
		Set objRs = RunSQLReturnRs(sSQL)
	
		If Not (objRs.EOF or objRs.BOF) Then 			

			Call CashChange2(strId, Cash, 0, 3, "�����Ϸ�", IntIdx)

			Call CloseDB()
			Call descMentPage("���� �Ǿ����ϴ�.","self.close();","opener.location.reload()")
			
		End If
	End If
%>

