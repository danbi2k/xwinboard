
<%
Dim http_referer, http_user_agent, remote_host, cPage
  	http_referer     = Request.ServerVariables("Http_referer")
  	http_user_agent  = Request.ServerVariables("Http_user_agent")
  	remote_host      = Request.ServerVariables("Remote_host")
  	cPage            = Request.ServerVariables("URL")

Dim SQL, objRs
	SQL = "SELECT Idx FROM VisitCnt_TB Where cpage = '"& cpage &"' And SessionID = "& Session.SessionID
	
	Set objRs = RunSQLReturnRs(SQL)

	If objRs.EOF or objRs.BOF Then

		Dim csite, csearch, cOs, cBrowser
		csite     = gSite(http_referer)
		cSearch   = gsearch(http_referer)
		cSearch   = URLDECode(cSearch)
		cOs       = gOS(http_user_agent)
		cBrowser  = gBrowser(http_user_agent)
	
		' 카운트 업데이트
  		RunSQL("INSERT INTO VisitCnt_TB (SessionID, hit_Date, Remote_Host, Http_Referer, cMon, cDay, cHour, cWeek, cSite, cSearch, cOS, cBrowser, cPage) Values ("&Session.SessionID&", '"&Date()&"', '"&Remote_host&"', '"&Http_referer&"','"&month(date)&"','"&day(date)&"','"&hour(time)&"','"&weekday(now())&"', '"&cSite&"', '"&cSearch&"', '"&cOS&"', '"&cBrowser&"', '"&cPage&"')")

	End If	
	Set objRs = Nothing
	Set objAdo = Nothing
 	
'****** function 모음 *******

' 바로전 페이지의 사이트 주소를 가져옴.
Function gSite(referer) 

	If isNone(Instr(8,referer, "/")) or isNone(referer) or Len(Instr(8,referer, "/")-1) > 0 Then Exit Function
	gSite = Left(referer,Instr(8,referer, "/")-1) 

End function


' 검색어가 있다면 검색어를 가져옴
Function gSearch(referer)
	Dim gTemp, UNum
	If isNone(referer) Then Exit Function
		gTemp = mid(referer,InStrRev(referer, "?",-1,1)+1)
		gTemp = Split(gTemp,"&")
  
	For UNum = 0 to Ubound(gtemp)
	'글자 길이가 적어도 12이상은 되어야 검색어로 취급한다.
		If Len(gTemp(Unum)) > 12 Then
			If inStr(gTemp(UNum),"q=") > 0 Then
				gSearch = Replace(gTemp(UNum),"q=","")
				Exit For
			ElseIf inStr(gTemp(UNum),"query=") > 0 Then
			    gSearch = Replace(gTemp(UNum),"query=","")
			    Exit For
			ElseIf inStr(gTemp(UNum),"p=") > 0 Then 
			    gSearch = Replace(gTemp(UNum),"p=","")
			    Exit For
			ElseIf inStr(gTemp(UNum),"keyword=") > 0 Then 
			    gSearch = Replace(gTemp(UNum),"keyword=","")
			    Exit For
			ElseIf inStr(gTemp(UNum),"search=") > 0 Then
			    gSearch = Replace(gTemp(UNum),"search=","")
			    Exit For	    
			Exit For
			End if
  
		End if
	Next
  
End function



' 사용하는 OS종류를 가져옴
Function gOS(str)

	Dim gTemp
	gTemp = split(Replace(str,")",""),";")
	
	If isNone(Str) Then gOS = "UnKnown" : Exit Function  
	If UBound(gTemp) < 2 Then gOS = "Unknown" : Exit Function

	gOS = gTemp(2)
End Function


' 브라우져 종류 가져옴
Function gBrowser(str)

	Dim gTemp
	gTemp = split(Replace(str,")",""),";")
		
	If isNone(Str) Then gBrowser = "UnKnown" : Exit Function
	If UBound(gTemp) < 2 Then  gBrowser = "Unknown" : Exit Function

	gBrowser = gTemp(1)

End Function


Function URLDecode(Expression)

	Dim strSource, strTemp, strResult, strchr
	Dim lngPos, AddNum, IFKor
	strSource = Replace(Expression, "+", " ")
	For lngPos = 1 To Len(strSource)
	    AddNum = 2
	    strTemp = Mid(strSource, lngPos, 1)
	    If strTemp = "%" Then
	        If lngPos + AddNum < Len(strSource) + 1 Then
	            strchr = CInt("&H" & Mid(strSource, lngPos + 1, AddNum))
	            If strchr > 130 Then 
	                AddNum = 5
	                IFKor = Mid(strSource, lngPos + 1, AddNum)
	                IFKor = Replace(IFKor, "%", "")
	                strchr = CInt("&H" & IFKor )
	            End If
	            strResult = strResult & Chr(strchr)
	            lngPos = lngPos + AddNum
	        End If
	    Else
	        strResult = strResult & strTemp
	    End If
	Next
	URLDecode = strResult
	
End Function
	
%>
