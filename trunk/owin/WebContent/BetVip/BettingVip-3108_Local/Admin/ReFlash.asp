<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%
'	SQL = "SELECT COUNT(Idx) FROM Cash_TB WHERE Type=0 And Status=0 And Stops=0"
'	Set Rss = RunSQLReturnRs(SQL)
	Set Rss = getRecordSet(getConnection(), "exec Admin_NewReq_cash '0'")
	If Rss(0) > 0 Then so ="<embed src='/chimes.wav' hidden='true' loop='true'>"  : so1Cnt = Rss(0) : Call closeResource(Rss)
	
'	SQL = "SELECT COUNT(Idx) FROM Cash_TB WHERE Type=1 And Status=0 And Stops=0"
'	Set Rss = RunSQLReturnRs(SQL)
	Set Rss = getRecordSet(getConnection(), "exec Admin_NewReq_cash '1'")
	If Rss(0) > 0 Then so2 ="<embed src='/chimes.wav' hidden='true' loop='true'>"  : so2Cnt = Rss(0)
	
	
'	SQL = "SELECT COUNT(Idx) FROM Community_TB WHERE Sect=3 And PRef=0 And Re_Step=0"
'	Set Rss = RunSQLReturnRs(SQL)
	Set Rss = getRecordSet(getConnection(), "exec Admin_Community_NewData")
	If Rss(0) <> 0 Then so3 ="<embed src='/community.wav' hidden='true' loop='true'>" : so3Cnt = Rss(0)
	
'	RunSQLBackUp("DELETE FROM BetCart_TB")
'	RunSQLBackUp("DELETE FROM BetGame_TB")
'	RunSQLBackUp("DELETE FROM Cash_TB")
'	RunSQLBackUp("DELETE FROM Community_TB")
'	RunSQLBackUp("DELETE FROM Community_TB_comment")
'	RunSQLBackUp("DELETE FROM Game_TB")
'	RunSQLBackUp("DELETE FROM Leag_TB")
'	RunSQLBackUp("DELETE FROM Member_TB")
'	RunSQLBackUp("DELETE FROM Sms_TB")
'	RunSQLBackUp("DELETE FROM VisitCnt_TB")

'	Set Rss = RunSQLReturnRs("SELECT hit_date,SessionID,REMOTE_HOST,http_referer,cmon,cDay,cHour,cWeek,csite,cSearch,cOS,cbrowser,cpage FROM VisitCnt_TB")
'	If Not (Rss.EOF or Rss.BOF) Then arrRss = Rss.GetRows() : arrRssCnt = Ubound(arrRss,2) : Set Rss = Nothing
'	If Not isNone(arrRssCnt) Then
'		
''		For i=0 To arrRssCnt
''			BakcUpSQL = "INSERT INTO VisitCnt_TB(hit_date,SessionID,REMOTE_HOST,http_referer,cmon,cDay,cHour,cWeek,csite,cSearch,cOS,cbrowser,cpage) VALUES('"& arrRss(0,i) &"','"& arrRss(1,i) &"','"& arrRss(2,i) &"','"& arrRss(3,i) &"','"& arrRss(4,i) &"','"& arrRss(5,i) &"','"& arrRss(6,i) &"','"& arrRss(7,i) &"','"& arrRss(8,i) &"','"& arrRss(9,i) &"','"& arrRss(10,i) &"','"& arrRss(11,i) &"','"& arrRss(12,i) &"')"
'			RunSQLBackUp(BakcUpSQL)
'		Next

'	End If
	Call closeResource(Rss)
	Call CloseGame()
%>
<html>
<head>
<link href="/common/CSS/Admin.css" type="text/css" rel="stylesheet">
<META HTTP-EQUIV="refresh" CONTENT="5" URL="">
<style>BODY {
	SCROLLBAR-FACE-COLOR: #f5f5f5; SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; SCROLLBAR-SHADOW-COLOR: #bbbbbb; SCROLLBAR-3DLIGHT-COLOR: #ffffff; SCROLLBAR-ARROW-COLOR: #666666; SCROLLBAR-TRACK-COLOR: #f5f5f5; SCROLLBAR-DARKSHADOW-COLOR: #f5f5f5
}
</style>
</head>
<body style="margin:0" >

<table cellSpacing="0" cellPadding="1" width="95%" align=center border="0" bgcolor=CECFCE>
	<tr>
		<td vAlign="top" bgcolor=#EFEFEF>
			<table cellSpacing="0" cellPadding="3" border="0" >
				<tr>
					<td >
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="Member/CashList.asp?Sect=0" target="mainFrame"><font color="#B9062F">[▒ 충전신청 : <%=formatnumber(so1Cnt,[])%> 건]</a> &nbsp;&nbsp;
					<a href="Member/CashList.asp?Sect=1" target="mainFrame"><font color="#9400D3">[▒ 환전신청 : <%=formatnumber(so2Cnt,[])%> 건]</a> &nbsp;
					<a href="Community/Board/List.asp?TableName=Community_TB&Sect=3" target="mainFrame"><font color="#000000">[▒ 고객센터 : <%=formatnumber(so3Cnt,[])%> 건]</a></font></a>&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	
<%=so%>
<%=so2%>
<%=so3%>
</body>
</html>










