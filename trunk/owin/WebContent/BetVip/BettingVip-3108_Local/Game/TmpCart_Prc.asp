<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%


'	Call FromCollection()
	
	Dim arrName(40), arrValue(40)

	mode		= Request("mode")
	gCnt		= Request("gCnt")
	betmoney	= Request("betmoney")
	Sect		= Request("Sect")
	amount		= Request("amount")
	
	goPage		= "List.asp"
'	Response.Write mode
'	Response.End
	
'	refUrl = Request.servervariables("HTTP_REFERER")
'	refUrl = replace(refUrl,"http://","")
'	refUrl = mid(refUrl,1,instr(refUrl,"/")-1)
'	If lcase(refUrl) <> lcase("okbet888.com") Then Call descment("","/","")
	
	If isNone(Session("UId")) Then Call descment("","/","")
	
	If mode = "del_cart" Then
	
		Set objRs = RunSQLReturnRs("SELECT Idx FROM TmpBetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' ")
		If objRs.EOF or objRs.BOF Then
			Call descment("","/Game/TmpCart.asp","")
		Else
			Do Until objRs.EOF
				RunSQL("DELETE FROM TmpBetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' ")
			objRs.MoveNext
			Loop
			Call descment("","/Game/TmpCart.asp","")
		End If
		









	ElseIf mode = "cart_bet" Then
		amount		= Request("amount")	
'		MaxGcnt = RandomCode()
		Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
			MaxGcnt = objRss(0)
		objRss.Close
		
		Set objRs1 = RunSQLReturnRs("SELECT gIdx, gbTem, gIdx, bMoney FROM TmpBetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' ")
		If Not objRs1.EOF or Not objRs1.BOF Then
			Do Until objRs1.EOF
							
				Set objRs2 = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(objRs1("gIdx"),"sql") &"'")
				If Not objRs2.EOF or Not objRs2.BOF Then
					Do Until objRs2.EOF


'========================================================================================================
					allAllot	= 0

					If objRs1("gbTem") = 1 Then
						If allAllot = 0 Then 
							allAllot = objRs2("hAllot")
						Else
							allAllot = allAllot * objRs2("hAllot")
						End If
										
					ElseIf objRs1("gbTem") = 2 Then
						If allAllot = 0 Then 
							allAllot = objRs2("vAllot")
						Else
							allAllot = allAllot * objRs2("vAllot")
						End If
										
					ElseIf objRs1("gbTem") = 3 Then
						If allAllot = 0 Then 
							allAllot = objRs2("HcapAllotl")
						Else
							allAllot = allAllot * objRs2("HcapAllotl")
						End If
										
					End If	
									

				'	Response.Write "<BR><BR>"
				'	Response.Write formatnumber(allAllot,2)&":AL<BR>"
				'	Response.Write formatnumber(betmoney,0)&":BM<BR>"
					allAllot	=  left(allAllot,4)
					aHopBmoney	= Int(allAllot*amount)
				'	Response.Write formatnumber(aHopBmoney,[])&":aBM<BR>"
				 '	Response.End
'========================================================================================================
	
	
	
			allAllot	= getAlot(objRs2("hAllot"), objRs2("vAllot"), objRs2("HcapAllotl"), objRs1("gbTem"))
					arrName(0)	= "Sect"		: arrValue(0)	= reString(objRs2("Sect"),"sql")
					arrName(1)	= "gName"		: arrValue(1)	= reString(objRs2("gName"),"sql")
					arrName(2)	= "gIdx"		: arrValue(2)	= reString(objRs1("gIdx"),"sql")
					arrName(3)	= "Id"			: arrValue(3)	= reString(Session("UId"),"sql")
					arrName(4)	= "gsDate"		: arrValue(4)	= reString(objRs2("gsDate"),"sql")
					arrName(5)	= "League"		: arrValue(5)	= reString(objRs2("League"),"sql")
					arrName(6)	= "hTname"		: arrValue(6)	= reString(objRs2("hTname"),"sql")
					arrName(7)	= "hAllot"		: arrValue(7)	= reString(objRs2("hAllot"),"sql")
					arrName(8)	= "hCap"		: arrValue(8)	= reString(objRs2("hCap"),"sql")
					arrName(9)	= "HcapAllotl"	: arrValue(9)	= reString(objRs2("HcapAllotl"),"sql")
					arrName(10)	= "vTname"		: arrValue(10)	= reString(objRs2("vTname"),"sql")
					arrName(11)	= "vAllot"		: arrValue(11)	= reString(objRs2("vAllot"),"sql")
					arrName(12)	= "bMoney"		: arrValue(12)	= reString(amount,"sql")
					arrName(13)	= "gCnt"		: arrValue(13)	= MaxGcnt
					arrName(14)	= "gbTem"		: arrValue(14)	= reString(objRs1("gbTem"),"sql")
					arrName(15)	= "HaAllot"		: arrValue(15)	= allAllot
					arrName(16)	= "hMoney"		: arrValue(16)	= aHopBmoney
						
					SQL = insertDB("BetGame_TB", arrName, arrValue)
	'				Response.Write SQL&"<BR><BR>"
					RunSQL(SQL)
					betmoney	= amount
							
					objRs2.MoveNext
					Loop
				End If
						
			objRs1.MoveNext
			Loop
			RunSQL("DELETE FROM TmpBetCart_TB WHERE Id='"& Session("UId") &"'")
		End If					
		Call CloseDB()
		
		Call CashChange(Session("UId"), betmoney, 2, 2, "게임베팅 사용")
		Call MileageChange(Session("UId"),betmoney,1)
		Call descment("베팅 결과는 마이베팅 에서 확인 하실 수 있습니다.","/Game/"&goPage&"?Sect=1","")

	
	
	
	
	
	
	
	
	
	Else
	
	
		NowPt	= UsePoints("", Session("UId"), 2)
		If Not isInt(betmoney) Then Call descment("","/","")
		If 0 = reInt(NowPt,0) Then Call descment("","/Game/"&goPage&"?Sect="& Sect,"")

		
		betcontent		= Request("betcontent")
		AContent		= split(betcontent,chr(13) & chr(10))
		BContent		= split(AContent(0),chr(9))
		
		hapr			= Request("hapr")
		HaAllot			= Request("haa")
'		Response.Write 111111
'		Response.end
		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	

				For b=0 To Ubound(BContent)
					Set objRs = RunSQLReturnRs("SELECT Status FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
					If objRs.EOF Then
						 Call CloseDB() : Call descment("존제하지 않는 게임입니다.","/Game/"&goPage&"?Sect=1","")
					Else
						If objRs(0) <>1 Then Call CloseDB() : Call descment("이미 마감된 게임 입니다.","/Game/"&goPage&"?Sect=1","")
					End If
					
				Next	
		
			End If
		
		Next



		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	
				BContent		= split(AContent(i),chr(9))
				Set objRs = RunSQLReturnRs("SELECT gIdx FROM TmpBetCart_TB WHERE Id='"& Session("UId") &"' And gIdx='"& BContent(0) &"'")
				If Not objRs.EOF or Not objRs.BOF Then
					 Call CloseDB() : Call descment("한게임에 두번이상 베팅하실 수 없습니다.","/Game/"&goPage&"?Sect=1","")
				End If
			End If
		
		Next

'========================================================================================================
	allAllot	= 0
	For i=0 To Ubound(AContent)
	
		If Not isNone(AContent(i)) Then	
			BContent = ""	
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
				
				Call CloseDB()
			End If
	
		End If
	
	Next
'	Response.Write "<BR><BR>"
'	Response.Write formatnumber(allAllot,2)&":AL<BR>"
'	Response.Write formatnumber(betmoney,0)&":BM<BR>"
	allAllot	=  left(allAllot,4)
	aHopBmoney	= Int(allAllot*betmoney)
'	Response.Write formatnumber(aHopBmoney,[])&":aBM<BR>"
 '	Response.End
	'========================================================================================================
	
			
'		MaxGcnt = RandomCode()
	Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM TmpBetCart_TB ")
		MaxGcnt = objRss(0)
	objRss.Close			
		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	
				BContent		= split(AContent(i),chr(9))
				Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
				If objRs.EOF Then
					 Call CloseDB() : Call descment("존제하지 않는 게임입니다.","/Game/"&goPage&"?Sect=1","")
				Else


				allAllot	= getAlot(objRs("hAllot"), objRs("vAllot"), objRs("HcapAllotl"), BContent(1))		
					arrName(0)	= "Sect"		: arrValue(0)	= reString(objRs("Sect"),"sql")
					arrName(1)	= "gName"		: arrValue(1)	= reString(objRs("gName"),"sql")
					arrName(2)	= "gIdx"		: arrValue(2)	= reString(BContent(0),"sql")
					arrName(3)	= "Id"			: arrValue(3)	= reString(Session("UId"),"sql")
					arrName(4)	= "gsDate"		: arrValue(4)	= reString(objRs("gsDate"),"sql")
					arrName(5)	= "League"		: arrValue(5)	= reString(objRs("League"),"sql")
					arrName(6)	= "hTname"		: arrValue(6)	= reString(objRs("hTname"),"sql")
					arrName(7)	= "hAllot"		: arrValue(7)	= reString(objRs("hAllot"),"sql")
					arrName(8)	= "hCap"		: arrValue(8)	= reString(objRs("hCap"),"sql")
					arrName(9)	= "HcapAllotl"	: arrValue(9)	= reString(objRs("HcapAllotl"),"sql")
					arrName(10)	= "vTname"		: arrValue(10)	= reString(objRs("vTname"),"sql")
					arrName(11)	= "vAllot"		: arrValue(11)	= reString(objRs("vAllot"),"sql")
					arrName(12)	= "bMoney"		: arrValue(12)	= betmoney
					arrName(13)	= "gCnt"		: arrValue(13)	= MaxGcnt
					arrName(14)	= "gbTem"		: arrValue(14)	= reString(BContent(1),"sql")
					arrName(15)	= "HaAllot"		: arrValue(15)	= allAllot
					arrName(16)	= "hMoney"		: arrValue(16)	= aHopBmoney
						
		
					SQL = insertDB("TmpBetCart_TB", arrName, arrValue)
	'				Response.Write SQL&"<BR><BR>"
					RunSQL(SQL)
					Call CloseDB()
				End If

			End If
			
		Next
	'	Response.End
		Call descment("담기완료 되었습니다. 배팅은 복식배팅카트에서 하실 수 있습니다.","/Game/"&goPage&"?Sect=1","")
	End If
%>
