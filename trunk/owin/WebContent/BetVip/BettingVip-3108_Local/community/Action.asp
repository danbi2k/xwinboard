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
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include file=config.asp						-->
<!--	#include virtual=/common/asp/FileManage.asp		-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->

<script language='javascript' src=/common/js/goList.js></script>
<%


	strId			= Session("UId")
	IntIdx			= GetQuery("Idx")
	TableName		= GetQuery("TableName")
	strFlag			= GetQuery("flag")
	strPwd			= GetQuery("pwdd")
	strKeyField		= GetQuery("KeyField")
	strKeyWord		= GetQuery("KeyWord")
	SortColumn		= GetQuery("SortColumn")
	strSort			= GetQuery("Sort")
	CurPage			= GetQuery("CurPage")
	Sect			= GetQuery("Sect")		
'	Response.Write strFlag &"FF <br>"
'	Response.Write TableName &"FF <br>"
'	Response.End
	strRefPage = "/community/board/list.asp?TableName="& TableName &"&Sect="&Sect
	If isNone(strId) Then Call descment("잘못된 요청입니다.","back","")
	If isNone(strFlag) Then Call descment("잘못된 요청입니다.","back","")
	If Sect=0 Then Call descment("잘못된 요청입니다.","back","")


SQL ="SELECT *  FROM "& TableName &" WHERE Idx = '"& IntIdx &"' "
'Response.Write SQL
Set objRs = RunSQLReturnRS(SQL)
If Not objRs.EOF or Not objRs.BOF Then
	If objRs("Re_Step") = 1 Then Call descment("","back","") 
End If

		
	Select Case strFlag


		
	Case "WRITE", "REPLY", "MODIFY", "DELETE" :
%>
<!-- #include file = "ActionProcess.asp" -->
<%
	Case "comwrite", "comdelete" :
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
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["flag"]		= '<%=strFlag%>';
		action('',goP);
	}
	
</script>
<%If strFlag = "WRITE" or strFlag = "REPLY" or strFlag = "DELETE" Then%>
<body onload="MovePage('list.asp');">
<%ElseIf strFlag = "MODIFY" Then%>
<body onload="MovePage('content.asp');">
<%End If%>