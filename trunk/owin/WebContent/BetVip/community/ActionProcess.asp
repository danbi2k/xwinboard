<%
	Dim arrName(30), arrValue(30)
	Dim fileName(2), fileSize(2)
	
	
		If strFlag = "MODIFY" or strFlag = "DELETE" Then

			If not checkRight(strId, "board") Then Call descment("권한이 없습니다.", "back","")
			
		End If
	
		If strFlag = "private" Then
	
			If Not checkRight(strId, "board") Then  Call descment("권한이 없습니다.", "back","")	

		End If

	If strFlag <> "MODIFY" Then
		arrName(0) = "Idx"
		arrName(1) = "ref"
		arrName(2) = "re_step"
		arrName(3) = "re_level"
		arrName(4) = "ip"
	End If
	
	arrName(5) = "subject"
	arrName(6) = "writer"
	arrName(7) = "email"
	
	If strFlag = "MODIFY" Then
		If Not isNone(GetFile("file1")) or reInt(GetQuery("delfile1"), 0) = 1 Then arrName(8) = "file1"
		If Not isNone(GetFile("file2")) or reInt(GetQuery("delfile2"), 0) = 1 Then arrName(9) = "file2"
		If Not isNone(GetFile("file3")) or reInt(GetQuery("delfile3"), 0) = 1 Then arrName(10) = "file3"
	Else
		arrName(8) = "file1"
		arrName(9) = "file2"
		arrName(10) = "file3"
	End If
'	arrName(11) = "part"
'	arrName(12) = "tel"
	arrName(18) = "pwd"
	arrName(19) = "content"	
	arrName(20) = "html"
	arrName(21) = "addoption"

	arrName(23) = "Id"
	arrName(24) = "Sect"
	arrName(25) = "Notk"
	



	If strFlag = "WRITE" Then
		
		Set Max = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM " & TableName &"")
			Maxnum = Max(0)
		Call CloseDB()
		
		arrValue(0) = Maxnum
		arrValue(1) = Maxnum
		arrValue(2) = 0
		arrValue(3) = 0
		arrValue(4) = getIp()
		
		
	ElseIf strFlag = "REPLY" Then
	
		If not isInt(IntIdx) or IsNone(IntIdx) Then
			Call descment("잘못된 정보를 요청하셨습니다.", "back","")
		End If
		
		Set Max = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM " & TableName &"")
			Maxnum = Max(0)
		Set Max = Nothing

		SQL = "SELECT ref,re_level,re_step FROM "& TableName &" WHERE Idx="& IntIdx &""
		Set objRs = RunSQLReturnRs(SQL)

		ref		= objRs("ref")
		re_level= objRs("re_level")
		re_step	= objRs("re_step")
	    objRs.Close
	    
		SQL = "SELECT * FROM "& TableName &" WHERE ref="& ref &" AND re_step > "& re_step &" AND re_level <= "& re_level &" ORDER BY re_step"
		Set objRs = RunSQLReturnRs(SQL)
		
		If objRs.BOF or objRs.EOF Then
			SQL = "SELECT * FROM "& TableName &" WHERE ref="& ref &" AND re_step > "& re_step &" AND re_level > "& re_level &" ORDER BY re_step DESC"
		Else
			reid2 = objRs("re_step")
			SQL = "SELECT * FROM "& TableName &" WHERE ref="& ref &" AND re_step > "& re_step &" AND re_step< " & reid2 & " and re_level > " & re_level & " ORDER BY re_step DESC"
		End If

		Set objRs = RunSQLReturnRs(SQL)

		IF Not (objRs.BOF or objRs.EOF) Then re_step= objRs("re_step")
	    Call CloseDB()


		arrValue(0) = Maxnum
		arrValue(1) = ref
		arrValue(2) = re_step + 1
		arrValue(3) = re_level + 1
		arrValue(4) = getIp()

		
	ElseIf strFlag = "MODIFY" or strFlag = "DELETE" Then
	
		If Not isInt(IntIdx) Then Call descment("잘못된 정보를 요청하셨습니다.", "back","")

	End If
	
	If Not isNone(wordFilter(GetQuery("subject"))) Then Call descment("제목에 사용 금지단어인 """ & wordFilter(GetQuery("subject")) & """을 입력하셨습니다.", "back","")
	If Not isNone(wordFilter(GetQuery("writer"))) Then Call descment("이름에 사용 금지단어인 """ & wordFilter(GetQuery("subject")) & """을 입력하셨습니다.", "back","")
	If Not isNone(wordFilter(GetQuery("content"))) Then Call descment("본문에 사용 금지단어인 """ & wordFilter(GetQuery("subject")) & """을 입력하셨습니다.", "back","")
		
	arrValue(5) = reString(GetQuery("subject"), "sql")
	arrValue(6) = reString(GetQuery("writer"), "sql")
	arrValue(7) = reString(GetQuery("email"), "sql")
'	arrValue(11) = reString(GetQuery("part"), "sql")
'	arrValue(12) = reString(GetQuery("tel1"), "sql") &"-"& reString(GetQuery("tel2"), "sql") &"-"& reString(GetQuery("tel3"), "sql")
	arrValue(18) = reString(GetQuery("pwdd"), "sql")
	arrValue(19) = reString(GetQuery("content"), "sql")
	arrValue(20) = reInt(GetQuery("html"),0)
	arrValue(21) = reString(GetQuery("addoption"), "sql")

	arrValue(23) = strId
	arrValue(24) = reString(GetQuery("Sect"), "sql")
	arrValue(25) = reInt(GetQuery("notk"),0)
	
	If strFlag = "MODIFY" Then Ints = IntIdx Else Ints = arrValue(0) End If 
	For i = 1 to 10
		If not isNone(GetFile("file" & i)) Then			
			Files = SaveFileRtnNames(GetQuery("file"&i), "file"&i, "[" & Ints & "_" & i & "]" & getFileName(GetQuery("file"&i), "name") &"."& getFileName(GetQuery("file"&i), "ext") , "none", "100000", CONF_FILE_DIRPATH&TableName&"\","",0)
			arrValue(7 + i) = getFileName(GetQuery("file"&i), "name") &"."& getFileName(GetQuery("file"&i), "ext")  & chr(13) & chr(10) & GetFileSize("file" & i) & chr(13) & chr(10) & "0"
			Files = ""
			Call DeleteFile(CONF_FILE_DIRPATH&TableName&"\"&"["& Ints &"_"& i &"]"& OldFile)
		End If
	Next

	
	Select Case strFlag
		Case "WRITE"
			
			
			SQL = insertDB(TableName, arrName, arrValue)
			RunSQL(SQL)
			Call CloseDB()
			
		Case "REPLY"
			
			SQL=" UPDATE "& TableName &" SET re_step = re_step + 1 where ref = "& ref & " AND re_step > " & re_step &""
			RunSQL(SQL)
			
			SQL = insertDB(TableName, arrName, arrValue)
			RunSQL(SQL)
			Call CloseDB()
			
		Case "MODIFY"
		
			SQL = "SELECT file1, file2, file3 FROM " & TableName & " WHERE Idx = " & IntIdx &""
			
			Set objRs = RunSQLReturnRs(SQL)
			
			if reInt(GetQuery("delfile1"), 0) = 1 or Not isNone(arrValue(8)) then
				
				imsi = getInfo(objRs("file1"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_DEFAULT_PATH & TableName & "\[" & IntIdx & "_1]" & imsi)
								
			End If
			
			If reInt(GetQuery("delfile2"), 0) = 1 or Not isNone(arrValue(9)) then
				
				imsi = getInfo(objRs("file2"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_DEFAULT_PATH & TableName & "\[" & IntIdx & "_2]" & imsi)
				
			End If
			
			If reInt(GetQuery("delfile3"), 0) = 1 or Not isNone(arrValue(10)) then
				
				imsi = getInfo(objRs("file3"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_3]" & imsi)
				
			End If
					
			SQL = updateDB(TableName, arrName, arrValue) & " WHERE Idx = " & IntIdx &""
			RunSQL(SQL)
			Call CloseDB()
			
		Case "DELETE"

			Call DeleteDB(IntIdx, TableName)
			Call CloseDB()
			
	End Select	
	Call CloseDB()
	
	Call closeDB()
%>