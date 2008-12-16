
<%	@Language = "VBScript" %>
<%
'	Option Explicit
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.expires = -1
	Response.buffer = true
	
	Server.ScriptTimeOut = 3000
%>	
<!--	#include virtual=/common/asp/Connect.asp			-->
<!--	#include virtual=/common/asp/bbsTransaction.asp		-->
<!--	#include virtual=/common/asp/UtilityClass.asp		-->
<script language='javascript' src=/common/js/goList.js></script>

<%
'	============================================================================
'	============================================================================
'	==
'	==	메모 쓰기/삭제 처리
'	==
'	============================================================================
'	============================================================================

	Dim cIntIdx
	Dim IntIdx
	Dim TableName
	Dim strFlag
	Dim strPwd
	Dim strCname
	Dim strCComment
	
	strId			= Session("UId")
	cIntIdx			= Request("senum")
	IntIdx			= Request("Idx")
	TableName		= Request("TableName")
	strKeyField		= Request("KeyField")
	strKeyWord		= Request("KeyWord")
	CurPage			= Request("CurPage")
	SortColumn		= Request("SortColumn")
	strSort			= Request("Sort")
	strFlag			= Request("flag")
	
	strCname		= reString(Request.Form("cname"), "sql")
	strPwd			= reString(Request.Form("Pwd"), "sql")
	strComment		= reString(Request.Form("comment"), "sql")
'	If isNone(strId) Then Call descment("","/login/login.asp?refPage=/bbsSale/list.asp?TableName="& TableName &"&Idx="& IntIdx,"")
'	Response.Write 111
'	Response.End
'	============================================================================
'	=
'	=	Memo 권한확인 부분
'	=
'	============================================================================
	If strFlag = "comdelete" Then
	
		If Not checkRight(strId, "comment") Then  Call descment("권한이 없습니다.", "back","")	
	
	End If
	
	If strFlag = "private" Then
	
		If Not checkRight(strId, "board") Then  Call descment("권한이 없습니다.", "back","")	
	
	End If	
	

'	============================================================================
'	=
'	=	Memo 삭제 부분
'	=
'	============================================================================

	If strFlag = "comdelete" Then
		Set objAdo = New ADOHelp
		objAdo.RunSQL("DELETE FROM "& TableName & "_Comment WHERE num = "& cIntIdx &" And bnum = "& IntIdx &"")
		Call CloseDB()
		
'	============================================================================
'	=
'	=	Memo 등록 부분
'	=
'	============================================================================

	ElseIf strFlag = "comwrite" Then
	
		reDim arrName(6), arrValue(6)
		
		arrName(1) = "bnum"
		arrName(2) = "cname"
		arrName(3) = "Pwd"
		arrName(4) = "cComment"
		arrName(5) = "ip"
		arrName(6) = "Id"
		

		arrValue(1) = IntIdx
		arrValue(2) = strCname
		arrValue(3) = strPwd
		arrValue(4) = strComment
		arrValue(5) = GetIp()
		arrValue(6) = strId
		
		SQL = insertDB(TableName & "_Comment", arrName, arrValue)
		Set objAdo = New ADOHelp		
		objAdo.RunSQL(SQL)
		Call CloseDB()

'	============================================================================
'	============================================================================
'	==
'	==	비밀글 보기 권한 쿠키 처리
'	==
'	============================================================================
'	============================================================================

	ElseIf strFlag = "private" Then

		If isNone(Request.Cookies("private")(TableName)) Then
		
			Response.Cookies("private")(TableName) = Request.Cookies("private")(TableName) & IntIdx & "/" & strPwd
		Else

			response.cookies("private")(TableName) = Request.Cookies("private")(TableName) & "," & IntIdx & "/" & strPwd
		End If
		
	Else
			Call descment("잘못된 정보를 요청하셨습니다.", "back","")	
	End If
%>
<script language="javascript">
function movePage() {
		getQuery["goPage"]		= '<%=CurPage%>';
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=strKeyField%>';
		getQuery["Sort"]		= '<%=Sort%>';
		getQuery["Idx"]			= '<%=IntIdx%>';
		getQuery["KeyWord"]		= '<%=strKeyWord%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sect"]	= '<%=request("Sect")%>';
		action('','Content.asp');
	}
</script>
<body onload="movePage()">