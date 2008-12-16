<%
Server.ScriptTimeOut = 30000
%>
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<%
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
f_date	= Request("f_date")
t_date	= Request("t_date")

SQL = "select SUM(Rcash), "
SQL = SQL &" (select SUM(Rcash) FROM Cash_TB WHERE Status=1 And Type=1), "
SQL = SQL &" (select SUM(Rcash) FROM Cash_TB WHERE Status=1 And Type=2), "
SQL = SQL &" (select SUM(Rcash) FROM Cash_TB WHERE Status=1 And Type=3), "
SQL = SQL &" (select SUM(Rcash) FROM Cash_TB WHERE Status=1 And Type=5), "
SQL = SQL &" (select SUM(Rcash) FROM Cash_TB WHERE Status=1 And Type=8), "
SQL = SQL &" (select SUM(Point) FROM Member_TB ), "
SQL = SQL &" (select Sum(ResultPoint) from Point_TB ) "
SQL = SQL &" from Cash_TB WHERE Status=1 And Type=0 "

	Set Rss = RunSQLReturnRs(SQL)
	If Not Rss.EOF Then 
		Cash1 = Rss(0)
		Cash2 = Rss(1)
		Cash3 = Rss(2)
		Cash4 = Rss(3)
		Cash5 = Rss(4)
		Cash6 = Rss(5)
		Cash7 = Rss(6)
		Cash8 = Rss(7)
	End If
	Set Rss = Nothing

	
%>
<script language='javascript' src=/common/js/Calendar.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Idx"]			= '<%=IntIdx%>';
		getQuery["ThisPage"]	= window.location.pathname;
		getQuery["cIdx"]		= gId;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["SortColumn"]	= SortColumn;
		getQuery["Sort"]		= Sort;
		action('',window.location.pathname);
	}	
	
	function ListPageGo(PageIndex) {
		getQuery["CurPage"]		= PageIndex;
		getQuery["CurBlock"]	= '<%=CurBlock%>';	
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
		getQuery["KD1"]			= '<%=KD1%>';
		getQuery["KD2"]			= '<%=KD2%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		action();
	}
	
	function seArch() {

		location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value;

	}	
</script>
<body style="margin:0">
<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[전체통계 베팅내역]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		
		
		<tr>
			<td align="center"><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
						<% If LCase(Session("SYS_ID"))="master" or Session("SYS_ID")="IN" Then %>
							<table  border="0" cellspacing="1" cellpadding="0" >
								<tr >
									<td>전체 충전금액 </td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash1,[])%></td>
									<td rowspan=2 align=right>&nbsp;충전금액-환전금액&nbsp;<font color=red><b><%=formatnumber(reInt(Cash1,0)-reInt(Cash2,0),[])%></td>
								</tr>
								<tr>
									<td>전체 환전금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash2,[])%></td>
								</tr>
								<tr><td height=10></td></tr>
								<% If Session("SYS_ID")="IN" Then %>
								<tr >
									<td>전체 현제머니(MEMBER) </td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash7,[])%></td>
								</tr>
								<% End If %>
								<tr >
									<td>전체 배팅사용금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash4,[])%></td>
									<td rowspan=2 align=right>&nbsp;배팅금액-적중금액&nbsp;<font color=red><b><%=formatnumber(reInt(Cash4,0)-reInt(Cash3,0),[])%></td>
								</tr>
								
								<tr>
									<td>전체 배팅적중 금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash3,[])%></td>
									
								</tr>
								<tr><td height=10></td></tr>
								<% If Session("SYS_ID")="IN" Then %>
								<tr>
									<td>전체 포인트 캐쉬전환 금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash5,[])%></td>
									<td rowspan=2 align=right>&nbsp;캐쉬전환금액+캐쉬교정금액&nbsp;<font color=red><b><%=formatnumber(reInt(Cash5,0)+reInt(Cash6,0),[])%></td>
								</tr>
								
								<tr>
									<td>전체 관리자 캐쉬교정 금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash6,[])%></td>
								</tr>
								<tr>
									<td>전체 환전전 포인트금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash8,[])%></td>
								</tr>
								<% End If %>
							</table>
							<% End If %>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		
	</table>
</body>
</html>
	