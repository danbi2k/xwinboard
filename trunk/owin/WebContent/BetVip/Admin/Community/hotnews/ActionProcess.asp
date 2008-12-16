<%
	
	Dim arrName(20), arrValue(20)
	Dim fileName(2), fileSize(2)
		
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
	Else
		arrName(8) = "file1"
		arrName(9) = "file2"
	End If
	
	arrName(10) = "pwd"
	arrName(11) = "content"	
	arrName(12) = "html"
	arrName(13) = "addoption"
	arrName(14) = "HomePage"
	arrName(15) = "notk"
	arrName(16) = "Sect"
	arrName(17) = "Id"
	

	If strFlag = "WRITE" Then
		
		Set objRs = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM " & TableName &"")
			Maxnum = objRs(0)
		Call CloseDB()
		
		arrValue(0) = Maxnum
		arrValue(1) = Maxnum
		arrValue(2) = 0
		arrValue(3) = 0
		arrValue(4) = getIp()
		
	ElseIf strFlag = "REPLY" Then
	
		If Not isInt(IntIdx) Or IsNone(IntIdx) Then Call descment("잘못된 정보를 요청하셨습니다.", "back","")

		
		Set objRs = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM " & TableName &"")
			Maxnum = objRs(0)
		objRs.Close

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

		
	ElseIf strFlag = "MODIFY" Or strFlag = "DELETE" Then
	
		If Not isInt(IntIdx) Then Call descment("잘못된 정보를 요청하셨습니다.", "back","")

	End If
	
	arrValue(5) = reString(GetQuery("subject"), "sql")
	arrValue(6) = reString(GetQuery("writer"), "sql")
	arrValue(7) = reString(GetQuery("email"), "sql")
	arrValue(10) = reString(GetQuery("pwdd"), "sql")
	arrValue(11) = reString(GetQuery("content"), "sql")
	arrValue(12) = reInt(GetQuery("html"),0)
	arrValue(13) = GetQuery("addoption")
	arrValue(14) = GetQuery("homepage")
	arrValue(15) = reInt(GetQuery("notk"),0)
	arrValue(16) = GetQuery("Sect")
	arrValue(17) = GetQuery("Id")

	If strFlag = "MODIFY" Then Ints = IntIdx Else Ints = arrValue(0) End If 
	For i = 1 to 2
	
		If not isNone(GetFile("file" & i)) then
			
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
			
			'답글메일통보 기능부분
'			Call replyMail(IntIdx, arrValue(1), TableName)
			Call CloseDB()
			
		Case "MODIFY"
		
			SQL = "SELECT file1, file2 FROM " & TableName & " WHERE Idx = " & IntIdx &""
			
			Set objRs = RunSQLReturnRs(SQL)
			
			if reInt(GetQuery("delfile1"), 0) = 1 or Not isNone(arrValue(8)) then
				
				imsi = getInfo(objRs("file1"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_1]" & imsi)
								
			End If
			
			If reInt(GetQuery("delfile2"), 0) = 1 or Not isNone(arrValue(9)) then
				
				imsi = getInfo(objRs("file2"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_2]" & imsi)
				
			End If
					
			SQL = updateDB(TableName, arrName, arrValue) & " WHERE Idx = " & IntIdx &""
			RunSQL(SQL)
			
			Call CloseDB()

		Case "DELETE"

			Call DeleteDB(IntIdx, TableName)
			
	End Select	
	
	Call closeDB()
%>