<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	Dim arrName(40), arrValue(40)
	betmoney	= Request("betmoney")
	mode		= Request("mode")
	If isNone(Session("UId")) Then Call descment("","/","")
	NowPt	= UsePoints("", Session("UId"), 2)
	If Not isInt(betmoney) Then Call descment("","/","")
	If Int(betmoney) > reInt(NowPt,0) Then Call descment("","/","")

	
	betcontent		= Request("betcontent")
	AContent		= split(betcontent,chr(13) & chr(10))
	BContent		= split(AContent(0),chr(9))
	Sect			= Request("Sect")
	
	
	'========================================================================================================
	For i=0 To Ubound(AContent)
	
		If Not isNone(AContent(i)) Then	

			For b=0 To Ubound(BContent)
				Set objRs = RunSQLReturnRs("SELECT Status FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
				If objRs.EOF Then
					 Call CloseDB() : Call descment("존제하지 않는 게임입니다.","/Game/List.asp","")
				Else
					If objRs(0) = 0 Then Call CloseDB() : Call descment("이미 마감된 게임에 베팅 하셨습니다.","/Game/List.asp?Sect="& Sect,"")
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
	allAllot	=  formatnumber(allAllot,2)
	aHopBmoney	= Int(allAllot*betmoney)
'	Response.Write formatnumber(aHopBmoney,[])&":aBM<BR>"
 '	Response.End
	'========================================================================================================
		
	Set objRss = RunSQLReturnRs("SELECT isNull(MAX(gCnt),0)+1 FROM BetGame_TB ")
			MaxGcnt = objRss(0)
	objRss.Close
	
	'========================================================================================================
	For i=0 To Ubound(AContent)
	
		If Not isNone(AContent(i)) Then	
			BContent		= split(AContent(i),chr(9))
			Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
			If objRs.EOF Then
				 Call CloseDB() : Call descment("존제하지 않는 게임입니다.","/Game/List.asp?Sect="& Sect,"")
			Else
				
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
				arrName(12)	= "bMoney"		: arrValue(12)	= reString(betmoney,"sql")
				arrName(13)	= "gCnt"		: arrValue(13)	= reString(MaxGcnt,"sql")
				arrName(14)	= "gbTem"		: arrValue(14)	= reString(BContent(1),"sql")
				arrName(15)	= "HaAllot"		: arrValue(15)	= allAllot
				arrName(16)	= "hMoney"		: arrValue(16)	= aHopBmoney
					
				SQL = insertDB("BetGame_TB", arrName, arrValue)
'				Response.Write SQL&"<BR><BR>"
				RunSQL(SQL)
				Call MileageChange(Session("UId"),arrValue(12),1)
				Call CloseDB()
			End If
				
		
		End If
		
	Next
'	Response.End
	Call descment("베팅 결과는 바이베팅 에서 확인 하실 수 있습니다.","/Game/List.asp?Sect="& Sect,"")
		
		
	Response.Write "<BR><BR>"
	Response.Write betcontent&"<font color=red>:원소스</font><BR><BR>"
	Response.Write AContent(0)&"<font color=red>:구분1</font><BR>"
	Response.Write AContent(1)&"<font color=red>:구분2</font><BR><BR><BR>"
	
	
	Response.Write BContent(0)&"<font color=red>:Idx</font><BR>"
	Response.Write BContent(1)&"<font color=red>:베팅한 팀</font><BR>"
	Response.Write BContent(2)&"<font color=red>:승(팀이름)</font><BR>"
	Response.Write BContent(3)&"<font color=red>:패(팀이름)</font><BR>"
	Response.Write BContent(4)&"<font color=red>:승(배당율)</font><BR>"
	Response.Write BContent(5)&"<font color=red>:패(배당율)</font><BR>"
	Response.Write BContent(6)&"<font color=red>:세부7</font><BR>"
	Response.Write BContent(7)&"<font color=red>:패(배당율???)</font><BR>"
	Response.Write BContent(8)&"<font color=red>:핸드캡배당율</font><BR>"

	Response.End



%>
