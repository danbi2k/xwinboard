<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/GameClass.asp	-->

<%
	Dim arrName(40), arrValue(40)
	betmoney	= Request.Form("betmoney")
	amount		= Request.Form("amount")		'īƮ�� ��� ���� ���� ���ý� �Ӵ�
	gCnt		= Request.Form("gCnt")
	mode		= Request("mode")
	thispage	= Request("thispage")
	Sect		= Request("Sect")
'	Response.Write "mode:"& mode &"<BR>"
'	Response.End
	
'	refUrl = Request.servervariables("HTTP_REFERER")
'	refUrl = replace(refUrl,"http://","")
'	refUrl = mid(refUrl,1,instr(refUrl,"/")-1)
'	If lcase(refUrl) <> lcase("okbet888.com") Then Call descment("","/","")

	If isNone(Session("UId")) Then Call descment("","/","")
	NowPt	= UsePoints("", Session("UId"), 2)
	If mode = "betting" Then
		If Not isInt(betmoney) Then Call descment("","/","")
	End If 
	If Int(betmoney) > reInt(NowPt,0) Then Call descment("","/","")
	
	
	goPage			= "List.asp"
	If isNone(thispage) Then 
		If Sect="5" Then 
			goPage = "List2.asp"
		End If
	Else
		goPage = "List2.asp"
	End If
	
	
	
	
	If mode = "cart_bet" Then		'ī�忡 ���� �����ϱ�
		arrGCnt	= split(gCnt,",")
'		MaxGcnt = RandomCode()

'	Response.Write "mode:"& mode &"<BR>"
'	Response.End
		
'========================================================================================================		
		'��ü ������� �������� �ݾ� �̱�
		allAllot	= 0
		aHopBmoney	= 0
		For i=0 To Ubound(arrGCnt)		'īƮ�� ��� ������ŭ �����ϴ�.
			Set objRs = RunSQLReturnRs("SELECT Idx FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And gCnt='"& trim(arrGCnt(i)) &"'")
			'īƮ���� �̾ƿɴϴ� ������ü.
			If Not objRs.EOF or Not objRs.BOF Then
				Do Until objRs.EOF
					
					Set objRs1 = RunSQLReturnRs("SELECT b.gIdx, b.gbTem, b.bMoney, g.hAllot, g.vAllot, g.HcapAllotl FROM BetCart_TB b, Game_TB g WHERE b.gIdx=g.Idx And b.Id='"& reString(Session("UId"),"sql") &"' And b.Idx='"& reString(objRs(0),"sql") &"'")
					'īƮ���� �̾ƿɴϴ�. �����ڷ�.
					If Not objRs1.EOF or Not objRs1.BOF Then
						Do Until objRs1.EOF
						
							If CloseGameFlag(objRs1("gIdx")) =0 Then Call descment("�̹� ������ ���ӿ� ���� �ϼ̽��ϴ�.","back","") : Exit For

							If objRs1("gbTem") = 1 Then
								If allAllot = 0 Then 
									allAllot = objRs1("hAllot")
								Else
									allAllot = allAllot * objRs1("hAllot")
								End If
														
							ElseIf objRs1("gbTem") = 2 Then
								If allAllot = 0 Then 
									allAllot = objRs1("vAllot")
								Else
									allAllot = allAllot * objRs1("vAllot")
								End If
														
							ElseIf objRs1("gbTem") = 3 Then
								If allAllot = 0 Then 
									allAllot = objRs1("HcapAllotl")
								Else
									allAllot = allAllot * objRs1("HcapAllotl")
								End If
														
							End If	
													
'							Response.Write allAllot&":allAllot<BR>"
							dbMoney		= reString(objRs1("bMoney"),"sql")
						
						objRs1.MoveNext
						Loop
					End If					
					
				objRs.MoveNext
				Loop
			End If
			Call CloseDB()
		Next
		allAllot	= int(allAllot*100)/100
		aHopBmoney	= Int(allAllot*dbMoney)		
		If isNone(allAllot) or isNone(aHopBmoney) Then Call descment("���������� �ùٸ��� �ʽ��ϴ�.����� �ٽ� ������ �ּ���","/Game/"&goPage&"?Sect="& Sect,"")
		If Not isInt(aHopBmoney) Then Call descment("���������� �ùٸ��� �ʽ��ϴ�.����� �ٽ� ������ �ּ���","/Game/"&goPage&"?Sect="& Sect,"")
		
'		Response.Write allAllot&":allAllot<BR>"
'		Response.Write aHopBmoney&":aHopBmoney<BR>"
'		Response.End
		

		Call InsertCartGame(gCnt, Session("UId"), amount, allAllot, aHopBmoney)
		Call descment("���� ����� ���̺��� ���� Ȯ�� �Ͻ� �� �ֽ��ϴ�.","/Game/"&goPage&"?Sect="& Sect,"")
		
	Else	'�ٷι���
		betcontent		= Request("betcontent")
		AContent		= split(betcontent,chr(13) & chr(10))
		BContent		= split(AContent(0),chr(9))
		'========================================================================================================
		For i=0 To Ubound(AContent)
			If Not isNone(AContent(i)) Then	
				For b=0 To Ubound(BContent)
					If CloseGameFlag(reString(BContent(0),"sql") ) =0 Then Call descment("�̹� ������ ���ӿ� ���� �ϼ̽��ϴ�.","back","") : Exit For
				Next	
			End If
		Next

	'========================================================================================================
		allAllot	= 0
		aHopBmoney	= 0
		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	
				BContent	= ""	
				BContent	= split(AContent(i),chr(9))
				Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")

				If Not objRs.EOF or Not objRs.BOF Then
					If BContent(1) = 1 Then
						If allAllot = 0 Then 
							allAllot = objRs("hAllot")
						Else
							allAllot = allAllot * objRs("hAllot")
						End If
						
					ElseIf BContent(1) = 2 Then
						If allAllot = 0 Then 
							allAllot = objRs("vAllot")
						Else
							allAllot = allAllot * objRs("vAllot")
						End If
						
					ElseIf BContent(1) = 3 Then
						If allAllot = 0 Then 
							allAllot = objRs("HcapAllotl")
						Else
							allAllot = allAllot * objRs("HcapAllotl")
						End If
						
					End If	
					
				End If
				Call CloseDB()	
			End If
		
		Next
	'	Response.Write "<BR><BR>"
	'	Response.Write formatnumber(betmoney,0)&":BM<BR>"
	'	Response.Write formatnumber(allAllot,2)&":AL<BR>"
	'	Response.Write formatnumber(aHopBmoney,[])&":aBM<BR>"
		allAllot	= int(allAllot*100)/100
		aHopBmoney	= Int(allAllot*betmoney)
	'	Response.End
		If isNone(allAllot) or isNone(aHopBmoney) Then Call descment("�߸��� ��û�Դϴ�. ����� �ٽ� ������ �ּ���","/Game/"&goPage&"?Sect="& Sect,"")
		If Not isInt(aHopBmoney) Then Call descment("�߸��� ��û�Դϴ�. ����� �ٽ� ������ �ּ���","/Game/"&goPage&"?Sect="& Sect,"")
		'========================================================================================================
		
		Call InsertDirGame(AContent, Session("UId"), betmoney, allAllot, aHopBmoney)


	'	Set objRs = RunSQLReturnRs("SELECT Id FROM BetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
	'	If Not objRs.EOF or Not objRs.BOF Then
	'		Do Until objRs.EOF
	'			If Trim(objRs("Id")) <> Trim(Session("UId")) Then
	'				RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
	''				Exit Do
	'				Call descment("�߸��� �������� �Դϴ�. �ٽ� ������ �ּ���.","/Game/"&goPage&"?Sect="& Sect,"")
	'			End If
	'		objRs.MoveNext
	'		Loop
	'	End If
		
		Call CloseDB()
		

		
	'	Response.End
		Call descment("���� ����� ���̺��� ���� Ȯ�� �Ͻ� �� �ֽ��ϴ�.","/Game/"&goPage&"?Sect="& Sect,"")
		
	End If
		
%>
