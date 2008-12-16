<%
'	Option Explicit
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.expires = -1
	Response.buffer = true
	
	Server.ScriptTimeOut = 900000
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

	

'If Not isDate(f_date) Then f_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)

'If Not isDate(t_date) Then t_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)

SQL = "SELECT DISTINCT gCnt FROM BetGame_TB "
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &"  And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
'SQL = SQL & " Group By convert(varchar(10),WriteDay,120 ) Order By WriteDay DESC "
'Response.Write SQL
Set objRs = RunSQLReturnRs(SQL)

If objRs.EOF or objRs.BOF Then rsCount = -1
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
						<td><font color="#ffffff" size="4"><b>[일자별 베팅내역]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table  border="0" cellspacing="1" cellpadding="0" >
								<tr height="30" >
									<td>
										<input type="text" name="f_date" size="10" value="<%=IfElse(f_date,Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2))%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 

										<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>

										~

										<input type="text" name="t_date" size="10" value="<%=IfElse(t_date,Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2))%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 

										<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
									</td>
									<td rowspan=2>
										<input type=button value="검 색" onclick="seArch();" id=button2 name=button2>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
							</table>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		
		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form  name=frms>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" id=checkbox1 name=checkbox1></td>
						<td width="150"><nobr>날 짜</td>
						<td width="150"><nobr>배팅합계</td>
						<td width="100"><nobr>배팅대기</td>
						<td width="110"><nobr>배팅완료</td>
						<td width="130"><nobr>실제적중액</td>
						<td width="250"><nobr>수익(배팅완료-실제적중)</td>
					</tr>
<%
					If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
						    Do Until objRs.EOF 
						    SQLs = "SELECT bMoney, rMoney, WriteDay FROM BetGame_TB WHERE gCnt='"& objRs("gCnt") &"'"
	'					    Response.Write SQLs&"<BR>"
						    Set Rss = RunSQLReturnRs(SQLs)
						    If Not Rss.EOF Then 
								bMoney = Rss("bmoney") : rMoney = Rss("rmoney") : WriteDay = Rss("WriteDay") 						    End if						    Set Rss = Nothing
				    			    
							SQL = "INSERT INTO SumBetGame_TB (gCnt,bMoney,rMoney,WriteDay) "							SQL = SQL &" VALUES('"& objRs("gCnt") &"','"& bMoney &"','"& rMoney &"',CONVERT(varchar(20),'"& WriteDay &"',120))"							RunSQL(SQL)
							gSeq = gSeq - 1
							count = count + 1
							objRs.MoveNext
					   Loop
					End IF

%>

				</table>
			</td>
		</tr>
		<tr><td height=50></td></tr>
		<tr>

			<td align=right>

				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>

					<TR >

						<TD >

							<input type=button value="선택삭제" onclick="if(confirm('삭제 하시겠습니까?')){MovePage('','All_Prc.asp','3','',frms);}" id=button1 name=button1>		

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							

						</TD>

					</TR>

				</TABLE>				

			</td>

		</tr>
	</table>
</body>
</html>
	