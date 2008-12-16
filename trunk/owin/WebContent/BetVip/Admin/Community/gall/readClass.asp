<%

REM -------------------------------------
REM -- 변수값 설정
REM -------------------------------------
IntIdx			= Request("Idx")
strKeyField		= Request("KeyField")
strKeyWord		= Request("KeyWord")
strSortColumn	= Request("SortColumn")
strSort			= Request("Sort")
CurPage			= Trim(Request("CurPage"))
CurBlock		= Trim(Request("CurBlock"))
TableName		= Trim(Request("TableName"))
Sect			= Request("Sect")

SQL ="SELECT * FROM "& TableName &" WHERE Idx = " & IntIdx
'Response.Write SQL

Set objRs = RunSQLReturnRS(SQL)
If objRs.EOF or objRs.BOF Then 
	Call descment("잘못된 요청입니다.","back","")
Else
	Dim strSubject, strWriter, strEmail
	strSubject	= objRs("Subject")			: strWriter		= objRs("Writer")
	strEmail	= objRs("Email")			: 
	strWriteday	= objRs("Writeday")			: strContent	= objRs("Content")
	IntHit		= objRs("Hit")				: IntHtml		= objRs("Html")
	Intref		= objRs("ref")				: strfile1		= objRs("file1")
	strfile2	= objRs("file2")			: IntNotk		= objRs("Notk")
	strAddopt	= objRs("addOption")		: strPwd		= objRs("pwd")
	strIp		= objRs("ip")				: strId			= objRs("Id")
	strfile3	= objRs("file3")			: part	= objRs("part")

End IF
objRs.Close

Select Case reInt(IntHtml, 1)
	Case 1 : strContent = reString(strContent, "text")
	Case 3 : strContent = reString(strContent, "html")
	Case 4 : strContent = reString(strContent, "mix2")
	Case Else : strContent = reString(strContent, "mix")
End Select


If inStr("," & Request.Cookies("cookie")(TableName) & ",", "," & IntIdx & ",") = 0 Then
	RunSQL("UPDATE "& TableName &" SET Hit = hit + 1 WHERE Idx="& IntIdx &"")
	Response.cookies("cookie")(TableName) = Request.cookies("cookie")(TableName) & IntIdx & ","
End If


Dim TempFile, ViewStr1
'	If Not isNone(strfile1) Then strDownFile1 = "<a href=javascript:getfile("& IntIdx &",1);>"& getInfo(strfile1,0,chr(13) & chr(10)) &"["& getInfo(strfile1,1,chr(13) & chr(10)) <> -1, reUnit(getInfo(strfile1,1,chr(13) & chr(10))) & "/ ", "") &" Down "& getInfo(strfile1,2,chr(13) & chr(10)) &"]</a>"
'	If Not isNone(strfile2) Then strDownFile2 = "<a href=javascript:getfile("& IntIdx &",2);>"& getInfo(strfile2,0,chr(13) & chr(10)) &"["& isIFAB(getInfo(strfile2,1,chr(13) & chr(10)) <> -1, reUnit(getInfo(strfile2,1,chr(13) & chr(10))) & "/ ", "") &" Down "& getInfo(strfile2,2,chr(13) & chr(10)) &"]</a>"

If Not isNone(strfile1) Then strDownFile1 = "<a href=javascript:getfile("& IntIdx &",1);>"& getInfo(strfile1,0,chr(13) & chr(10)) &"</a>"
If Not isNone(strfile2) Then strDownFile2 = "<a href=javascript:getfile("& IntIdx &",2);>"& getInfo(strfile2,0,chr(13) & chr(10)) &"</a>"
If Not isNone(strfile3) Then strDownFile3 = "<a href=javascript:getfile("& IntIdx &",3);>"& getInfo(strfile3,0,chr(13) & chr(10)) &"</a>"

'코멘트 서치
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT num, cname, cComment, WriteDay, Ip  FROM "& TableName &"_comment WHERE bnum = " & IntIdx & " ORDER BY num DESC"
	Set objRs = RunSQLReturnRS(SQL)
		If objRs.EOF or objRs.BOF Then
			arrComCnt = -1
		Else	
			arrCom = objRs.GetRows()
			arrComCnt = Ubound(arrCom,2)+1
		End If
	objRs.Close
End If
 

'	검색
'	If Not isNone(strKeyField) And Not isNone(strKeyWord) Then
'		WHERE = " WHERE ("
'		If inStr(strKeyField, "subject") > 0 Then
'			WHERE = WHERE & " Subject LIKE '%" & reString(strKeyWord, "sql") & "%'"
'		End If
'			
'		If inStr(strKeyField, "content") > 0 Then
'			If inStr(strKeyField, "subject") > 0 Then WHERE = WHERE & " or"
'			WHERE = WHERE & " Content LIKE '%" & reString(strKeyWord, "sql") & "%'"
'		End If
'			
'		If inStr(strKeyField, "writer") > 0 Then
'			If inStr(strKeyField, "subject") > 0 or inStr(strKeyField, "content") > 0 Then WHERE = WHERE & " or"
'			WHERE = WHERE & " writer LIKE '%" & reString(strKeyWord, "sql") & "%'"
'		End If
'			
'			WHERE = WHERE & " ) And "
'	End If

'If isNone(WHERE) Then PWHERE = "WHERE " Else PWHERE = "And " End If
PWHERE = " WHERE Idx = (SELECT Top 1 Idx FROM "& TableName &" WHERE ref < "& reInt(Intref,-1) &" And re_step=0 And Sect='"& Sect &"' ORDER BY Idx DESC) "
NWHERE = " WHERE Idx = (SELECT Top 1 Idx FROM "& TableName &" WHERE ref > "& reInt(Intref,-1) &" And re_step=0 And Sect='"& Sect &"' ORDER BY Idx ASC) "

'이전글 서치
SQL = "SELECT Idx,Subject FROM "& TableName & WHERE & PWHERE
'Response.Write sql
Set objRs = RunSQLReturnRS(SQL)
If Not objRs.BOF or Not objRs.EOF Then  pData = objRs.GetRows() : PreIdx = pData(0,0) : PreTitle = pData(1,0)
objRs.Close

'다음글 서치
SQL = "SELECT Idx,Subject FROM "& TableName & WHERE & NWHERE 
Set objRs = RunSQLReturnRS(SQL)
If Not objRs.BOF or Not objRs.EOF Then nData = objRs.GetRows() : NextIdx = nData(0,0) : NextTitle = nData(1,0)
objRs.Close

'관련글 서치
SQL = "SELECT Idx, Subject, Writer, Email, File1, File2 ,WriteDay, Hit, re_level, "&_
" Addoption, ip FROM "& TableName &" WHERE Notk = 0 And ref=" & reInt(Intref,-1) & " And Sect='"& Sect &"' ORDER BY ref DESC, re_step"
Set objRs = RunSQLReturnRS(SQL)
	If objRs.EOF or objRs.BOF Then
		arrRsCnt = 1		
	Else	
		arrRs = objRs.GetRows()
		arrRsCnt = Ubound(arrRs,2) +1
	End If

Set objAdo = Nothing
%>