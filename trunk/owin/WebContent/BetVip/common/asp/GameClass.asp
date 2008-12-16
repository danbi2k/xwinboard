<%

	Public Function InsertDirGame(ByVal AContent, ByVal strId, ByVal betmoney, ByVal allAllot, ByVal aHopBmoney)

		MaxGcnt = RandomCode()
		MaxGcnt = 0
		Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
			MaxGcnt = objRss(0)
		objRss.Close
		
'		Response.Write MaxGcnt
'		Response.End
		'========================================================================================================
		For i=0 To Ubound(AContent)
'			If i = 1 Then strId = "neo7350"
'			If i = 2 Then strId = "0223lkh"
			If Not isNone(AContent(i)) Then	
				BContent	= split(AContent(i),chr(9))
				Set objRs = getRecordSet(getConnection(), "SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")	
'				Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
				If objRs.EOF or objRs.BOF Then
					RunSQL("DELETE FROM DubleBet_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
					Call descment("존재하지 않는 게임입니다.","back","") : Exit For
				Else
					
					If DubleBet(objRs("Idx"), MaxGcnt) Then 
						RunSQL("DELETE FROM DubleBet_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
						Call descment("한게임이 중복 배팅 되었습니다","back","") : Exit For
					End If
					
					arrName(0)	= "gIdx"		: arrValue(0)	= reString(BContent(0),"sql")
					arrName(1)	= "gCnt"		: arrValue(1)	= reString(MaxGcnt,"sql")
					SQL = insertDB("DubleBet_TB", arrName, arrValue)
					RunSQL(SQL)
					
					Call CloseDB()
				End If
			End If
			
		Next
		RunSQL("DELETE FROM DubleBet_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
		
		
		
		
		
		For i=0 To Ubound(AContent)
'			If i = 1 Then strId = "neo7350"
'			If i = 2 Then strId = "0223lkh"
			If Not isNone(AContent(i)) Then	
				BContent		= split(AContent(i),chr(9))
				Set objRs = getRecordSet(getConnection(), "SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")	
'				Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
				If Not objRs.EOF or Not objRs.BOF Then
'					 RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'					 RunSQL("DELETE FROM SumBetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'					 Call descment("존재하지 않는 게임입니다.","back","")
'					 Exit For
'				Else
					
'					If DubleBet(objRs("Idx"), MaxGcnt) Then 
'						RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'						RunSQL("DELETE FROM SumBetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'						Call MissBetMemRePoint(MaxGcnt)
'						Call descment("한게임이 중복 배팅 되었습니다","back","") 
'						Exit For
'					End If
			
					arrName(0)	= "Sect"		: arrValue(0)	= reString(objRs("Sect"),"sql")
					arrName(1)	= "gName"		: arrValue(1)	= reString(objRs("gName"),"sql")
					arrName(2)	= "gIdx"		: arrValue(2)	= reString(BContent(0),"sql")
					arrName(3)	= "Id"			: arrValue(3)	= reString(strId,"sql")
					arrName(4)	= "gsDate"		: arrValue(4)	= reString(objRs("gsDate"),"sql")
					arrName(5)	= "League"		: arrValue(5)	= reString(objRs("League"),"sql")
					arrName(6)	= "hTname"		: arrValue(6)	= reString(objRs("hTname"),"sql")
					arrName(7)	= "hAllot"		: arrValue(7)	= reString(objRs("hAllot"),"sql")
					arrName(8)	= "hCap"		: arrValue(8)	= reString(objRs("hCap"),"sql")
					arrName(9)	= "HcapAllotl"	: arrValue(9)	= reString(objRs("HcapAllotl"),"sql")
					arrName(10)	= "vTname"		: arrValue(10)	= reString(objRs("vTname"),"sql")
					arrName(11)	= "vAllot"		: arrValue(11)	= reString(objRs("vAllot"),"sql")
					arrName(12)	= "bMoney"		: arrValue(12)	= reString(betmoney,"sql")
					arrName(13)	= "gCnt"		: arrValue(13)	= reString(MaxGcnt,"sql")
					arrName(14)	= "gbTem"		: arrValue(14)	= reString(BContent(1),"sql")
					arrName(15)	= "HaAllot"		: arrValue(15)	= allAllot
					arrName(16)	= "hMoney"		: arrValue(16)	= aHopBmoney
					arrName(17)	= "InType"		: arrValue(17)	= "DIR"
					arrName(18)	= "Event"		: arrValue(18)	= reString(objRs("Event"),"sql")
					SQL = insertDB("BetGame_TB", arrName, arrValue)
	'				Response.Write SQL&"<BR><BR>"
					RunSQL(SQL)

					Call CloseDB()
				End If
			End If
			
		Next
	
		RunSQL("INSERT INTO SumBetGame_TB (Id, gCnt, bMoney) VALUES('"& strId &"','"& MaxGcnt &"','"& betmoney &"')")
	
		Call CashChange(reString(strId,"sql"), betmoney, 2, 2, "게임베팅 사용", MaxGcnt)
		Call MileageChange(reString(strId,"sql"),betmoney,1)
		
		Call DubGameErrorCheck(MaxGcnt)
		
	End Function
	
	
	
	
	Public Function InsertCartGame(ByVal gCnt, ByVal strId, ByVal amount, ByVal allAllot, ByVal aHopBmoney)
		arrGCnt	= split(gCnt,",")
		MaxGcnt = 0
		
		For i=0 To Ubound(arrGCnt)		'카트에 담긴 갯수만큼 돌립니다.
			Set objRs = getRecordSet(getConnection(), "SELECT Idx FROM BetCart_TB WHERE Id='"& reString(strId,"sql") &"' And gCnt='"& trim(arrGCnt(i)) &"'")
'			Set objRs = RunSQLReturnRs("SELECT Idx FROM BetCart_TB WHERE Id='"& reString(strId,"sql") &"' And gCnt='"& trim(arrGCnt(i)) &"'")
			'카트담긴걸 뽑아옵니다 구룹전체.
			If Not objRs.EOF or Not objRs.BOF Then
				Set objRss = getRecordSet(getConnection(), "SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
'				Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ") 'gCnt 즉 구룹값을 구합니다.
				MaxGcnt = objRss(0) : objRss.Close
				Do Until objRs.EOF
					
					SQL = "SELECT c.gIdx, c.gbTem, c.bMoney, g.Sect, g.gName, g.gsDate, g.League, g.hTname, g.hAllot, g.hCap, g.HcapAllotl, g.vTname, g.vAllot, g.Event "
					SQL = SQL &" FROM BetCart_TB c, Game_TB g WHERE c.Id='"& reString(strId,"sql") &"' And c.Idx='"& reString(objRs(0),"sql") &"' And c.gIdx=g.Idx "
					Set objRs1 = getRecordSet(getConnection(), SQL)
'					Set objRs1 = RunSQLReturnRs(SQL)
					'카트담긴걸 뽑아옵니다. 개별자료.
					If Not objRs1.EOF or Not objRs1.BOF Then
						Do Until objRs1.EOF

							If DubleBet(objRs1("gIdx"), MaxGcnt) Then 
								RunSQL("DELETE FROM DubleBet_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
								Call descment("한게임이 중복 배팅 되었습니다","back","") : Exit For
							End If
							
							If CloseGameFlag(objRs1("gIdx")) =0 Then 
								RunSQL("DELETE FROM DubleBet_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
								Call descment("이미 마감된 게임에 베팅 하셨습니다.","back","") : Exit For
							End If
'							If strId="msea77" Then aHopBmoney = 0
							arrName(0)	= "gIdx"		: arrValue(0)	= reString(objRs1("gIdx"),"sql")
							arrName(1)	= "gCnt"		: arrValue(1)	= MaxGcnt
							SQL = insertDB("DubleBet_TB", arrName, arrValue)
							RunSQL(SQL)
							
						objRs1.MoveNext
						Loop
					End If					

				objRs.MoveNext
				Loop
			End If
			Call CloseDB()
		Next
		RunSQL("DELETE FROM DubleBet_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
		
		
		
		
		
		
		For i=0 To Ubound(arrGCnt)		'카트에 담긴 갯수만큼 돌립니다.
			Set objRs = getRecordSet(getConnection(), "SELECT Idx FROM BetCart_TB WHERE Id='"& reString(strId,"sql") &"' And gCnt='"& trim(arrGCnt(i)) &"'")
'			Set objRs = RunSQLReturnRs("SELECT Idx FROM BetCart_TB WHERE Id='"& reString(strId,"sql") &"' And gCnt='"& trim(arrGCnt(i)) &"'")
			'카트담긴걸 뽑아옵니다 구룹전체.
			If Not objRs.EOF or Not objRs.BOF Then
				Set objRss = getRecordSet(getConnection(), "SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
'				Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ") 'gCnt 즉 구룹값을 구합니다.
				MaxGcnt = objRss(0) : objRss.Close
				Do Until objRs.EOF
					
					SQL = "SELECT c.gIdx, c.gbTem, c.bMoney, g.Sect, g.gName, g.gsDate, g.League, g.hTname, g.hAllot, g.hCap, g.HcapAllotl, g.vTname, g.vAllot, g.Event "
					SQL = SQL &" FROM BetCart_TB c, Game_TB g WHERE c.Id='"& reString(strId,"sql") &"' And c.Idx='"& reString(objRs(0),"sql") &"' And c.gIdx=g.Idx "
					Set objRs1 = getRecordSet(getConnection(), SQL)
'					Set objRs1 = RunSQLReturnRs(SQL)
					'카트담긴걸 뽑아옵니다. 개별자료.
					If Not objRs1.EOF or Not objRs1.BOF Then
						Do Until objRs1.EOF

'							If DubleBet(objRs1("gIdx"), MaxGcnt) Then 
'								RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'								RunSQL("DELETE FROM SumBetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'								Call descment("한게임이 중복 배팅 되었습니다","back","")
'								Exit For
'							End If
'							
'							If CloseGameFlag(objRs1("gIdx")) =0 Then 
'								RunSQL("DELETE FROM BetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'								RunSQL("DELETE FROM SumBetGame_TB WHERE gCnt='"& reString(MaxGcnt,"sql") &"'")
'								Call descment("이미 마감된 게임에 베팅 하셨습니다.","back","")
'								Exit For
'							End If
'							If strId="msea77" Then aHopBmoney = 0

							bMoney		= reString(objRs1("bMoney"),"sql")

							arrName(0)	= "Sect"		: arrValue(0)	= reString(objRs1("Sect"),"sql")
							arrName(1)	= "gName"		: arrValue(1)	= reString(objRs1("gName"),"sql")
							arrName(2)	= "gIdx"		: arrValue(2)	= reString(objRs1("gIdx"),"sql")
							arrName(3)	= "Id"			: arrValue(3)	= reString(strId,"sql")
							arrName(4)	= "gsDate"		: arrValue(4)	= reString(objRs1("gsDate"),"sql")
							arrName(5)	= "League"		: arrValue(5)	= reString(objRs1("League"),"sql")
							arrName(6)	= "hTname"		: arrValue(6)	= reString(objRs1("hTname"),"sql")
							arrName(7)	= "hAllot"		: arrValue(7)	= reString(objRs1("hAllot"),"sql")
							arrName(8)	= "hCap"		: arrValue(8)	= reString(objRs1("hCap"),"sql")
							arrName(9)	= "HcapAllotl"	: arrValue(9)	= reString(objRs1("HcapAllotl"),"sql")
							arrName(10)	= "vTname"		: arrValue(10)	= reString(objRs1("vTname"),"sql")
							arrName(11)	= "vAllot"		: arrValue(11)	= reString(objRs1("vAllot"),"sql")
							arrName(12)	= "bMoney"		: arrValue(12)	= bMoney
							arrName(13)	= "gCnt"		: arrValue(13)	= MaxGcnt
							arrName(14)	= "gbTem"		: arrValue(14)	= reString(objRs1("gbTem"),"sql")
							arrName(15)	= "HaAllot"		: arrValue(15)	= allAllot
							arrName(16)	= "hMoney"		: arrValue(16)	= aHopBmoney
							arrName(17)	= "InType"		: arrValue(17)	= "CART"	
							arrName(18)	= "Event"		: arrValue(18)	= reString(objRs1("Event"),"sql")		
					
							SQL = insertDB("BetGame_TB", arrName, arrValue)
			'				Response.Write SQL&"<BR><BR>"
							RunSQL(SQL)
							betmoney	= reInt(betmoney,0)+objRs1("bMoney")
							
						objRs1.MoveNext
						Loop
					End If					
					
				RunSQL("DELETE FROM BetCart_TB WHERE Idx='"& objRs("Idx") &"'")
				objRs.MoveNext
				Loop
			End If
			Call CloseDB()
		Call CashChange(strId, bMoney, 2, 2, "게임베팅 사용",MaxGcnt)
		Call MileageChange(strId,bMoney,1)
		RunSQL("INSERT INTO SumBetGame_TB (Id,gCnt,bMoney) VALUES('"& strId &"','"& MaxGcnt &"','"& bMoney &"')")
		
		Next
		
'		Call CashChange(strId, amount, 2, 2, "게임베팅 사용",MaxGcnt)
'		Call MileageChange(strId,amount,1)
	
		
	End Function
		
		
		
	Public Function DubGameErrorCheck(ByVal IntgCnt)	
		Set objRs = getRecordSet(getConnection(), "SELECT Id, bMoney FROM BetGame_TB WHERE gCnt='"& reString(IntgCnt,"sql") &"'")
'		Set objRs = RunSQLReturnRs("SELECT Id, bMoney FROM BetGame_TB WHERE gCnt='"& reString(IntgCnt,"sql") &"'")
		If Not objRs.EOF or Not objRs.BOF Then
			Do Until objRs.EOF
				If Trim(objRs("Id")) <> Trim(strId) Then
					
					strId2		= objRs("Id")
					betmoney2	= objRs("bMoney")
					MaxGcnt2	= ""
					Set Rss = getRecordSet(getConnection(), "SELECT Idx FROM Cash_TB WHERE gCnt='"& reString(IntgCnt,"sql") &"' And Id='"& strId2 &"'")
'					Set Rss = RunSQLReturnRs("SELECT Idx FROM Cash_TB WHERE gCnt='"& reString(IntgCnt,"sql") &"' And Id='"& strId2 &"'")
					If Rss.EOF or Rss.BOF Then
						Set objRss = getRecordSet(getConnection(), "SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
'						Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
							MaxGcnt2 = objRss(0)
						objRss.Close
						RunSQL("UPDATE BetGame_TB Set gCnt='"& MaxGcnt2 &"' WHERE gCnt='"& reString(IntgCnt,"sql") &"' And Id='"& strId2 &"'")
						Exit Do
						
					Else
						Set Rss2 = getRecordSet(getConnection(), "SELECT TOP 1 Id, bMoney FROM BetGame_TB WHERE gCnt='"& reString(IntgCnt,"sql") &"' And Id<>'"& strId2 &"'")
'						Set Rss2 = RunSQLReturnRs("SELECT TOP 1 Id, bMoney FROM BetGame_TB WHERE gCnt='"& reString(IntgCnt,"sql") &"' And Id<>'"& strId2 &"'")
						If Not Rss2.EOF or Not Rss2.BOF Then
							strId2		= Rss2("Id")
							betmoney2	= Rss2("bMoney")
							
							Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetGame_TB ")
								MaxGcnt2 = objRss(0)
							objRss.Close
							RunSQL("UPDATE BetGame_TB Set gCnt='"& MaxGcnt2 &"' WHERE gCnt='"& reString(IntgCnt,"sql") &"' And Id='"& strId2 &"'")
							Exit Do
						
						End If
					End If
						
				End If
			objRs.MoveNext
			Loop
		End If
		
		Call closeResource(objRs)
		Call closeResource(Rss)
		Call closeResource(Rss2)
		
		
		If Not isNone(strId2) And Not isNone(betmoney2) And Not isNone(MaxGcnt2) Then '하나에 MaxGcnt 값에 두게아이디가 있을시 처리...
			RunSQL("INSERT INTO SumBetGame_TB (Id, gCnt, bMoney) VALUES('"& strId2 &"','"& MaxGcnt2 &"','"& betmoney2 &"')")
		End If		
		
		If Not isNone(strId2) And Not isNone(betmoney2) And Not isNone(MaxGcnt2) Then '하나에 MaxGcnt 값에 두게아이디가 있을시 처리...
			Call CashChange(reString(strId2,"sql"), betmoney2, 2, 2, "게임베팅 사용", MaxGcnt2)
			Call MileageChange(reString(strId2,"sql"),betmoney2,1)
		End If
		
				
	End Function
	
	
		
%>	