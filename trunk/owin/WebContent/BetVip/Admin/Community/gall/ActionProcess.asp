<%
	
	Dim arrName(30), arrValue(30)
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
		If Not isNone(GetFile("file1")) or reInt(GetQuery("delfile1"), 0) = 1 Then arrName(16) = "file1"
		If Not isNone(GetFile("file2")) or reInt(GetQuery("delfile2"), 0) = 1 Then arrName(17) = "file2"
		If Not isNone(GetFile("file3")) or reInt(GetQuery("delfile3"), 0) = 1 Then arrName(18) = "file3"

	Else
		arrName(16) = "file1"
		arrName(17) = "file2"
		arrName(18) = "file3"
		
	End If
	
	arrName(8) = "pwd"
	arrName(9) = "content"	
	arrName(10) = "html"
	arrName(11) = "addoption"
	arrName(12) = "Id"
	arrName(13) = "notk"
	arrName(14) = "Sect"
	arrName(15) = "part"

	
	If strFlag = "WRITE" Then
	
		
		Set objRs = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM "& TableName &"")
			Maxnum = objRs(0)
		Call CloseDB()
		
		arrValue(0) = Maxnum
		arrValue(1) = Maxnum
		arrValue(2) = 0
		arrValue(3) = 0
		arrValue(4) = getIp()
		
	ElseIf strFlag = "REPLY" Then
		
		
		Set objRs = RunSQLReturnRs("SELECT isNull(MAX(Idx),0)+1 FROM " & TableName &"")
			Maxnum = objRs(0)
		Call CloseDB()

		arrValue(0) = Maxnum
		arrValue(1) = IntIdx
		arrValue(2) = re_step + 1
		arrValue(3) = re_level + 1
		arrValue(4) = getIp()

		arrValue(19) = reString(GetQuery("ComContent"), "sql")
		arrValue(20) = "1"

		
	ElseIf strFlag = "MODIFY" Or strFlag = "DELETE" Then
	
		If Not isInt(IntIdx) Then Call descment("잘못된 정보를 요청하셨습니다.", "back","")

	End If
	
	arrValue(5) = reString(GetQuery("subject"), "sql")
	arrValue(6) = reString(GetQuery("writer"), "sql")
	arrValue(7) = reString(GetQuery("email"), "sql")
	arrValue(8) = reString(GetQuery("pwd"), "sql")
	arrValue(9) = reString(GetQuery("content"), "sql")
	arrValue(10) = reInt(GetQuery("html"),0)
	arrValue(11) = GetQuery("addoption")
	arrValue(12) = GetQuery("Id")
	arrValue(13) = reInt(GetQuery("notk"),0)
	arrValue(14) = GetQuery("Sect")
	arrValue(15) = GetQuery("part")
	
'	response.write arrValue(18)
'	response.end

	If strFlag = "MODIFY" Then Ints = IntIdx Else Ints = arrValue(0) End If 

	For i = 1 to 3
		If not isNone(GetFile("file" & i)) then
			Files = SaveFileRtnNames(GetQuery("file"&i), "file"&i, "[" & Ints & "_" & i & "]" & getFileName(GetQuery("file"&i), "name") &"."& getFileName(GetQuery("file"&i), "ext") , "none", "100000", CONF_FILE_DIRPATH&TableName&"\","",0)
			If strFlag = "MODIFY" Then 
				Files = mid(Files, inStr(Files, "]") + 1, 100 )
				arrValue(15 + i) = getFileName(Files, "name") &"."& getFileName(Files, "ext")  & chr(13) & chr(10) & GetFileSize("file" & i) & chr(13) & chr(10) & "0"
			Else
				arrValue(15 + i) = getFileName(GetQuery("file"&i), "name") &"."& getFileName(GetQuery("file"&i), "ext")  & chr(13) & chr(10) & GetFileSize("file" & i) & chr(13) & chr(10) & "0"
			End If
			Files = ""
'			Call DeleteFile(CONF_FILE_DIRPATH&TableName&"\"&"["& Ints &"_"& i &"]"& OldFile)
		End If
		
	Next
'			Response.Write arrValue(16) &"<BR>"
'			Response.Write arrValue(17) &"<BR>"
'			Response.End	
	Select Case strFlag
		Case "WRITE"
			
			SQL = insertDB(TableName, arrName, arrValue)
'			Response.Write SQL
'			Response.End
			RunSQL(SQL)
			Call CloseDB()
			
		Case "REPLY"
			
			SQL = insertDB(TableName, arrName, arrValue)
'			Response.Write SQL
			RunSQL(SQL)
						
			'답글메일통보 기능부분
			Call CloseDB()
			
		Case "MODIFY"
		
			SQL = "SELECT * FROM " & TableName & " WHERE Idx = " & IntIdx &""
			
			Set objRs = RunSQLReturnRs(SQL)
			
			if reInt(GetQuery("delfile1"), 0) = 1 or Not isNone(arrValue(16)) then
				imsi = getInfo(objRs("file1"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_1]" & imsi)
			End If
			
			If reInt(GetQuery("delfile2"), 0) = 1 or Not isNone(arrValue(17)) then
				imsi = getInfo(objRs("file2"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_2]" & imsi)
			End If
			
			If reInt(GetQuery("delfile3"), 0) = 1 or Not isNone(arrValue(18)) then
				imsi = getInfo(objRs("file3"), 0, chr(13) & chr(10))
				Call deleteFile(CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_3]" & imsi)
			End If

			SQL = updateDB(TableName, arrName, arrValue) & " WHERE Idx = " & IntIdx &""
'			Response.Write SQL
'			Response.End
			RunSQL(SQL)
			
			Call CloseDB()

		Case "DELETE"

			Call DeleteDB(IntIdx, TableName)
			
	End Select	
	
	Call closeDB()
%>