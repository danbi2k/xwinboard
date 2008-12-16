<%

	Private Function NowMileage(ByVal strId, ByVal strField)
	
		If Not isNone(strId) Then
		
			SQL = "SELECT "& strField &" FROM Member_TB WHERE Id='"& strId &"'"
			Set Rs = RunSQLReturnRs(SQL)
			If Rs.EOF or Rs.BOF Then
				NowMileage = 0
			Else
				NowMileage = Rs(0)
			End IF
			
			Rs.Close : Set Rs = Nothing
		End If
					
	End Function


	Private Function ToMemMileage()
	
		SQL = "SELECT SUM(Point) FROM Member_TB "
		Set Rs = RunSQLReturnRs(SQL)
		If Rs.EOF or Rs.BOF Then
			ToMemMileage = 0
		Else
			ToMemMileage = Rs(0)
		End IF
			
		Rs.Close : Set Rs = Nothing
					
	End Function
	
	
	Private Function RegMoney()
		
		SQL = "SELECT [Id] FROM Member_TB WHERE regIp ='"& GetIp() &"'"
		Set Rs = RunSQLReturnRS(SQL)
		If Rs.EOF or Rs.BOF Then
			RegMoney = CONF_REG_MONEY
		Else
			RegMoney = 0
		End If
		Rs.Close : Set Rs = Nothing
				
	End Function
	
	Public Function UsePoints(ByVal UsePoint, ByVal strId, ByVal Flag)
		UsePoints = 0
		
		If Not isNone(strId) Then
			If Flag = 1 Then
				If reInt(UsePoint,0) > reInt(Session("UPoint"),-1) Then 				
'					UsePoints = 0
'				ElseIf reInt(UsePoint,0) < 100 Then 
'					UsePoints = 0
				ElseIf reInt(UsePoint,0) mod 10>0 Then				
					UsePoints = 0
				Else
					UsePoints = UsePoint
'					Response.Write UsePoint
'					Response.End					
				End If

			ElseIf Flag = 2 Then
			
				SQL = "SELECT Point FROM Member_TB WHERE Id='"& strId &"'"
				Set Rs = RunSQLReturnRs(SQL)
				If Rs.EOF or Rs.BOF Then
					UsePoints = 0
				Else
					UsePoints = Rs(0)
				End If
				Set Rs = Nothing
				


			Else
				UsePoints = 0
		
			End If
		End If

	End Function
	
	Private Function isDupliMemberData(ByVal strCompare, ByVal strCompareData, ByRef blnEOF)
	
		If isNone(strCompare) Then
			Call descment("잘못된 요청입니다.","/","")		
		Else
		
			SQL = "SELECT [Id] FROM Member_TB WHERE "& strCompare &" = '"& strCompareData &"'"
			Set Rs = RunSQLReturnRS(SQL)
			If Rs.EOF or Rs.BOF Then
				blnEOF = True
			Else
				blnEOF = False
			End If
			Rs.Close : Set Rs = Nothing
			
		End If
		
	End Function



	Private Function isDupliSubAdminData(ByVal strCompare, ByVal strCompareData, ByRef blnEOF)
	
		If isNone(strCompare) Then
			Call descment("잘못된 요청입니다.","/","")		
		Else
		
			SQL = "SELECT [SId] FROM Admin_TB WHERE "& strCompare &" = '"& strCompareData &"'"
			Set Rs = RunSQLReturnRS(SQL)
			If Rs.EOF or Rs.BOF Then
				blnEOF = True
			Else
				blnEOF = False
			End If
			Rs.Close : Set Rs = Nothing
			
		End If
		
	End Function
	
	
	
	Private Function isDupliNicName(ByVal strCompare, ByVal strCompareData, ByRef blnEOF)
	
		If isNone(strCompare) Then
			Call descment("잘못된 요청입니다.","/","")		
		Else
		
			SQL = "SELECT [Id] FROM Member_TB WHERE "& strCompare &" = '"& strCompareData &"' And Id<>'"& Session("UId") &"'"
			Set Rs = RunSQLReturnRS(SQL)
			If Rs.EOF or Rs.BOF Then
				blnEOF = True
			Else
				blnEOF = False
			End If
			Rs.Close : Set Rs = Nothing
			
		End If
		
	End Function

	Private Function LoginCheck(ByVal strId, ByVal strPwd, ByVal IntUType, ByRef blnEOF )

		If isNone(strId) or isNone(strPwd) Then
			LoginCheck = 1
		Else
			SQL = "Select * FROM Member_TB WHERE Id = '"& strId &"'"
'			Response.write SQL	
'			Response.End
			Set Rs = RunSQLReturnRS(SQL)
			If Rs.EOF or Rs.BOF Then
				blnEOF = 2				
			Else

				If Rs("VipFlag") <> "okbet-vip.com" Then
					blnEOF = 4
					Exit Function
					
				Else
					'비밀번호가 일치하지 않다면
					If Trim(Rs("pwd")) <> strPwd Then
						blnEOF = 3
					'회원자격이 중지중이면 seceid=1
					ElseIf reInt(Rs("seceid"),1) = 1 Then
						blnEOF = 4
					ElseIf reInt(Rs("seceid"),1) = 2 Then
						blnEOF = 5
					ElseIf reInt(Rs("seceid"),1) = 0 And Trim(Rs("VipFlag")) = "okbet-vip.com" Then
						blnEOF = 0				
						Frlogin = Rs("Flogin")
						'ID와 비번이 일치하는 값이 있다면 세션에 할당한다.
						session.Timeout			= 60
						Session("UId")			= strId
						Session("UName")		= Rs("Name")
						Session("UPoint")		= Rs("Point")
						Session("APoint")		= Rs("APoint")

						Response.Cookies("member")("name")	= Rs("name")
						Response.Cookies("member")("mail")	= Rs("mail")
						If Not isNone(Rs("cell")) Then Response.Cookies("member")("cell")	= Rs("cell")
						If Not isNone(Rs("tel")) Then Response.Cookies("member")("tel")	= Rs("tel")
						Response.Cookies("member").Expires = now()+1
						'방문횟수, 방문일, 점수, 접속IP 갱신
						Call LoginLogUpdate(strId, Rs("Flogin"))
					Else
						blnEOF = 4

					End IF	
				End IF
			End IF
			Rs.Close : Set Rs = Nothing
									
		End If


	End Function	


	Private Sub LoginLogUpdate(ByVal strId, ByVal Flogin )

		If Not isNone(strId) or isNone(strPwd) Then		
			strIp	= Request.ServerVariables("REMOTE_ADDR")		'클라이언트의 IP Address				
			
			If isNull(Flogin) Then RunSQL("UPDATE Member_TB SET Flogin = Getdate(), FloginIp = '"& strIp &"' WHERE id='"& strId &"'")
			RunSQL("UPDATE Member_TB SET Visitnum = Visitnum+1, Llogin = Getdate(), LloginIp = '"& strIp &"' WHERE id='"& strId &"'")
					
		End If

	End Sub	


	Private Sub MemberDel(ByVal strId)
		If Not isNone(strId) Then
			
			RunSQL("DELETE FROM Community_TB WHERE Id='"& strId &"'")
			RunSQL("DELETE FROM Community_TB_comment WHERE Id='"& strId &"'")
			RunSQL("DELETE FROM Member_TB WHERE Id='"& strId &"'")
			RunSQL("DELETE FROM BetGame_TB WHERE Id='"& strId &"'")
			RunSQL("DELETE FROM BetCart_TB WHERE Id='"& strId &"'")
			RunSQL("DELETE FROM Cash_TB WHERE Id='"& strId &"'")
			RunSQL("DELETE FROM Point_TB WHERE Id='"& strId &"'")
		End If
	End Sub
	
	
	Private Sub MileageChange(ByVal strId, ByVal Mileage, ByVal UIFlag )
		'/member/Cash_Prc.asp
		If isNone(strId) or isNone(Mileage) Then
		Else
			
			If UIFlag = 1 Then
			
				SQLs = "UPDATE Member_TB Set Point = Point-'"& Mileage &"' WHERE Id='"& strId &"'"
				RunSQL(SQLs)
				Session("UPoint") = NowMileage(strId, "Point")
				
			ElseIf UIFlag = 2 Then
			
				SQLs = "UPDATE Member_TB Set Point = Point+'"& Mileage &"' WHERE Id='"& strId &"'"
				RunSQL(SQLs)
				
			ElseIf UIFlag = 3 Then
			
				SQLs = "UPDATE Member_TB Set Point = Point-'"& Mileage &"' WHERE Id='"& strId &"'"
				RunSQL(SQLs)
			
			End If
			
		End If

	End Sub
	

	
	
	Public Function MemFlag(ByVal strId)
		
		SQL = "Select * FROM Member_TB WHERE Id = '"& strId &"'"
		Set Rs = RunSQLReturnRS(SQL)
		If Rs.EOF or Rs.BOF Then
			MemFlag = 0
		Else
			MemFlag = 1
		End If
		Rs.Close : Set Rs = Nothing
	End Function 



	Private Sub CashChange(ByVal strId, ByVal Mileage, ByVal IntType, ByVal INFlag, ByVal strComment, ByVal IntgCnt)

		If Not isNone(strId) And Not isNone(Mileage) And Not isNone(IntType) And Not isNone(INFlag) Then
			
			If INFlag = 1 Then    '배팅적중해서 적립 (/admin/member/Write_Prc.asp, /admin/Game/bMem.asp, /admin/Game/bMem_Prc.asp, /common/asp/UtilityClass.asp)
				TCash = NowMileage(strId, "Point")
				
				SQLs = "INSERT INTO Cash_TB (Id,RCash,TCash,ResultCash,Comment,Type,Status,gCnt) VALUES ('"& strId &"','"& Mileage &"','"& TCash &"','"& Mileage+TCash &"','"& strComment &"',2,1,'"& IntgCnt &"')"
				RunSQL(SQLs)
				
				SQLs2 = "UPDATE Member_TB Set Point = Point+'"& Mileage &"' WHERE Id='"& strId &"'"
				RunSQL(SQLs2)
				
			ElseIf INFlag = 2 Then	'배팅를해서 캐쉬뺴기 (/Game/Bet_Prc.asp, /Game/Cart_Prc.asp, /Game/TmpBet_Prc.asp)
				TCash = NowMileage(strId, "Point")
				
				SQLs = "INSERT INTO Cash_TB (Id,RCash,TCash,ResultCash,Comment,Type,Status,gCnt) VALUES ('"& strId &"','"& Mileage &"','"& TCash &"','"& TCash-Mileage &"','"& strComment &"',3,1,'"& IntgCnt &"')"
				RunSQL(SQLs)
				
				
			ElseIf INFlag = 3 Then	'환전요청 캐쉬뺴기 (/member/Cash_Prc.asp)
				TCash = NowMileage(strId, "Point")
				
				SQLs = "INSERT INTO Cash_TB (Id,RCash,TCash,ResultCash,Comment,Type) VALUES ('"& strId &"','"& Mileage &"','"& TCash &"','"& Mileage-TCash &"','"& strComment &"',3)"
				RunSQL(SQLs)
				
			ElseIf INFlag = 4 Then	'게임 미적중(승무패)해서 배팅금액의 2%가 포인트 적립 (/Admin/Game/Write_Prc.asp)
				TCash = NowMileage(strId, "APoint")
				
				SQLs = "INSERT INTO Point_TB (Id,Point,TPoint,ResultPoint,Comment,Type) VALUES ('"& strId &"','"& Mileage &"','"& TCash &"','"& Mileage+TCash &"','"& strComment &"',4)"
				RunSQL(SQLs)
				
				SQLs2 = "UPDATE Member_TB Set APoint = APoint+'"& Mileage &"' WHERE Id='"& strId &"'"
				RunSQL(SQLs2)
			
			ElseIf INFlag = 5 Then	'포인트 캐쉬전환 (/Member/ChCash_Prc.asp)
				TPoint = NowMileage(strId, "APoint")
				strIp	= Request.ServerVariables("REMOTE_ADDR")
				SQLs = "INSERT INTO Point_TB (Id,Point,TPoint,ResultPoint,Comment,Type, Ip) VALUES ('"& strId &"','"& Mileage &"','"& TPoint &"',0,'"& strComment &"',5,'"& strIp &"')"
				RunSQL(SQLs)
				
				TCash = NowMileage(strId, "Point")
				
				SQLs2 = "INSERT INTO Cash_TB (Id,RCash,TCash,ResultCash,Comment,Type,Status) VALUES ('"& strId &"','"& Mileage &"','"& TCash &"','"& Mileage+TCash &"','"& strComment &"',5,1)"
				RunSQL(SQLs2)
				
				SQLs2 = "UPDATE Member_TB Set Point = Point+'"& Mileage &"', APoint = 0  WHERE Id='"& strId &"'"
				RunSQL(SQLs2)
				
			End If
			
		End If

	End Sub	
	
	
	
	Private Sub CashChange2(ByVal strId, ByVal Mileage, ByVal IntType, ByVal INFlag, ByVal strComment, ByVal IntIdx)

		If Not isNone(strId) And Not isNone(Mileage) And Not isNone(IntType) And Not isNone(INFlag) Then
			
			If INFlag = 3 Then  '캐쉬 충전해 주기 (/admin/member/Cash_Prc.asp, )

				TCash = NowMileage(strId, "Point") '마일리지 정보
				SQL1 = "UPDATE Cash_TB Set Status=1,InDay=getDate(), ResultCash ='"& TCash+reInt(Mileage,0) &"', Comment='"& strComment &"', TCash ='"& TCash &"' WHERE Idx='"& IntIdx &"' "
'				Response.write SQL1 &":SQL1<BR>"
				RunSQL(SQL1)
				Call MileageChange(strId, reInt(Mileage,0), 2 )	'마일리지 적용
				
				
			ElseIf INFlag = 4 Then  '캐쉬 환전해 주기 (/admin/member/Cash_Prc.asp, )

				TCash = NowMileage(strId, "Point") '마일리지 정보
				SQL1 = "UPDATE Cash_TB Set Status=1,InDay=getDate(), ResultCash ='"& TCash-reInt(Mileage,0) &"', Comment='캐쉬환전', TCash ='"& TCash &"' WHERE Idx='"& IntIdx &"' "
'				Response.write SQL1 &":SQL1<BR>"
				RunSQL(SQL1)
				Call MileageChange(strId, reInt(Mileage,0), 1 )	'마일리지 삭감 적용
						
			End If
			
		End If

	End Sub		
%>
