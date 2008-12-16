
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/FileManage.asp		-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	Flag	= GetQuery("flag")
	If Flag = "INSERT" Then
		
		Files	= SaveFileRtnNames(GetQuery("file"), "file", "Banner_"& Year(Now)&Month(Now)&Day(Now)&Minute(Now)&Second(Now) &"."& GetFileName(GetQuery("file"),"ext"), "none", CONF_MEMUL_UPMAXSIZE, CONF_BANNER_PATH,"",0)
		If isNone(Files) Then Call descment("배너파일을 첨부해 주세요","modify.asp","")
		
		SQL = "INSERT INTO Banner_TB (Files, Urls) VALUES('"& Files &"','"& reString(GetQuery("url"),"sql") &"')"
		Set objAdo = New ADOHelp
		objAdo.RunSQL(SQL)
		Call CloseDB()
		Call descment("","Modify.asp","")
		
	ElseIf Flag = "MODIFY" Then

		Idx		= GetQuery("HIIdx")
		arrIdx	= split(Idx,",")
		OldFiles= GetQuery("OldFiles")


		arrIdx	= Ubound(arrIdx)
		For i=0 To arrIdx
		
			Filess	= SaveFileRtnNames(GetQuery("file"&i), "file"&i, "Banner_"&i&"_"&Year(Now)&Month(Now)&Day(Now)&Minute(Now)&Second(Now) &"."& GetFileName(GetQuery("file"&i),"ext"), "none", CONF_MEMUL_UPMAXSIZE, CONF_BANNER_PATH, GetQuery("OldFiles"&i),1)
			SQL = "UPDATE Banner_TB Set Urls='"& Trim(getInfo(GetQuery("url"),i,",")) &"'"			
			If Not isNone(GetQuery("file"&i) ) Then SQL = SQL &", Files='"& Filess &"'"
			SQL = SQL &" WHERE Idx='"& getInfo(Idx,i,",") &"'"
			Set objAdo = New ADOHelp
			objAdo.RunSQL(SQL)
			Call CloseDB()
			
		Next		
		Call descment("수정되었습니다.","Modify.asp" ,"")
		
	ELseIf Flag = "DELETE" Then

		Idx		= Request("Idx")
		SQL = "SELECT Files FROM Banner_TB WHERE Idx='"& Idx &"'"
		Set objAdo = New ADOHelp
		Set objRs = objAdo.RunSQLReturnRs(SQL)
		If Not objRs.EOF or Not objRs.BOF Then
			Call DeleteFile(CONF_BANNER_PATH&objRs(0))	
		End If
		objAdo.RunSQL("DELETE FROM Banner_TB WHERE Idx='"& Idx &"'")
		Call CloseDB()
		Call descment("삭제되었습니다.","Modify.asp" ,"")
	End If
%>