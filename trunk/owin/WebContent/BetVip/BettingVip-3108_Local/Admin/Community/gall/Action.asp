<%	@Language = "VBScript" %>
<%
'	Option Explicit
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.expires = -1
	Response.buffer = true
	
	Server.ScriptTimeOut = 3000
%>	

<!--	#include virtual=/common/asp/Connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include file=config.asp						-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/FileManage.asp		-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<script language='javascript' src=/common/js/goList.js></script>
	
<%


	IntIdx			= GetQuery("Idx")
	TableName		= GetQuery("TableName")
	strFlag			= GetQuery("flag")
	strPwd			= GetQuery("pwd")
	strKeyField		= GetQuery("KeyField")
	strKeyWord		= GetQuery("KeyWord")
	strSortColumn	= GetQuery("SortColumn")
	strSort			= GetQuery("Sort")
	CurPage			= GetQuery("CurPage")
	Sect			= GetQuery("Sect")
	
'	Response.Write TableName
'	Response.End
	If isNone(strFlag) Then Call descment("잘못된 요청입니다.","back","")
	Select Case strFlag

'	============================================================================
'	=
'	=	Edit(Write/Reply/Modify/delete): 글 등록 및 삭제
'	=
'	============================================================================
		
	Case "WRITE", "REPLY", "MODIFY", "DELETE" :
%>
<!-- #include file = "ActionProcess.asp" -->
<%

	End Select
%>
<script language="javascript">
	function MovePage(goP) {
		getQuery["goPage"]		= '<%=CurPage%>';
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=strKeyField%>';
		getQuery["KeyWord"]		= '<%=strKeyWord%>';
		getQuery["SortColumn"]	= '<%=strSortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Idx"]			= '<%=IntIdx%>';
		getQuery["flag"]		= '<%=strFlag%>';
		getQuery["Sect"]	= '<%=Sect%>';
		action('',goP);
	}
	
</script>
<%If strFlag = "WRITE" or strFlag = "REPLY" or strFlag = "DELETE" Then%>
<body onload="MovePage('list.asp');">
<%ElseIf Sect= 6 And strFlag = "MODIFY" Then%>
<body onload="MovePage('list.asp');">
<%ElseIf strFlag = "MODIFY" Then%>
<body onload="MovePage('content.asp');">
<%End If%>