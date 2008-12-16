<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%


'	Call FromCollection()
	
	Dim arrName(40), arrValue(40)

	mode		= Request.Form("mode")
	gCnt		= Request.Form("gCnt")
	betmoney	= Request.Form("betmoney")		'카트에 담을때 머니
	Sect		= Request("Sect")
	amount		= Request.Form("amount")		'카트에 담긴 게임 실제 배팅시 머니
		thispage		= Request.Form("thispage")		'카트에 담긴 게임 실제 배팅시 머니
'	Response.Write "amount:"&amount&"<br>"
'	Response.Write "betmoney:"&betmoney&"<br>"
'	Response.Write "mode:"&mode&"<br>"
'	Response.Write "gCnt:"&gCnt&"<br>"
	
'	Response.Write "bet_prc.asp<BR><BR>"
'	Response.End
	
'	refUrl = Request.servervariables("HTTP_REFERER")
'	refUrl = replace(refUrl,"http://","")
'	refUrl = mid(refUrl,1,instr(refUrl,"/")-1)
'	If lcase(refUrl) <> lcase("okbet888.com") Then Call descment("","/","")

	If isNone(thispage) Then 
		goPage = "List.asp"
	Else
		goPage = "List2.asp?Sect=5"
	End If
	
	If isNone(Session("UId")) Then Call descment("","/","")
	
	
	
	
	
	
	
	
	If mode = "del_cart" Then	'카트삭제
	
		arrgCnt = split(gCnt,",")
		For i=0 To Ubound(arrgCnt)
			Set objRs = RunSQLReturnRs("SELECT Idx FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And gCnt="& reString(arrgCnt(i),"sql") &"")
			If objRs.EOF or objRs.BOF Then
				Call descment("","/Game/Cart.asp","")
			Else
				Do Until objRs.EOF
					RunSQL("DELETE FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And Idx='"& reString(objRs("Idx"),"sql") &"'")
				objRs.MoveNext
				Loop
			End If
		Next
		Call descment("","/Game/Cart.asp","")
		
		
		
		
		
		
		
		
	ElseIf mode = "cart_bet" Then		'카드에 담긴것 배팅하기
		arrGCnt	= split(gCnt,",")
'		MaxGcnt = RandomCode()
	
	
		For i=0 To Ubound(arrGCnt)		'카트에 담긴 갯수만큼 돌립니다.
			Set objRs = RunSQLReturnRs("SELECT Idx FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And gCnt='"& trim(arrGCnt(i)) &"'")
			'카트담긴걸 뽑아옵니다 구룹전체.
			If Not objRs.EOF or Not objRs.BOF Then
				Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ") 'gCnt 즉 구룹값을 구합니다.
				MaxGcnt = objRss(0) : objRss.Close
				Do Until objRs.EOF
					
					Set objRs1 = RunSQLReturnRs("SELECT gIdx, gbTem, gIdx, bMoney FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And Idx='"& reString(objRs(0),"sql") &"'")
					'카트담긴걸 뽑아옵니다. 개별자료.
					If Not objRs1.EOF or Not objRs1.BOF Then
						Do Until objRs1.EOF
						
							Set objRs2 = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(objRs1("gIdx"),"sql") &"'")
							'게임값을 가져옵니다. 카트에 기준값gidx 와 같은..
							If Not objRs2.EOF or Not objRs2.BOF Then
								Do Until objRs2.EOF
									SQLs = "SELECT Idx FROM BetGame_TB WHERE gIdx='"& objRs1("gIdx") &"' And gCnt='"& MaxGcnt &"'"
									Set Rss = RunSQLReturnRs(SQLs)
									If Not ( Rss.EOF or Rss.BOF ) Then 
										Call descment("한게임이 중복 배팅 되었습니다","back","")
										RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& MaxGcnt &"'")
										Exit For
									End If

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
								aHopBmoney	= Int(allAllot*objRs1("bMoney"))
								bMoney		= reString(objRs1("bMoney"),"sql")
'								Response.Write allAllot&":allAllot<BR>"
'								Response.Write aHopBmoney&":aHopBmoney<BR>"
'								Response.Write formatnumber(aHopBmoney,[])&":aBM<BR>"
'							 	Response.End
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
								arrName(12)	= "bMoney"		: arrValue(12)	= bMoney
								arrName(13)	= "gCnt"		: arrValue(13)	= MaxGcnt
								arrName(14)	= "gbTem"		: arrValue(14)	= reString(objRs1("gbTem"),"sql")
'								arrName(15)	= "HaAllot"		: arrValue(15)	= allAllot
'								arrName(16)	= "hMoney"		: arrValue(16)	= aHopBmoney
						
								SQL = insertDB("BetGame_TB", arrName, arrValue)
				'				Response.Write SQL&"<BR><BR>"
								RunSQL(SQL)
								betmoney	= reInt(betmoney,0)+objRs1("bMoney")
							
								objRs2.MoveNext
								Loop
							End If '게임값을 가져옵니다. 끝~
						
						objRs1.MoveNext
						Loop
					End If					
					
				RunSQL("DELETE FROM BetCart_TB WHERE Idx='"& objRs("Idx") &"'")
				objRs.MoveNext
				Loop
			End If
			Call CloseDB()
		Next
		
		
		
		
		
'==========================================================================================================================================================================		
		AllAllot	= 0
		Set objRs = RunSQLReturnRs("SELECT gbTem, hAllot, vAllot, HcapAllotl, bMoney FROM BetGame_TB WHERE gCnt='"& MaxGcnt &"'")
		If Not objRs.EOF Then
			Do Until objRs.EOF
				If objRs("gbTem") = 1 Then
					If allAllot = 0 Then 
						allAllot = objRs("hAllot")
					Else
						allAllot = allAllot * objRs("hAllot")
					End If
															
				ElseIf objRs("gbTem") = 2 Then
					If allAllot = 0 Then 
						allAllot = objRs("vAllot")
					Else
						allAllot = allAllot * objRs("vAllot")
					End If
															
				ElseIf objRs("gbTem") = 3 Then
					If allAllot = 0 Then 
						allAllot = objRs("HcapAllotl")
					Else
						allAllot = allAllot * objRs("HcapAllotl")
					End If
				End If
				betmoney = objRs("bMoney")
'				Response.Write allAllot&":R<BR><BR>"		
			objRs.MoveNext
			Loop
			AllAllot	=  left(AllAllot,4)
			AllhMoney	= Int(AllAllot*betmoney)
		End If			
'		Response.Write AllAllot&":ALL<BR>"
'		Response.Write AllhMoney&":ALLMONEY<BR>"
'		Response.Write betmoney&"<BR>"
'		Response.End
		
		RunSQL("UPDATE BetGame_TB Set HaAllot='"& AllAllot &"', hMoney='"& AllhMoney &"' WHERE gCnt='"& MaxGcnt &"'")
'==========================================================================================================================================================================		


		
		Call CashChange(Session("UId"), amount, 2, 2, "게임베팅 사용")
		Call MileageChange(Session("UId"),amount,1)
		Call descment("베팅 결과는 바이베팅 에서 확인 하실 수 있습니다.","/Game/"&goPage&"?Sect="& Sect,"")
	
	
	
	
	
	
	
	
	
	ElseIf mode = "cart" Then		'카트담기:cart
	
	
	
		NowPt	= UsePoints("", Session("UId"), 2)
		If Not isInt(betmoney) Then Call descment("","/","")
		If 0 >= reInt(NowPt,0) Then Call descment("","/Game/"&goPage&"?Sect="& Sect,"")

		
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
						 Call CloseDB() : Call descment("존제하지 않는 게임입니다.","/Game/"&goPage&"?Sect="& Sect,"")
					Else
						If objRs(0) <>1 Then Call CloseDB() : Call descment("이미 마감된 게임 입니다.","/Game/"&goPage&"?Sect="& Sect,"")
					End If
					
				Next	
		
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
		Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetCart_TB ")
		MaxGcnt = objRss(0) : objRss.Close			
		
		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	
				BContent		= split(AContent(i),chr(9))
				Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
				If objRs.EOF Then
					 Call CloseDB() : Call descment("존제하지 않는 게임입니다.","/Game/"&goPage&"?Sect="& Sect,"")
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
						
		
					SQL = insertDB("BetCart_TB", arrName, arrValue)
	'				Response.Write SQL&"<BR><BR>"
					RunSQL(SQL)
					Call CloseDB()
				End If

			End If
			
		Next
	'	Response.End
		Call descment("담기완료 되었습니다. 배팅은 배팅카트에서 하실 수 있습니다.","/Game/"&goPage&"?Sect="& Sect,"")
	End If
%>
