<script language="VBScript" runAt="Server">

	
	Public Function insertDB(tableName, columnName, columnValue)
	
		Dim buffer, buffer2, i
		
		buffer = ""
		buffer2 = ""
		
		For i = LBound(columnName) to UBound(columnName) step 1
			If Not isNone(columnName(i)) Then
				If Not isNone(buffer) Then
					buffer = buffer & ","
					buffer2 = buffer2 & ","
				End If
				
				buffer = buffer & columnName(i)				
				buffer2 = buffer2 & "'" & columnValue(i) & "'"

			End If
		Next
		
		insertDB = "INSERT INTO " & reString(tableName, "sql") & " (" & buffer & ") VALUES (" & buffer2 & ")"
		
	End Function
	



	Public Function updateDB(tableName, columnName, columnValue)
	
		Dim buffer, i
		
		buffer = ""
		
		for i = LBound(columnName) to UBound(columnName) step 1
			if not isNone(columnName(i)) then
				if not isNone(buffer) then
					buffer = buffer & ","
				end if
				
				buffer = buffer & columnName(i) & " = "				
				buffer = buffer & "'" & columnValue(i) & "'"
			end if
		next
		
		updateDB = "update " & reString(tableName, "sql") & " set " & buffer
	
	End Function	




	Private Sub DeleteDB(IntIdx,TableName)
	
		Dim idInt, idRef, idRows, idCols, idFile1, idFile2, idIP
		Dim sql, rs, i
				
		SQL = "SELECT ref, re_level, re_step, file1, file2 FROM " & TableName & " WHERE Idx = " & IntIdx &""
		
		Set objRs = RunSQLReturnRs(SQL)
		If Not objRs.EOF or Not Bof Then
			IntRef		= objRs("ref")
			IntRe_level	= objRs("re_level")
			IntRe_step	= objRs("re_step")
			strFile1	= objRs("file1")
			strFile2	= objRs("file2")
		End If
		objRs.Close
		'첨부파일1 삭제
		If Not isNone(strFile1) Then Call deleteFile(CONF_DEFAULT_PATH & TableName & "\[" & IntIdx & "_1]" & getInfo(strFile1, 0, chr(13) & chr(10)))
		
		'첨부파일2 삭제
		If Not isNone(strFile2) Then Call deleteFile(CONF_DEFAULT_PATH & TableName & "\[" & IntIdx & "_2]" & getInfo(strFile2, 0, chr(13) & chr(10)))
		
		
		SQL = "SELECT Idx,ref,re_step FROM "& TableName &" WHERE ref = '"& IntRef &"' AND ( (re_level > '"& IntRe_level &"') or ( re_level = '"& IntRe_level &"' and re_step > '"& IntRe_step &"') )"
		Set objRs = RunSQLReturnRS(SQL)
				
		'하위 글이 없으면, id글을 삭제할 수 있다.
		If objRs.BOF or objRs.EOF Then
			If CONF_USECOMMENT = 1 Then	RunSQL("DELETE FROM "& TableName &"_Comment WHERE bnum = " & IntIdx &"")
			RunSQL("UPDATE "& TableName &" Set Hidden=1, PRef=1 WHERE Idx = " & IntIdx &"")
'			RunSQL("DELETE FROM "& TableName &" WHERE Idx = " & IntIdx &"")
			
			'삭제보류중인 상위글이 존재하는지 검사고 있으면 삭제.
			RunSQL("UPDATE "& TableName &" Set Hidden=1, PRef=1 WHERE ref = '" & IntRef &"' And ip='delete' And ( (re_level < '"& IntRe_level &"') or ( re_level <= '"& IntRe_level &"' and re_step < '"& IntRe_step &"') )"  )
'			RunSQL("DELETE FROM "& TableName &" WHERE ref = '" & IntRef &"' And ip='delete' And ( (re_level < '"& IntRe_level &"') or ( re_level <= '"& IntRe_level &"' and re_step < '"& IntRe_step &"') )"  )
	
		'하위글이 존재하면, 삭제할 수 없으므로, IP값을 "delete"로 바꾸어 삭제 보류한다.
		Else
		
			RunSQL("UPDATE "& TableName &" Set Hidden=1, PRef=1 WHERE Idx = " & IntIdx &"")
'			RunSQL("DELETE FROM "& TableName &"  WHERE Idx = " & IntIdx &"")
					
		End If
		
		Call CloseDB()
	
	End Sub
	
	
	Private Sub CmtDeleteDB(IntIdx, TableName)
	
		RunSQL("DELETE FROM "& TableName &"  WHERE num = " & IntIdx &"")		
		Call CloseDB()
	
	End Sub
	
</script>