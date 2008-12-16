
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
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<script language='javascript' src=/common/js/goList.js></script>
<%


	Dim cIntIdx
	Dim IntIdx
	Dim TableName
	Dim strFlag
	Dim strPwd
	Dim strCname
	Dim strCComment
	
	cIntIdx		= Request("senum")
	IntIdx		= Request("Idx")
	TableName	= Request("TableName")
	strKeyField	= Request("KeyField")
	strKeyWord	= Request("KeyWord")
	CurPage		= Request("CurPage")
	SortColumn	= Request("SortColumn")
	Sort		= Request("Sort")
	strFlag		= Request("flag")
	Sect		= Request("Sect")
	
	strCname	= reString(Request.Form("cname"), "sql")
	strPwd		= reString(Request.Form("Pwd"), "sql")
	strComment	= reString(Request.Form("comment"), "sql")
	IntrCnt		= reString(Request.Form("rCnt"), "sql")
	pageSize	= Request("pageSize")
	ListFlag	= Request("ListFlag")

	
	If strFlag = "comdelete" Then
			
			RunSQL("UPDATE "& TableName & "_Comment Set Hidden=1 WHERE num = "& cIntIdx &" And bnum = "& IntIdx &"")
'			RunSQL("DELETE FROM "& TableName & "_Comment WHERE num = "& cIntIdx &" And bnum = "& IntIdx &"")

	ElseIf strFlag = "comwrite" Then
	
		reDim arrName(5), arrValue(5)
		
		arrName(0) = "bnum"
		arrName(1) = "cname"
		arrName(2) = "Pwd"
		arrName(3) = "cComment"
		arrName(4) = "ip"
		arrName(5) = "rCnt"
		
		arrValue(0) = IntIdx
		arrValue(1) = strCname
		arrValue(2) = strPwd
		arrValue(3) = strComment
		arrValue(4) = GetIp()
		arrValue(5) = reInt(IntrCnt,0)
		
		SQL = insertDB(TableName & "_Comment", arrName, arrValue)
		RunSQL(SQL)

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
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["pageSize"]	= '<%=pageSize%>';
		getQuery["ListFlag"]	= '<%=ListFlag%>';
		
		action('','content.asp');
	}
</script>
<body onload="movePage()">