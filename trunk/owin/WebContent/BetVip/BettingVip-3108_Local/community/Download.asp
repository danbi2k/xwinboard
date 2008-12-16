<%	@Language = "VBScript" %>
<%
'	Option Explicit
	Response.expires = 0
	Response.buffer = true
%>

<!-- #include virtual = "/common/asp/connect.asp"		-->
<!-- #include virtual = "/common/asp/config.asp"		-->
<!-- #include file = "config.asp"						-->
<!-- #include virtual = "/common/asp/FileManage.asp"	-->
<!-- #include virtual = "/common/asp/UtilityClass.asp"	-->


<%
	Dim IntIdx, fcnt, filePath
	Dim objStream, download
	Dim sysObj
	Dim sql, rs, file
	Dim dCount
	
	TableName	= Request("TableName")
	IntIdx		= Request("Idx")
	fcnt		= Request("fcnt")
	dCount		= reInt(Request("dcnt"), 0)
	
	If isNone(TableName) or Not isInt(IntIdx) or Not isInt(fcnt) Then Call descment("존재하지 않는 파일입니다.", "back","")

	Dim fData, rFiles
	SQL = "SELECT File" & fcnt & " FROM " & TableName & " WHERE Idx = " & IntIdx
	Set objRs = RunSQLReturnRS(SQL)
	
	If objRs.BOF or objRs.EOF Then
		Call descment("존재하지 않는 파일입니다.", "back","")
	Else
		rFiles = objRs(0)
	End If
	Call CloseDB()
	
	If isNone(rFiles) Then Call descment("존재하지 않는 파일입니다.", "back","")	
	filePath = CONF_FILE_DIRPATH & TableName & "\[" & IntIdx & "_" & fcnt & "]" & getInfo(rFiles,0,chr(13)&chr(10)) 
	Dim FSO
	Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	
	If Not FSO.FileExists(filePath) Then
		Call descment("존재하지 않는 파일입니다.", "back","")
	Else
		
		IF dCount = 1 Then
'			SQL = "UPDATE " & TableName & " SET file" & fcnt & " = '" & getInfo(rFiles,0,chr(13)&chr(10)) & getInfo(rFiles,1,chr(13)&chr(10)) & (reInt(getInfo(rFiles,2,chr(13)&chr(10))  , 0) + 1)
'			SQL = SQL & "' WHERE Idx = " & IntIdx
'			Set objAdo = New ADOHelp
'			RunSQL(SQL)
'			Call CloseDB()
		End if
	
		Call closeDB()
		
		Response.ContentType = GetFileType(getInfo(rFiles,0,chr(13)&chr(10)) )
		Response.AddHeader "Content-Disposition","attachment; filename=" & getInfo(rFiles,0,chr(13)&chr(10)) 
		
		Set objStream = Server.CreateObject("ADODB.Stream")
		objStream.Open
		
		objStream.type = 1
		objStream.loadFromFile filePath
		
		download = objStream.Read
		Response.binaryWrite download
		
		Set objstream = nothing
	
	end if
	Set FSO = Nothing
%>