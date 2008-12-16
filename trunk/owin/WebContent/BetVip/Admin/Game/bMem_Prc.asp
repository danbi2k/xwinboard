
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->

<%
	Dim arrName(40), arrValue(40)
	
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	KeyWord		= Request("KeyWord")
	KeyField	= Request("KeyField")
	IntIdx		= Request("Idx")
	Sect		= Request("Sect")
	
	flag		= Request("flag")
	cIdx		= Request("cIdx")
	rMoney		= Request("rMoney")
	ResuFlag	= Request("ResuFlag")
	goldhits	= Request("goldhits")
	allrMoney	= Request("allrMoney")
	allrSult	= Request("allrSult")
	category	= Request("category")
	senum		= Request("senum")
	f_date		= Request("f_date")
	t_date		= Request("t_date")
	pageSize	= Request("pageSize")
	strId		= Request("Id")
	
	goPage		= IfElse(Request("ThisPage"),"bMem.asp")
	
'	Response.Write flag &":flag<BR>"
'	Response.Write strId &":strId<BR>"
'	Response.Write Sect &":Sect<BR>"
'	Response.Write senum &":senum<BR>"
'	Response.Write f_date &":f_date<BR>"
'	Response.Write t_date &":t_date<BR>"
'	Response.Write goPage &":pageSize<BR>"
'	Response.end


	If flag = "MODIFY" Then		
		RunSQL("UPDATE BetGame_TB Set rMoney="& rMoney &", ResuFlag="& ResuFlag &" WHERE Idx='"& cIdx &"'")
'		Response.Write SQL
'		Response.End		
		Call CloseDB() : Call descment("",goPage&"?CurPage="& CurPage &"&CurBlock="& CurBlock &"&goPage="& CurPage &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&Idx="& IntIdx &"&Sect="& Sect ,"")	
		
	ElseIf flag = "DELETE" Then	
		If Sect = "0" Then
			RunSQL("UPDATE BetGame_TB Set Visbled=1, UHiden=1, VisbledBL=1, VisbledBN=1, VisbledDBN=1 WHERE gCnt='"& IntIdx &"'")
			RunSQL("UPDATE SumBetGame_TB Set VisbledBL=1, VisbledBN=1, VisbledDBN=1 WHERE gCnt='"& IntIdx &"'")
'			RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& IntIdx &"'")
		Else
'			RunSQL("UPDATE BetGame_TB Set Visbled=1, UHiden=1 WHERE gCnt='"& IntIdx &"'")
			RunSQL("UPDATE BetGame_TB Set Visbled=1 WHERE gCnt='"& IntIdx &"'")
		End If
		Call descment("삭제되었습니다.",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& CurBlock &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&Idx="& IntIdx &"&Sect="& Sect,"")	

	ElseIf flag = "HITUPDATE" Then			'적중유무 일괄변경
'		Response.Write goldhits &":GODHIT<BR>"
'		Response.Write allrMoney &":MONEY<BR>"
'		Response.Write allrSult &":RESULT<BR>"
		
		Agoldhits	= split(goldhits,"@")
		ArMoney		= split(allrMoney,"@")
		ArSult		= split(allrSult,"@")
'		Response.Write Ubound(ArMoney) &":MONEY<BR>"
'		Response.End		
		For i=0 To Ubound(Agoldhits)	'적중유무 일괄변경
			Bgoldhits	= split(Agoldhits(i),"|")
			If Not isNone(Agoldhits(i)) Then
				SQL = "UPDATE BetGame_TB Set GoldHit="& Bgoldhits(1) &" WHERE Idx='"& Bgoldhits(0) &"'"
'				Response.Write SQL&"<BR>"
				RunSQL(SQL)
			End If
		Next
		
		
'		For i=0 To Ubound(ArMoney)	' 적중금액 일괄변경
'			BrMoney	= split(ArMoney(i),"|")
'			If Not isNone(ArMoney(i)) Then
'				rMoney	= replace(BrMoney(1),",","")
'				RunSQL("UPDATE BetGame_TB Set rMoney="& rMoney &" WHERE gCnt='"& BrMoney(0) &"'")
'				
'				strId = ""
'				Set Rss = RunSQLReturnRs("SELECT TOP 1 Id FROM BetGame_TB WHERE gCnt='"& BrMoney(0) &"'")
'				If Not ( Rss.EOF or Rss.BOF ) Then strId = Rss("Id")
'				
'				If Not isNone(strId) Then
'					If reInt(rMoney,0) > 0 Then
'						Call CashChange(strId,reInt(rMoney,0),3,1,"배팅적중 적립")
'					End If
'				End If		
'				strId = ""
'				Response.Write SQL&"<BR>"
				
'			End If
'		Next	

		
		
		
		Call descment("",goPage&"?CurPage="& CurPage &"&CurBlock="& CurBlock &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&Idx="& IntIdx &"&Sect="& Sect &"&Id="& strId &"&senum="& senum &"&f_date="& f_date &"&t_date="& t_date,"")


	ElseIf flag = "HITUPDATERESULT" Then			'전산 전,후 유무 일괄변경
'		Response.Write goldhits &":GODHIT<BR>"
'		Response.Write allrMoney &":MONEY<BR>"
'		Response.Write allrSult &":RESULT<BR>"
		
		Agoldhits	= split(goldhits,"@")
		ArMoney		= split(allrMoney,"@")
		ArSult		= split(allrSult,"@")
		
		For i=0 To Ubound(ArSult)	' 전산 전,후 유무 일괄변경
			BrSult	= split(ArSult(i),"|")
			If Not isNone(ArSult(i)) Then
				SQL = "UPDATE BetGame_TB Set ResuFlag="& BrSult(1) &" WHERE gCnt='"& BrSult(0) &"'"
'				Response.Write SQL&"<BR>"
				RunSQL(SQL)
			End If
		Next
				
'		Response.Write Ubound(ArMoney) &":MONEY<BR>"
'		Response.End		
'		For i=0 To Ubound(ArMoney)	' 적중금액 일괄변경
'			BrMoney	= split(ArMoney(i),"|")
'			If Not isNone(ArMoney(i)) Then
'				rMoney	= replace(BrMoney(1),",","")
'				RunSQL("UPDATE BetGame_TB Set rMoney="& rMoney &" WHERE gCnt='"& BrMoney(0) &"'")
'				
'				strId = ""
'				Set Rss = RunSQLReturnRs("SELECT TOP 1 Id FROM BetGame_TB WHERE gCnt='"& BrMoney(0) &"'")
'				If Not ( Rss.EOF or Rss.BOF ) Then strId = Rss("Id")
'				
'				If Not isNone(strId) Then
'					If reInt(rMoney,0) > 0 Then
'						Call CashChange(strId,reInt(rMoney,0),3,1,"배팅적중 적립")
'					End If
'				End If		
'				strId = ""
'				Response.Write SQL&"<BR>"
				
'			End If
'		Next	
		
		For i=0 To Ubound(ArMoney)	' 미적중자 2%적립
			BrMoney	= split(ArMoney(i),"|")
			If Not isNone(ArMoney(i)) Then
				HandGame = HandGameMisPointFlag(BrMoney(0))
				If HandGame = 1 Then
					Call GameMisPoint(BrMoney(0))
				End If
				
			End If
		Next
		
		Call descment("",goPage&"?CurPage="& CurPage &"&CurBlock="& CurBlock &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&Idx="& IntIdx &"&Sect="& Sect &"&Id="& strId &"&senum="& senum &"&f_date="& f_date &"&t_date="& t_date,"")
		
				
	ElseIf flag = "RESULTUPDATE" Then		'정산결과 및 적중금액 일괄변경
		results		= Request("results")
		resultVal	= Request("resultVal")

		Aresults	= split(results,"@")
		AresultVal	= split(resultVal,"@")
		
'		Response.Write results &":D<BR>"
'		Response.Write resultVal &":D<BR>"
'		Response.End
				
		For i=0 To Ubound(Aresults)
			Bgoldhits	= split(Aresults(i),"|")
			If Not isNone(Aresults(i)) Then
				SQL = "UPDATE BetGame_TB Set ResuFlag="& Bgoldhits(1) &" WHERE gCnt='"& Bgoldhits(0) &"'"
'				Response.Write SQL&"<BR>"
				RunSQL(SQL)
			End If
		Next
		
'		Response.Write SQL&"<BR><BR>"
		For i=0 To Ubound(AresultVal)
			Bgoldhits	= split(AresultVal(i),"|")
			If Not isNone(Aresults(i)) Then
				SQL = "UPDATE BetGame_TB Set rMoney="& reInt(replace(Bgoldhits(1),",",""),0) &" WHERE gCnt='"& Bgoldhits(0) &"'"
'				Response.Write SQL&"<BR>"
				RunSQL(SQL)
			End If
		Next		
'		Call descment("",goPage&"?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect"),"")		
	
'	Else
		
'		SQL = insertDB("Game_TB", arrName, arrValue)
'		Response.Write SQL
'		Response.End
'		RunSQL(SQL)
		
'		Call CloseDB() : Call descment("","List.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&KD1="& Request("KD1") &"&KD2="& Request("KD2") &"&Sect="& Request("Sect"),"")
				
	End If
	Call CloseDB()	
%>
