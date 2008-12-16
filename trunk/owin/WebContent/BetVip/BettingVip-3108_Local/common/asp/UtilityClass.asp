<%

	Function gSelection(ByVal A, ByVal B,ByVal C)
		If Not isNone(A) or Not isNone(A) or Not isNone(A) Then
			If Cstr(A) = Cstr(B) Then gSelection = C
		End If
		
	End function


	Public Function isIfAB(ByVal isIF, ByVal A, ByVal B)
	
		IF isIF Then
			isIfAB = A
		Else
			isIfAB = B
		End If
	
	End Function

	Public Function IfElse(ByVal A,ByVal B)
	
		If isNone(Cstr(A)) Then IfeLSE = B Else IfeLSE = A End If
		
	End function


	Private Sub descMent(ByVal msg, ByVal reUrl, ByVal parUrl)
		
		Response.Write("<script language=""javascript"">")
		
		If Not isNone(msg) Then Response.Write("alert(""" & reString(msg, "js") & """);")
		
		If reUrl = "back" Then 
'			Response.Write("history.go(-1);")
			Response.Write("history.back();")

		ElseIf reUrl = "close" Then
			Response.Write("window.top.close();")
					
		ElseIf Not isNone(reUrl) Then  
			Response.Write("window.location.replace(""" & reUrl & """);")
		
		End If

		If Not isNone(parUrl) Then Response.Write("opener.location.reload(""" & parUrl & """);")
		
		Response.Write("</script>")
		Response.End
	
	End Sub

		
	Private Sub descMentPage(ByVal Ment, ByVal URL, ByVal Opt)
		
		Response.write("<script language=""javascript"">")
		
		If Ment <> "" Then Response.Write "alert('"& ment &"');"
		Response.Write URL
		Response.Write Opt
		Response.Write "</script>"
		Response.End
		
	End SUB
	
	Private Sub DeleteFile(ByVal FilePath)
	
		If Server.CreateObject("Scripting.FileSystemObject").FileExists(FilePath) Then Call Server.CreateObject("Scripting.FileSystemObject").DeleteFile(FilePath, true)
		
	End Sub
		
		
	
	Function AutoPlay(ByVal file, ByVal IntIdx, ByVal fcnt, ByVal viewOrig, ByVal border, ByVal width, ByVal height)
	
		Dim i, playSize, playBorder
		
		If reInt(width, 0) > 0 Then playSize = " width=""" & width & """"
		If reInt(height, 0) > 0 Then playSize = playSize & " height=""" & height & """"		
		if isNone(playSize) then playSize = " onload=""addAutoPlayImg(this);"""
		
		playBorder = reInt(border, 1)
'		Response.Write file &"<br>"
		If Not isNone(file) Then
			file = split(file & fcnt, chr(13) & chr(10))
			If inRStr(CONF_AUTOPLAY_IMG, getFileName(file(0), "ext"), ",", 1, 0) Then
				
				if reInt(viewOrig, 0) = 1 Then
					AutoPlay = "<a href=""javascript:getviewImage("& IntIdx & "," & fcnt & ",'"& file(0) &"');""><img src=""Download.asp?TableName=" & TableName & "&Idx=" & IntIdx & "&fcnt=" & fcnt & """ border=""0"" style=""border: " & playBorder & "px solid #999999;""" & playSize & "></a>"
				Else
					
					AutoPlay = "<img src=""Download.asp?TableName=" & TableName & "&Idx=" & IntIdx & "&fcnt=" & fcnt & """ border=""0"" style=""border: " & playBorder & "px solid #999999;""" & playSize & ">"

				End If
			
			ElseIf inRStr(CONF_AUTOPLAY_MEDIA, getFileName(file(0), "ext"), ",", 1, 0) Then
			
				AutoPlay = "<embed src=""Download.asp.asp?TableName=" & TableName & "&Idx=" & IntIdx & "&fcnt=" & fcnt & """ enablecontextmenu=""false"" enablecontextmenu=""false"" style=""border: " & playBorder & "px solid #999999;""></embed>"
				
			End If
		End If
	
	End Function
	
	
		

	Public Function isNone(ByVal allType)
		
		If isNull(allType) Then
			isNone = true
			Exit Function
		End If
		
		If isEmpty(allType) Then
			isNone = true
			Exit Function
		End If
		
		
		If Trim(allType) = "" Then
			isNone = true
			Exit Function
		End If		
		isNone = false
		
	End Function	
	
	
	Public Function GetIp()
	
		GetIp	= Request.ServerVariables("REMOTE_ADDR")
		
	End Function		
	

	Function checkRight(ByVal strId, ByVal sqlType)
	
		Dim sql, rs
		
			If sqlType = "board" Then
				SQL = "SELECT Id FROM " & TableName & " WHERE Idx = '"& IntIdx & "'"
			ElseIf sqlType = "comment" Then
				SQL = "SELECT Id FROM " & TableName & "_Comment WHERE num = " & cIntIdx & ""
			Else
				Call descment("잘못된 정보를 요청하셨습니다.", "back","")
			End If
'			Response.Write SQL
			Set Rs = getRecordSet(getConnection(), SQL)
'			Set Rs = RunSQLReturnRS(SQL)
			
'			If Rs.BOF or Rs.EOF Then
'				Call descment("잘못된 정보를 요청하셨습니다.", "back")
'			End If
			
			Do Until Rs.EOF
				If Not isNone(Rs("Id")) And Trim(Rs("Id")) = strId Then
					'비밀번호 일치
				Else
					If Not isNone(Rs("Id")) Then
						'비밀번호 미확인
						If isNone(strId) Then
							checkRight = false
							Exit Function
						Else
							Call CloseDB()
							Call descment("권한이 없습니다.", "back","")
						End If
					Else
						Call CloseDB()
						checkRight = false
					End If
				End If
				Rs.moveNext
			Loop
		
		Set Rs = Nothing
		
		checkRight = true
	
	End Function	


	
	
	Public Function reUnit(ByVal intType)
	
		intType = reInt(intType, 0)
		
		If intType < 1024 Then
			reUnit = intType & " Bytes"
		ElseIf intType < 1024^2 Then
			reUnit = left((intType / 1024), InStr((intType / 1024),".") + 3) & " KB"
		ElseIf intType < 1024^3 Then
			reUnit = left((intType / 1024^2), InStr((intType / 1024^2),".") + 3) & "MB"
		Else
			reUnit = left((intType / 1024^3), InStr((intType / 1024^3),".") + 3) & "GB"
		End If
	
	End Function	

	Public Function reInt(ByVal intType, ByVal noneData)
		
		If isInt(trim(intType)) Then
			reInt = cDbl(trim(intType))
		Else
			reInt = noneData
		End If
	
	End Function	
	
'	============================================================================
'	=
'	=	Function : getInt(intType, noneData)
'	=
'	=	intType이 int형으로 변환 가능하면 변환하고 그렇지 않으면 noneData를 반환.
'	=
'	============================================================================
	
	Public Function getInt(intType)
		
		If isInt(trim(replace(intType, ".", ""))) Then
			If inStr(intType, ".") = 0 Then
				getInt = cInt(intType)
			Else
				getInt = left(intType, inStr(intType, "."))
			End If
		Else
			getInt = 0
		End If
	
	End Function	
	
	
	Public Function isInt(ByVal intType)
	
		Dim i, intChar, intChar2
		
		If isNone(intType) Then
			isInt = false
			Exit Function
		End If
		
		intChar = "0123456789"
		intChar2 = "+-"
		
		For i = 1 To len(intType) step 1
			If inStr(intChar, mid(intType, i, 1)) = 0 Then
				If Not(i = 1 and inStr(intChar2, left(intType, 1)) > 0) Then
					isInt = false
					Exit Function
				End If
			End If
		Next
	
		isInt = true
		
	End Function			
		
	Public Function inRStr(ByVal sourceStr, ByVal conStr, ByVal splitChar, ByVal caseStr, ByVal trimStr)
	
		If caseStr = 1 Then
			sourceStr = LCase(sourceStr)
			conStr = LCase(conStr)
		End If
	
		If trimStr = 1 Then
			sourceStr = replace(sourceStr & "", " ", "")
			conStr = replace(conStr & "", " ", "")
		End If
	
		If inStr(splitChar & sourceStr & splitChar, splitChar & conStr & splitChar) > 0 Then
			inRStr = true
		Else
			inRStr = false
		End If
		
	End Function
	

	Public Function getInfo(ByVal sourceStr, ByVal index, ByVal splitChar)
	
		Dim infoBuffer
		
		If isNone(sourceStr) Then
			getInfo = ""
			Exit Function
		End If
		
		infoBuffer = split(sourceStr, splitChar)
		
		If UBound(infoBuffer) < index Then
			getInfo = ""
		Else
			getInfo = infoBuffer(index)
		End If
	
	End Function
	
	
	Function wordFilter(ByVal content)
	
		Dim wordList, i
		
		If CONF_USEFILTER = 1 Then
			If Not isNone(CONF_FILTERWORD) Then
			
				wordList = split(CONF_FILTERWORD, ",")
				
				For i = LBound(wordList) To UBound(wordList) step 1
					If Not isNone(wordList(i)) Then
					
						If inStr( content, wordList(i)) > 0 Then
							wordFilter = wordList(i)
							Exit Function
						End If
					
					End If
				Next
				
			End If
		End If
		
		wordFilter = null
	
	End Function
		
		

	Public Function lengthB(ByVal strType)
	
		Dim byte1, i, size
		
		byte1 = midB(" ", 2, 1)
		size = 0
		
		For i = 1 To Len(strType)
			If midB(mid(strType, i, 1), 2, 1) = byte1 Then
				size = size + 1
			Else
				size = size + 2
			End If
		Next
		
		lengthB = size
		
	End Function
	

	Public Function subStrB(ByVal strType, ByVal theFrom, ByVal theTo)
		
		Dim i, buffer
		
		buffer = ""
		
		for i = 1 to len(strType) step 1
			if lengthB(left(strType, i)) > theFrom then
				if lengthB(left(strType, i)) <= theTo then
					buffer = buffer & mid(strType, i, 1)
				end if
			end if
		next
		
		subStrB = buffer
		
	End Function
	
	
	Function TextLeft(ByVal text, ByVal size)

		If Not isNone(text) Then
			
			If size > 0 And lengthB(text) > size Then
		
				TextLeft = subStrB(text, 0, size - 1) & ".."
				
			Else
		
				TextLeft = text
		
			End If
			
		End If
			
	End Function	
	
	Function CutString(ByVal str, ByVal cutLen)
		Dim f
		Dim nLen : nLen = 0.00
		Dim RetVal : RetVal = ""
		Dim tmpStr, tmpLen

		If IsNull(str) Then str = ""

		For f = 1 To Len(str)
			tmpStr = Mid(str, f, 1)
			tmpLen = Asc(tmpStr)

			If tmpLen < 0 Then ' 한글
				nLen = nLen + 1.4			' 한글일때 길이값 설정
				RetVal = RetVal & tmpStr
			ElseIf tmpLen >= 97 And tmpLen <= 122 Then ' 영문 소문자
				nLen = nLen + 0.75			' 영문소문자 길이값 설정
				RetVal = RetVal & tmpStr
			ElseIf tmpLen >= 65 And tmpLen <= 90 Then ' 영문 대문자
				nLen = nLen + 1				' 영문대문자 길이값 설정
				RetVal = RetVal & tmpStr
			Else ' 그외 키값
				nLen = nLen + 0.6			' 특수문자 기호값...
				RetVal = RetVal & tmpStr
			End If

			If nLen > cutLen Then
				RetVal = RetVal &".."
				Exit For
			End If
		Next

		CutString = RetVal
	End Function
	
	
	Function DateViewLen(ByVal strData, ByVal fmt, ByVal lng)
	
		If Not isNone(strData) And Not isNone(fmt) Then

			DateViewLen = rePlace(Left(strData,lng),"-",fmt)
	
		End If
	
	End Function
	


	Function ReadText(ByVal str, ByVal strSearch)
	
		If Not isNone(strSearch) Then
			ViewText = replace(reString(str, "text"), reString(strSearch, "text"), "<font color=""#FF001E"" style=""background-color:FFF000;"">" & reString(strSearch, "text") & "</font>")
		Else
			ViewText = reString(str, "text")
		End If

		ReadText = ViewText
	
	End Function		
	

	Public Function reString(ByVal strType, ByVal reCase)
	
		Dim buffer
		
		If isNone(strType) Then
			reString = ""
			Exit Function
		End If

'		buffer = Replace(strType,"<" & "%","&lt;%"): '//ASP태그 방지
'		buffer = Replace(buffer,"%" & ">","&lt;%"): '//ASP태그 방지
		buffer = Replace(strType,"<" & "%","&lt;%"): '//ASP태그 방지
		buffer = Replace(buffer,"%" & ">","&lt;%"): '//ASP태그 방지
		buffer = Replace(buffer,"""","&#34;"):		'//ASP태그 방지
		buffer = Replace(buffer,"--",""):	
		buffer = Replace(buffer,";",":"):
'		buffer = Replace(buffer,"<xmp>","&lt;xmp>"):
		buffer = eregi_replace("(javascript\:|vbscript\:)+","$1//",buffer): '//클라이언트 스크립트 실행방지
		buffer = eregi_replace("(\.location|location\.|onload=|\.cookie|alert\(|window\.open\(|onmouse|onkey|onclick|view\-source\:)+","//",buffer): '//자바스크립트 실행방지										
		buffer = strip_tags(buffer)
		select case reCase
			case "sql"
				buffer = replace(buffer, chr(39), chr(39) & chr(39))

			case "text"
				buffer = replace(buffer, "<", "&lt;")
				buffer = replace(buffer, ">", "&gt;")
				buffer = replace(buffer, chr(13) & chr(10), "<br>")
'				buffer = Replace(buffer,"<xmp>","&lt;xmp>"):
			case "mix"
'				buffer = replace(buffer, "<", "&lt;")
'				buffer = replace(buffer, ">", "&gt;")
				buffer = replace(buffer, chr(13) & chr(10), "<br>")
				buffer = replace(buffer, "&#34;" , """")
'				buffer = Replace(buffer,"<xmp>","&lt;xmp>"):
			case "mix2"
				buffer = replace(buffer, chr(13) & chr(10), "<br>")
				buffer = replace(buffer, "&#34;" , """")
'				buffer = Replace(buffer,"<xmp>","&lt;xmp>"):
'				buffer = eregi_replace("(javascript\:|vbscript\:)+","$1//",buffer): '//클라이언트 스크립트 실행방지
'				buffer = eregi_replace("(\.location|location\.|onload=|\.cookie|alert\(|window\.open\(|onmouse|onkey|onclick|view\-source\:)+","//",buffer): '//자바스크립트 실행방지
			case "html"
				buffer = replace(buffer, "&#34;" , """")
'				buffer = Replace(buffer,"<xmp>","< xmp>"):
				buffer = eregi_replace("(javascript\:|vbscript\:)+","$1//",buffer): '//클라이언트 스크립트 실행방지
				buffer = eregi_replace("(\.location|location\.|onload=|\.cookie|alert\(|window\.open\(|onmouse|onkey|onclick|view\-source\:)+","//",buffer): '//자바스크립트 실행방지				
			case "js"
				buffer = replace(buffer, "\", "\\")
				buffer = replace(buffer, chr(39), "\" & chr(39))
				buffer = replace(buffer, chr(34), "\" & chr(34))
				buffer = replace(buffer, chr(13) & chr(10), "\n")
				buffer = replace(buffer, "</", "<\/")
'				buffer = Replace(buffer,"<xmp>","&lt;xmp>"):
			case Else
				buffer = strType
		end select

		reString = Trim(buffer)
	
	End Function


	Function strip_tags(str)
		Dim content
		Dim tags:
		
		If Not isNone(str) Then
			content = str
'			tags = replace(CONF_PERMITTAGS,",","|"):

			content = eregi_replace("<(\/?)(?!\/|" & tags & ")([^<>]*)?>", "&lt;$1$2&gt;", content):
			content = eregi_replace("(javascript\:|vbscript\:)+","$1//",content):
			content = eregi_replace ("(\.location|location\.|onload=|\.cookie|alert\(|window\.open\(|onmouse|onkey|onclick|view\-source\:)+","//",content): '//자바스크립트 실행방지

			strip_tags = content:
		End If
	End Function


	Public Function eregi_replace(ByVal pattern, ByVal replace, ByVal text)
		Dim eregObj:

		' Create regular expression
		Set eregObj = New RegExp:

		eregObj.Pattern = pattern: '//Set Pattern(패턴 설정)
		eregObj.IgnoreCase = True: '//Set Case Insensitivity(대소문자 구분 여부)
		eregObj.Global = True: '//Set All Replace(전체 문서에서 검색)

		eregi_replace = eregObj.Replace(text, replace): '//Replace String
	End Function


	Public Function isMail(ByVal strType)
	
		Dim i, countDot, countAt, allowChar
		
		countDot = 0
		countAt = 0
		
		if isNone(strType) then
			isMail = false
			exit function
		end if
		
		allowChar = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890-_@."
		
		for i = 1 to len(strType) step 1
			if inStr(allowChar, mid(strType, i, 1)) > 0 then
				if mid(strType, i, 1) = "@" then
					if i = 1 then
						isMail = false
						exit function
					end if
					
					if mid(strType, i + 1, 1) = "." then
						isMail = false
						exit function
					end if
					
					countAt = countAt + 1
				end if
				
				if mid(strType, i, 1) = "." then
					if countAt <> 1 or i = len(strType) then
						isMail = false
						exit function
					end if
					
					if mid(strType, i + 1, 1) = "." then
						isMail = false
						exit function
					end if
					
					countDot = countDot + 1
				end if
			else
				isMail = false
				exit function
			end if
		next
		
		if countAt <> 1 or countDot = 0 or countDot > 2 then
			isMail = false
			exit function
		end if
		
		isMail = true
		
	End Function
	
	
	Sub replyMail(ByVal IntIdx, ByVal reIdx, ByVal TableName)
	
		Dim reMail, strAddopt, strEmail, strwriteDay, strWrite, buffer
			
			SQL = "SELECT addoption, email, WriteDay, Writer FROM "& TableName &" WHERE Idx = " & reIdx &""
			Set reMail = getRecordSet(getConnection(), SQL)
'			Set reMail = RunSQLReturnRS(SQL)
			If Not reMail.BOF or Not reMail.EOF Then
				strAddopt	= reMail("addoption")
				strEmail	= reMail("email")
				strwriteDay	= reMail("writeDay")
				strWrite	= reMail("Writer")
			End If
			Call CloseDB()
			
			If inRStr(strAddopt,2,",",1,1) Then
					
				if isMail(strEmail) then
			
					Dim objMail, mBody
					
					Set objMail = Server.CreateObject("CDONTS.NewMail")
					objMail.To = strEmail
					objMail.From = CONF_MASTER_NAME & "<" & CONF_MASTER_MAIL & ">"
					objMail.Subject = "[답글 알림]안녕하세요. " & CONF_SITE_NAME & "입니다."
					objMail.BodyFormat = 0
					objMail.MailFormat = 0
					objMail.Importance = 1
					
					buffer = strWriter & "님이 " & strWriteDay & "에 남기신 글에 대한 답변글이 등록되었습니다.<br><br>"
					buffer = buffer & "답변글을 보시려면, 아래 답글보기 버튼을 눌러주십시오.<br><br>"
					buffer = buffer & "<div align=""center""><a href=""#CONF_SITE_DOMAIN##CONF_BOARD_ROOT#/list.asp?TableName=" & TableName & "&Idx=" & reIdx & """ target=""_blank""><img src=""#CONF_SITE_DOMAIN##CONF_BOARD_ROOT#/member/images/buton_view_reply.gif"" border=""0""></a></div>"
					
					mBody = Server.CreateObject("Scripting.FileSystemObject").openTextFile(Server.mapPath(".") & "\mail.html", 1).readAll
					mBody = replace(mBody, "#mailSubject#", "답변글 등록 안내")
					mBody = replace(mBody, "#mailBody#", buffer)
					mBody = replace(mBody, "#CONF_SITE_DOMAIN#", CONF_SITE_DOMAIN)
					mBody = replace(mBody, "#CONF_SITE_NAME#", CONF_SITE_NAME)
					mBody = replace(mBody, "#CONF_BOARD_ROOT#", CONF_BOARD_ROOT)
					mBody = replace(mBody, "#CONF_MASTER_NAME#", CONF_MASTER_NAME)
					mBody = replace(mBody, "#CONF_MASTER_MAIL#", CONF_MASTER_MAIL)
					
					objMail.body = mBody
					objMail.send
		
				End If
			
			End If	
		
		Set objMail = Nothing
		Set reMail = Nothing
	
	End Sub	
	

	Public Function isShowPrivate(ByVal TableName, ByVal IntIdx, ByVal strPwd)
		If inRStr(Request.Cookies("private")(TableName), IntIdx & "/" & strPwd, ",", 1, 1) Then
			isShowPrivate = True
		Else
			isShowPrivate = false
		End If
		
	End Function	


	Public Function FromCollection()

		For each item in Request.Form
			Response.Write item &":"& Request.Form(item) &"<br>"
		Next
		
		Response.Write "<br><br>"

		For each item in Request.QueryString
			Response.Write item &":"& Request.QueryString(item) &"<br>"
		Next
		Response.End
	End Function	

	Private Sub SendMailAdver(ByVal IntHtmlTy, ByVal strTitle, ByVal strContent, ByVal MailTo)


		strContent = reString(strContent, "mix2")
		Set objMail = Server.CreateObject("CDO.Message")
			objMail.From = CONF_MASTER_MAIL
			objMail.To = MailTo
			objmail.Subject = strTitle
			objMail.htmlBody = strContent
			objMail.Send
		Set objMail = nothing	


	End Sub		


	
	Public Function MatchRefUrl(ByVal RefPage, ByVal fRefPage)
		
		Protocol		= Request.ServerVariables("SERVER_PROTOCOL")
		HostName		= Request.ServerVariables("SERVER_NAME")
		Path			= Request.ServerVariables("URL")

		Protocol		= mid(Protocol,1,instr(Protocol,"/")-1)
		Path			= mid(Path,1,instrrev(Path,"/"))
		ret				= Protocol&"://"&Hostname&Path&"KSPayRcv.asp"
	
	End Function
	
	

	Function getSticGraph(tableWidth, countTotal, value)
	
		If countTotal<>0 Then
			sel = tableWidth / 100 '4
			selNum =  (value / countTotal) * 100
			percent = int(selNum) & "%"  ' 퍼센트
			getSticGraph = sel * selNum
		End If  
		
	End function
	
	
	Private Function RandomCode()
	
		Dim Alphabat, RndArray, Cnt, Ordno
'		Alphabat = Year(Now())&Month(Now())&Day(Now())&Hour(Now())&Second(Now())
		Alphabat = Year(Now())
		RndArray = Alphabat
		Randomize 
		Cnt = int(rnd()*24)+1
		Ordno = int(rnd()*9999999)+1
		RandomCode = Alphabat & Ordno	
		
	End Function
	
	
	Private Function RandomCodeMine()
	
		Dim Alphabat, RndArray, Cnt, Ordno
'		Alphabat = Year(Now())&Month(Now())&Day(Now())&Hour(Now())&Second(Now())
'		Alphabat = Day(Now())
'		RndArray = Alphabat
		Randomize 
		Cnt = int(rnd()*24)+1
		Ordno = int(rnd()*99)+1
		RandomCodeMine = Alphabat & Ordno	
		
	End Function


Private Function MemRandomCode()
	
		Dim Alphabat, RndArray, Cnt, Ordno
		Alphabat = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"
		RndArray = split(Alphabat,",")
		Randomize 
		Cnt = int(rnd()*24)+1
		Ordno = int(rnd()*9999999)+1
		MemRandomCode = RndArray(Cnt) & Ordno	
				
	End Function
	

	
	Function PointChr(ByVal Points, ByVal DsPrices)
		If isNone(Points) Then
			PointChr = 0
		Else
			PointChr = (DsPrices/100)*Points
		End If
	End Function
	
	
	
	Public Function getAllot(ByVal ots1, ByVal ots2, ByVal ots3, ByVal tys, ByVal allot)
		
		If isNone(allot) Then
			Select Case tys
				Case 1 : getAllot = ots1
				Case 2 : getAllot = ots2
				Case 3 : getAllot = ots3
			End Select 
		Else
			Select Case tys
				Case 1 : getAllot = allot * ots1
				Case 2 : getAllot = allot * ots2
				Case 3 : getAllot = allot * ots3
			End Select 
			
		End If
	
	End Function
	

	
	'	============================================================================
'	=
'	=	Function : isIDPwd(strType, minSize, maxSize)
'	=
'	=	strType값이 알파벳, 숫자, -, _ 로 구성된 문자열인지 검사하고,
'	=	minSize이상 maxSize이하 크기의 문자열인지 검사하여 Boolean형 반환.
'	=
'	============================================================================

	Public Function isIDPwd(strType, minSize, maxSize)
	
		Dim passChr, i
		passChr = "abcdefghijklmnopqrstuvwxyz0123456789-_"
		
		if isNone(strType) then
			isIDPwd = false
			exit function
		end if
		
		if lengthB(strType) < minSize or lengthB(strType) > maxSize then
			isIDPwd = false
			exit function
		end if
		
		for i = 1 to len(strType) step 1
			if inStr(passChr, mid(lCase(strType), i, 1)) <= 0 then
				isIDPwd = false
				exit function
			end if
		next
		
		isIDPwd = true
		
	End Function
	
	Public Function getAlot(ByVal ots1, ByVal ots2, ByVal ots3, ByVal tys)
		
		If isNone(tys) Then
			getAlot = 0
		Else
			Select Case tys
				Case 1 : getAlot = ots1
				Case 2 : getAlot = ots2
				Case 3 : getAlot = ots3
			End Select 
			
		End If
	
	End Function


	Public Function getToAlot(ByVal gCnt)
		Set Rsf = getRecordSet(getConnection(), "SELECT gbTem, hAllot, vAllot, HcapAllotl FROM BetGame_TB WHERE gCnt='"& gCnt &"'")
'		Set Rsf = RunSQLReturnRs("SELECT gbTem, hAllot, vAllot, HcapAllotl FROM BetGame_TB WHERE gCnt='"& gCnt &"'")
		If Not Rsf.EOF Then
			Do Until Rsf.EOF
			If Rsf("gbTem") = 1 Then
				If allAllot = 0 Then 
					AllAllot = Rsf("hAllot")
				Else
					AllAllot = AllAllot * Rsf("hAllot")
				End If

			ElseIf Rsf("gbTem") = 2 Then
				If allAllot = 0 Then 
					AllAllot = Rsf("vAllot")
				Else
					AllAllot = AllAllot * Rsf("vAllot")
				End If

			ElseIf Rsf("gbTem") = 3 Then
				If allAllot = 0 Then 
					AllAllot = Rsf("HcapAllotl")
				Else
					AllAllot = AllAllot * Rsf("HcapAllotl")
				End If

			End If
			Rsf.MoveNext
			Loop
		End If


		getToAlot	=  int(AllAllot*100)/100
	
	End Function

	Public Function DubleBet(ByVal IntgIdx, ByVal IntgCnt)
		
		DubleBet = False
		Set Rss = getRecordSet(getConnection(), "SELECT Idx FROM DubleBet_TB WHERE gIdx='"& IntgIdx &"' And gCnt='"& IntgCnt &"'")
'		Set Rss = RunSQLReturnRs("SELECT Idx FROM BetGame_TB WHERE gIdx='"& IntgIdx &"' And gCnt='"& IntgCnt &"'")
		If Not ( Rss.EOF or Rss.BOF ) Then 
			DubleBet = True
		End If
		Rss.Close() : Set Rss = Nothing
		
	End Function
	

	Public Function getrMoney(ByVal IntgCnt)
	
		Set objRss = getRecordSet(getConnection(), "SELECT gbTem, hAllot, vAllot, HcapAllotl, bMoney FROM BetGame_TB WHERE gCnt='"& IntgCnt &"'")
'		Set objRss = RunSQLReturnRs("SELECT * FROM BetGame_TB WHERE gCnt='"& IntgCnt &"'")
		getrMoney = 0
		If Not objRss.EOF or Not objRss.BOF Then
			Do Until objRss.EOF
				If objRss("gbTem") = 1 Then
					If Allot = 0 Then 
						Allot = objRss("hAllot")
					Else
						Allot = Allot * objRss("hAllot")
					End If
						
				ElseIf objRss("gbTem") = 2 Then
					If Allot = 0 Then 
						Allot = objRss("vAllot")
					Else
						Allot = Allot * objRss("vAllot")
					End If
						
				ElseIf objRss("gbTem") = 3 Then
					If Allot = 0 Then 
						Allot = objRss("HcapAllotl")
					Else
						Allot = Allot * objRss("HcapAllotl")
					End If
				End If
				betmoney	= objRss("bMoney")
				
			objRss.MoveNext
			Loop
			
			Allot		= int(Allot*100)/100
			getrMoney	= Int(Allot*betmoney)
		End If
		
	End Function

	Public Function GoldHitFlag(ByVal gCnt)
		
		GoldHitFlag = false
		Set Rsf = getRecordSet(getConnection(), "SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& gCnt &"'")
'		Set Rsf = RunSQLReturnRs("SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& gCnt &"'")
		If Rsf.EOF or Rsf.BOF Then
			GoldHitFlag = false
		Else
			Do Until Rsf.EOF
				If Rsf("GoldHit") = 0 Then
					HitFlag = 0
					Exit Do
				ElseIf Rsf("GoldHit") =1 Then
					HitFlag = 1
				Else
					HitFlag = 0
					Exit Do
				End If 
			Rsf.MoveNext
			Loop

			If HitFlag = 1 Then 
				GoldHitFlag = True
			End If

		End If
	
	End Function
	
	Public Function MemRegIp(ByVal strIp)
	
		Set Rsf = getRecordSet(getConnection(), "SELECT Writeip FROM Member_TB WHERE Writeip='"& strIp &"'")
'		Set Rsf = RunSQLReturnRs("SELECT Writeip FROM Member_TB WHERE Writeip='"& strIp &"'")
		
		If Rsf.EOF or Rsf.BOF Then
			MemRegIp = false
		Else
			MemRegIp = True

		End If
		Set Ref = Nothing
	End Function


	Public Sub CloseGame()
		
		SQL1 = "UPDATE Game_TB Set Status=0 WHERE "
		SQL1 = SQL1 & " convert(varchar(16),DateAdd(n,-5,gsDate),120 ) <= convert(varchar(16),getdate(),120 ) " 
		SQL1 = SQL1 & " And Status=1 "
		RunSQL(SQL1)
		
		SQL2 = "UPDATE BetGame_TB Set Status=0 WHERE "
		SQL2 = SQL2 & " convert(varchar(16),DateAdd(n,-5,gsDate),120 ) <= convert(varchar(16),getdate(),120 ) " 
		SQL2 = SQL2 & " And Status=1 "
		RunSQL(SQL2)
		
	End Sub



	Public Sub GameCanCel(ByVal IntIdx)
		SQLs = "UPDATE BetGame_TB Set hAllot='1.00',HcapAllotl='1.00',vAllot='1.00',GoldHit=1 WHERE gIdx='"& IntIdx &"'"
		RunSQL(SQLs)
				
		SQLs = "UPDATE Game_TB Set hAllot='1.00',HcapAllotl='1.00',vAllot='1.00' WHERE Idx='"& IntIdx &"'"
		RunSQL(SQLs)

		SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE gIdx='"& IntIdx &"'"
'			Response.Write SQLs &"<BR>"
'			Response.Write SQL &"<BR>"
'			Response.End
		Set Rss = getRecordSet(getConnection(), SQL)
'		Set Rss = RunSQLReturnRs(SQL)
			If Not Rss.EOF Then
				Do Until Rss.EOF
					allAllot = 0
					Set Rss2 = getRecordSet(getConnection(), "SELECT gbTem, hAllot, HcapAllotl, vAllot, bMoney FROM BetGame_TB WHERE gCnt = '"& Rss("gCnt") &"'")
'					Set Rss2 = RunSQLReturnRs("SELECT gbTem, hAllot, HcapAllotl, vAllot, bMoney FROM BetGame_TB WHERE gCnt = '"& Rss("gCnt") &"'")
						If Not Rss2.EOF Then
							Do Until Rss2.EOF		
								If Rss2("gbTem") = 1 Then
									If allAllot = 0 Then 
										AllAllot = Rss2("hAllot")
									Else
										AllAllot = AllAllot * Rss2("hAllot")
									End If
																																	
								ElseIf Rss2("gbTem") = 2 Then
									If allAllot = 0 Then 
										AllAllot = Rss2("vAllot")
									Else
										AllAllot = AllAllot * Rss2("vAllot")
									End If
																																	
								ElseIf Rss2("gbTem") = 3 Then
									If allAllot = 0 Then 
										AllAllot = Rss2("HcapAllotl")
									Else
										AllAllot = AllAllot * Rss2("HcapAllotl")
									End If
																																	
								End If	
								betmoney	= Rss2("bMoney")

							Rss2.MoveNext
							Loop			
						End If
					Set Rss2 = Nothing
							
					allAllot	= int(allAllot*100)/100
					aHopBmoney	= Int(allAllot*betmoney)
					RunSQL("UPDATE BetGame_TB Set HaAllot='"& allAllot &"', hMoney='"& aHopBmoney &"' WHERE gCnt='"& Rss("gCnt") &"'")
					RunSQL("UPDATE SumBetGame_TB Set hMoney='"& aHopBmoney &"' WHERE gCnt='"& Rss("gCnt") &"'")
							
				Rss.MoveNext
				Loop
			End If
		Set Rss = Nothing
	End Sub
	
	
	
	
	
	
	
	
	Public Sub GameAutoClose(ByVal IntIdx)	' 경기취소일경우 처리...
	
		RunSQL("UPDATE BetGame_TB Set Status=0 WHERE gIdx='"& IntIdx &"'")	'경기결과가 경기중이 아닐떄 무조건 게임완료로 자동변경
'		RunSQL("UPDATE Game_TB Set Status=0 WHERE Idx='"& IntIdx &"'")		'경기결과가 경기중이 아닐떄 무조건 게임완료로 자동변경
		HitFlag = 0
						
		SQL = "SELECT Idx, gbTem, gCnt, rMoney, Id, hMoney, bMoney FROM BetGame_TB WHERE gIdx='"& IntIdx &"' And UHiden=0 And Visbled=0 "
		Set Rss = getRecordSet(getConnection(), SQL)
'		Set Rss = RunSQLReturnRs(SQL)
		If Not Rss.EOF Then
			Do Until Rss.EOF
							
				HitFlag = 0
				sSQL = "SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& Rss("gCnt") &"'"
'				Set Rss2 = getRecordSet(getConnection(), sSQL)
				Set Rss2 = RunSQLReturnRs(sSQL)
				If Not Rss2.EOF Then arrRs = Rss2.getRows() : arrRsCnt = Ubound(arrRs,2) : Set Rss2 = Nothing
									
				If Not isNone(arrRsCnt) Then 
					For i=0 To	arrRsCnt
												
						If arrRs(0,i) = 0 Then
							HitFlag = 0
							Exit For
						ElseIf arrRs(0,i) =1 Then
							HitFlag = 1
						Else
							HitFlag = 0
							Exit For
						End If 
													
					Next
				End If 
				rMoneys = 0
				rMoneys = getrMoney(Rss("gCnt"))
					
				If reInt(Rss("rMoney"),0) = 0 Then
					If HitFlag = 1 Then 
						Call CashChange(Rss("Id"), reInt(rMoneys,0), 3, 1, "배팅적중 적립", Rss("gCnt"))
						RunSQL("UPDATE BetGame_TB Set rMoney='"& reInt(rMoneys,0) &"', ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'")
						RunSQL("UPDATE SumBetGame_TB Set rMoney='"& reInt(rMoneys,0) &"', ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'")
					End If
					
					RunSQL("UPDATE BetGame_TB Set hMoney='"& reInt(rMoneys,0) &"' WHERE gCnt='"& Rss("gCnt") &"'")
					RunSQL("UPDATE SumBetGame_TB Set hMoney='"& reInt(rMoneys,0) &"' WHERE gCnt='"& Rss("gCnt") &"'")
				End If
			Rss.MoveNext
			Loop
		End If	
	
	End Sub
	
	
		
	Public Sub GameAutoClose2(ByVal IntIdx, ByVal IntgbTem)	'승무패 경기일 경우 자동마감처리...
		HitFlag = 0
'		RunSQL("UPDATE BetGame_TB Set Status=0 WHERE gIdx='"& IntIdx &"'")	'경기결과가 경기중이 아닐떄 무조건 게임완료로 자동변경
'		RunSQL("UPDATE Game_TB Set Status=0 WHERE Idx='"& IntIdx &"'")		'경기결과가 경기중이 아닐떄 무조건 게임완료로 자동변경
						
		SQL = "SELECT Idx, gbTem, gCnt, rMoney, Id, hMoney, MisPF FROM BetGame_TB WHERE gIdx='"& IntIdx &"' And rMoney=0 "
'		Response.Write SQL
'		Response.End
		Set Rss = getRecordSet(getConnection(), SQL)
'		Set Rss = RunSQLReturnRs(SQL)

		If Not Rss.EOF Then

			Do Until Rss.EOF

				
				If reInt(IntgbTem,0) <> Rss("gbTem") Then	'경기결과 값이 배팅선택 과 다른경우
							
					'배팅한 내역중 현제 게임과 같은 경기가 있을경우 적중유무 변경
					RunSQL("UPDATE BetGame_TB Set GoldHit=2 WHERE gCnt='"& Rss("gCnt") &"' And Idx='"& Rss("Idx") &"'")
					
					'담기중 미적중이 하나라도 있으면 적중금액 0변경 하고 정산완료시킴
					RunSQL("UPDATE BetGame_TB Set rMoney=0, ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'")
					RunSQL("UPDATE SumBetGame_TB Set rMoney=0, ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'")

					If reInt(Rss("MisPF"),0) = 0 Then
						Call GameMisPoint(Rss("gCnt"))
					End If
				Else	
					'현제 게임경기결과가 맞을경우 나머지 담기에 같이 담기 경기들 검색해서 
					'이번게임과 합쳐 모두 적중이면 적중금액 적립해 주고 베팅테이블 정산결과 정산완료 변경
											
					RunSQL("UPDATE BetGame_TB Set GoldHit=1 WHERE Idx='"& Rss("Idx") &"'")
					HitFlag = 0
					HitFlag = AllHitFlag (Rss("gCnt"))
					
					rMoneys = 0
					rMoneys = getrMoney(Rss("gCnt"))
						
					If HitFlag = 1 Then 
						Call CashChange(Rss("Id"), reInt(rMoneys,0), 3, 1, "배팅적중 적립", Rss("gCnt"))
						RunSQL("UPDATE BetGame_TB Set rMoney='"& reInt(rMoneys,0) &"', ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'")
						RunSQL("UPDATE SumBetGame_TB Set rMoney='"& reInt(rMoneys,0) &"', ResuFlag=1  WHERE gCnt='"& Rss("gCnt") &"'")
					End If
												
					RunSQL("UPDATE BetGame_TB Set hMoney='"& reInt(rMoneys,0) &"' WHERE gCnt='"& Rss("gCnt") &"'")
					RunSQL("UPDATE SumBetGame_TB Set hMoney='"& reInt(rMoneys,0) &"' WHERE gCnt='"& Rss("gCnt") &"'")
				End If
				
			Rss.MoveNext
			Loop
		End If
	
	End Sub


	Public Function AllHitFlag (ByVal IntgCnt)
	
		AllHitFlag = 0
		sSQL = "SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& IntgCnt &"'"
		Set Rss2 = RunSQLReturnRs(sSQL)
		If Not Rss2.EOF Then arrRs = Rss2.getRows() : arrRsCnt = Ubound(arrRs,2) : Set Rss2 = Nothing
									
		If Not isNone(arrRsCnt) Then 
			For i=0 To	arrRsCnt
											
				If arrRs(0,i) = 0 Then
					AllHitFlag = 0
					Exit For
				ElseIf arrRs(0,i) =1 Then
					AllHitFlag = 1
				Else
					AllHitFlag = 0
					Exit For
				End If 
												
			Next
		End If 
	
	End Function
	
	
	Public Sub GameAutoClose2Event(ByVal IntIdx, ByVal IntgbTem) '이벤트이고, 경기취소일 경우	
		HitFlag = 0
		SQL = "SELECT Idx, gbTem, gCnt, rMoney, Id, hMoney, bMoney FROM BetGame_TB WHERE gIdx='"& IntIdx &"' And UHiden=0 And Visbled=0 "
		Set Rss = getRecordSet(getConnection(), SQL)
'		Set Rss = RunSQLReturnRs(SQL)
		If Not Rss.EOF Then
			Do Until Rss.EOF
				gCnt	= Rss("gCnt")
				If reInt(IntgbTem,0) <> Rss("gbTem") Then	'경기결과 값이 배팅선택 과 다른경우
							
					'배팅한 내역중 현제 게임과 같은 경기가 있을경우 적중유무 변경
					SQLs = "UPDATE BetGame_TB Set GoldHit=2 WHERE Idx='"& Rss("Idx") &"' "
					RunSQL(SQLs)
										
					'담기중 미적중이 하나라도 있으면 적중금액 0변경 하고 정산완료시킴
					SQLs = "UPDATE BetGame_TB Set rMoney=0, ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'"
					RunSQL(SQLs)
					RunSQL("UPDATE SumBetGame_TB Set rMoney=0, ResuFlag=1 WHERE gCnt='"& Rss("gCnt") &"'")
									
				Else	
					'현제 게임경기결과가 맞을경우 나머지 담기에 같이 담기 경기들 검색해서 
					'이번게임과 합쳐 모두 적중이면 적중금액 적립해 주고 베팅테이블 정산결과 정산완료 변경
								
'					Response.Write SQLs &":2<BR>"
'					Response.Write arrValue(22) &":ST<BR>"
'					Response.End						
					RunSQL("UPDATE BetGame_TB Set GoldHit=1 WHERE Idx='"& Rss("Idx") &"'")
					HitFlag = 0
						
					rMoneys = 0
					rMoneys = getrMoney(Rss("gCnt"))																			
						
					RunSQL("UPDATE BetGame_TB Set hMoney='"& reInt(rMoneys,0) &"' WHERE gCnt='"& Rss("gCnt") &"'")
					RunSQL("UPDATE SumBetGame_TB Set hMoney='"& reInt(rMoneys,0) &"' WHERE gCnt='"& Rss("gCnt") &"'")
				End If

			Rss.MoveNext
			Loop
		End If

	End Sub
	
	
	Public Sub GameMisPoint(ByVal IntgCnt)
		MisPointFlag = 0
		If Not isNone(IntgCnt) Then 
			SQL = "SELECT Idx, bMoney, ResuFlag, Id, gIdx FROM BetGame_TB WHERE gCnt='"& IntgCnt &"' And UHiden=0 And Visbled=0 And MisPF=0 And rMoney=0"
			Set Rss = getRecordSet(getConnection(), SQL)
'			Set Rss = RunSQLReturnRs(SQL)
			
			If Not Rss.EOF Then
				bMoney	= Rss("bMoney")
				strId	= Rss("Id")
				IntgIdx	= Rss("gIdx")
				Do Until Rss.EOF
					If Rss("ResuFlag")=0 Then
						MisPointFlag = 0
						Exit Do
					Else
						MisPointFlag = 1
					End If
				Rss.MoveNext
				Loop
			End If
		End If
		If MisPointFlag = 1 Then
			MisPoint = (bMoney/100)*2 
			MisPoint = int(MisPoint*100)/100
			MisPoint = int(MisPoint)
			TCash = NowMileage(strId, "APoint")
			
			SQLs = "INSERT INTO Point_TB (Id,Point,TPoint,ResultPoint,MisP, Comment,gIdx,gCnt,Type) VALUES ('"& strId &"','"& reInt(MisPoint,0) &"','"& TCash &"','"& reInt(MisPoint,0)+TCash &"','"& MisPoint &"','미적중 2%적립','"& IntgIdx &"','"& IntgCnt &"',4)"
			RunSQL(SQLs)
			
			SQLs2 = "UPDATE Member_TB Set APoint = APoint+'"& reInt(MisPoint,0) &"' WHERE Id='"& strId &"'"
			RunSQL(SQLs2)

'			Call CashChange(strId, reInt(MisPoint,0), 4, 4, "미적중 2%적립")
			RunSQL("UPDATE BetGame_TB Set MisPF=1 WHERE gCnt='"& IntgCnt &"'")
		End If
	End Sub
	
	
	Public Function HandGameMisPointFlag(ByVal IntgCnt)

		HandGameMisPointFlag = 0
		
		If Not isNone(IntgCnt) Then 
			sSQL = "SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& IntgCnt &"' And UHiden=0 And Visbled=0 And MisPF=0 "
			Set Rss2 = getRecordSet(getConnection(), sSQL)
'			Set Rss2 = RunSQLReturnRs(sSQL)
			If Not Rss2.EOF or Not Rss2.BOF Then
									
				Do Until Rss2.EOF
												
					If Rss2(0) = 2 Then	'미적중이 있다면...
						HandGameMisPointFlag = 1
						Exit Do
					End If 
													
				Rss2.MoveNext
				Loop
			End If 					
		End If
		
	End Function


	Public Sub IpFilter()
		
		SQL = "SELECT Writeip,FloginIp,LloginIp FROM Member_TB WHERE Seceid='2'"
		Set Rss = getRecordSet(getConnection(), SQL)
'		Set Rss = RunSQLReturnRs(SQL)
		strIp	= Request.ServerVariables("REMOTE_ADDR")
		If Not Rss.EOF Then
			Do Until Rss.EOF
				
				If inRStr(strIp, Rss("Writeip"), ".", 0, 1) Then Call descMentPage("","top.location.href='http://www.auction.co.kr'","")
				If inRStr(strIp, Rss("FloginIp"), ".", 0, 1) Then Call descMentPage("","top.location.href='http://www.auction.co.kr'","")
				If inRStr(strIp, Rss("LloginIp"), ".", 0, 1) Then Call descMentPage("","top.location.href='http://www.auction.co.kr'","")

			Rss.MoveNext
			Loop
		End If
		Call closeResource(Rss)
	End Sub
	
	
	
	Public Function GoldHitSmsFlag(ByVal IntgCnt)
		
		GoldHitSmsFlag = 0
		If Not isNone(IntgCnt) Then
			SQL = "SELECT GoldHit FROM BetGame_TB WHERE gCnt='"& IntgCnt &"' "
			Set Rsss = getRecordSet(getConnection(), SQL)
'			Set Rsss = RunSQLReturnRs(SQL)

			If Not Rsss.EOF Then			
				Do Until Rsss.EOF
					If Rsss("GoldHit") =2 Then		'미적중 발송안함
						GoldHitSmsFlag = 1
						Exit Do							
					End If
				Rsss.MoveNext
				Loop
			End If
			
		End If
				
	End Function 
	
	
	Public Function GoldHitSmsNums(ByVal IntIdx)
		
		GoldHitSmsNums = ""
		If Not isNone(IntIdx) Then
			SQL = "SELECT gCnt, Id FROM BetGame_TB WHERE gIdx='"& IntIdx &"' And UHiden=0 "
			Set Rss = getRecordSet(getConnection(), SQL)
'			Set Rss = RunSQLReturnRs(SQL)
			If Not Rss.EOF or Not Rss.BOF Then
				Do Until Rss.EOF
					SndFlag = GoldHitSmsFlag(Rss("gCnt"))
					
					SQL = "SELECT b.GoldHit, m.gSms, m.Cell, m.Id FROM BetGame_TB b, Member_TB m WHERE b.Id=m.Id And b.GoldHit=1 And b.gCnt='"& Rss("gCnt") &"' And m.Id='"& Rss("Id") &"'"
					Set Rss2 = getRecordSet(getConnection(), SQL)
'					Set Rss2 = RunSQLReturnRs(SQL)
					If Not Rss2.EOF or Not Rss2.BOF Then
						
						Do Until Rss2.EOF				
							If Rss2(0) =0 And SndFlag = 0 And Rss2("gSms") = 1 Then	'대기중 발송함
								If inRStr(NoGoldId, Rss2("Id"), ",", 1, 1) = false Then
									If inRStr(GoldHitSmsNums, Rss2("Cell"), ",", 1, 1) = false Then GoldHitSmsNums = GoldHitSmsNums &","& Rss2("Cell")
								End If
							
							ElseIf Rss2(0) =1 And SndFlag = 0 And Rss2("gSms") = 1 Then	'적중 발송함
								If inRStr(NoGoldId, Rss2("Id"), ",", 1, 1) = false Then
									If inRStr(GoldHitSmsNums, Rss2("Cell"), ",", 1, 1) = false Then GoldHitSmsNums = GoldHitSmsNums &","& Rss2("Cell")
								End If
								
							ElseIf Rss2(0) =2 Then		'미적중 발송안함
								NoGoldId = NoGoldId &","& Rss2("Id")
								If inRStr(GoldHitSmsNums, Rss2("Cell"), ",", 1, 1) Then
									 GoldHitSmsNums = replace(GoldHitSmsNums,Rss2("Cell"),"")
								End if

							End If
						Rss2.MoveNext
						Loop
					End If

				Rss.MoveNext
				Loop
			End If
		End If
				
	End Function 
	
	
	
	Public Function CloseGameFlag(ByVal IntIdx)
		
		CloseGameFlag = 1
		Set Rss = getRecordSet(getConnection(), "SELECT Status FROM Game_TB WHERE Idx='"& IntIdx &"'")
'		Set Rss = RunSQLReturnRs("SELECT Status FROM Game_TB WHERE Idx='"& IntIdx &"'")
		
		If Rss.EOF Then
			 CloseGameFlag = 0
		Else
			If Rss(0) <> 1 Then CloseGameFlag = 0
		End If						
		
	End Function
	
	
	
%>





