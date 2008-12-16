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
	thispage	= Request.Form("thispage")		'카트에 담긴 게임 실제 배팅시 머니
	
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
			Set objRs = getRecordSet(getConnection(), "SELECT Idx FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And gCnt="& reString(arrgCnt(i),"sql") &"")
'			Set objRs = RunSQLReturnRs("SELECT Idx FROM BetCart_TB WHERE Id='"& reString(Session("UId"),"sql") &"' And gCnt="& reString(arrgCnt(i),"sql") &"")
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

'============================================================================================================================
		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	

				For b=0 To Ubound(BContent)
					If CloseGameFlag(reString(BContent(0),"sql") ) =0 Then Call descment("이미 마감된 게임에 베팅 하셨습니다.","back","") : Exit For
				Next	
		
			End If
		
		Next

'============================================================================================================================				


'		MaxGcnt = RandomCode()
		Set objRss = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM BetCart_TB ")
		MaxGcnt = objRss(0) : objRss.Close			
		
		For i=0 To Ubound(AContent)
		
			If Not isNone(AContent(i)) Then	
				BContent		= split(AContent(i),chr(9))
				Set objRs = getRecordSet(getConnection(), "SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
'				Set objRs = RunSQLReturnRs("SELECT * FROM Game_TB WHERE Idx='"& reString(BContent(0),"sql") &"'")
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
