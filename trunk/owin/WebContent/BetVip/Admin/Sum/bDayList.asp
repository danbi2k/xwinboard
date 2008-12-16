
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
SQL = "SELECT SUM(bMoney) As bMoney, SUM(rMoney) As rMoney, SUM(bMoney)-SUM(rMoney) As SumbMoney, CONVERT(varchar(10),WriteDay,120) As WriteDay FROM SumBetGame_TB WHERE VisbledDBN=0 Group By CONVERT(varchar(10),WriteDay,120) Order By CONVERT(varchar(10),WriteDay,120) DESC "
'SQL = "SELECT SUM(bMoney) As bMoney, SUM(rMoney) As rMoney, SUM(bMoney)-SUM(rMoney) As SumbMoney, CONVERT(varchar(10),WriteDay,120) As WriteDay FROM BetGame_TB Group By CONVERT(varchar(10),WriteDay,120) Order By CONVERT(varchar(10),WriteDay,120) DESC "
'SQL = "exec Admin_Sum_bDayList"'Response.Write SQL'Set objRs = getRecordSet(getConnection(), SQL)
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
					    ToSumMoney	= 0
					    allTocMoney = 0
					    ToNPoint	= 0
					    Do Until objRs.EOF 
'					    SQLs = "SELECT SUM(bmoney) Tobmoney, SUM(rmoney) rmoney  FROM (SELECT gCnt, bmoney, rmoney FROM BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'"& objRs("WriteDay") &"',120 ) group by gCnt, bmoney, rmoney ) a"
'					    Response.Write SQLs&"<BR>"
'					    Set Rss = RunSQLReturnRs(SQLs)
'					    If Not Rss.EOF Then TobMondy = Rss("Tobmoney") : TorMondy = Rss("rmoney") : Set Rss = Nothing
					    
'					    SQLs = "SELECT SUM(bmoney) Tobmoney FROM (SELECT gCnt, bmoney FROM BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'"& objRs("WriteDay") &"',120 ) And GoldHit=2 group by gCnt, bmoney ) a"
'					    Response.Write SQLs
'					    Set Rss = RunSQLReturnRs(SQLs)
'					    If Not Rss.EOF Then ToNrMondy = Rss(0) : Set Rss = Nothing
					    
'					    SQLs = "SELECT SUM(ResultCash) FROM Cash_TB WHERE Status=1 And Idx IN (SELECT max(idx) FROM Cash_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'"& objRs("WriteDay") &"',120 ) And Status=1 Group By Id)"
'					    Response.Write SQLs&":P<BR>"
'					    Set Rss = RunSQLReturnRs(SQLs)
'					    If Not Rss.EOF Then ToNPoint = Rss(0) : Set Rss = Nothing
					    
'						SQLs = "exec Admin_Sum_bDayList_ToNPoint'"& reInt(TobMondy,0) &"','"& objRs("WriteDay") &"'"
'						SQLs = "SELECT SUM(RCash)-"& reInt(TobMondy,0) &" FROM Cash_TB WHERE convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& FWriteDay &"',120 ) And convert(varchar(10),'"& objRs("WriteDay") &"',120 ) And Status=1 And Visbled=0 And ( Type=0 or Type=2 or Type=5 or Type=8 ) "
'						SQLs = "SELECT SUM(RCash)-"& reInt(TobMondy,0) &", (SELECT SUM(RCash) FROM Cash_TB WHERE convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& objRs("WriteDay") &"',120 ) And convert(varchar(10),'"& objRs("WriteDay") &"',120 ) And Status=1 And Visbled=0 And ( Type=0 or Type=2 or Type=5 or Type=8 ) ) As Topp FROM Cash_TB WHERE Status=1 And Visbled=0 And ( Type=0 or Type=2 or Type=5 or Type=8 ) "
'					    Response.Write SQLs&":P<BR><BR>"
'					    Set Rss = RunSQLReturnRs(SQLs)
'					    If Not Rss.EOF Then ToNPoint = Rss(0) : ToNNPoint = Rss(1) : Set Rss = Nothing
						
						If DateDiff("d",Now(),objRs("WriteDay"))=0 Then								SQLs = "SELECT SUM(Point) FROM Member_TB"						Else							SQLs = "SELECT SUM(Point) FROM ToDayPoint_TB WHERE Convert(varchar(10),WriteDay,120)=Convert(varchar(10),'"& objRs("WriteDay") &"',120)"						End If						Set Rss = RunSQLReturnRs(SQLs)
						If Not Rss.EOF Then ToNPoint = Rss(0) : ToNNPoint = Rss(0) : Set Rss = Nothing
'					    TocMoney = TobMondy-TorMondy'						ToSumMoney	= reInt(objRs("bMoney"),0)-reInt(objRs("rMoney"),0)
						ToSumMoney	= reInt(objRs("SumbMoney"),0)
						allTocMoney	= reInt(allTocMoney,0)+reInt(objRs("SumbMoney"),0)'						allTocMoney	= reInt(allTocMoney,0)+reInt(ToNrMondy,0)
						allbSMoney	= reInt(allbSMoney,0)+reInt(ToNPoint,0)'						ToPercent = ((원래값-변환값)/원래값) * 100 
'						ToPercent = ((TobMondy-ToNrMondy)/TobMondy) * 100 
'						ToPercent = (ToNrMondy/TorMondy)*100
'						ToPercent = ToPercent & " %"  ' 퍼센트
'						ToPercent = round(ToPercent,1)
				    					    
%>
					<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td ><input type=checkbox name=selcheck value="<%=objRs("WriteDay")%>"></td>
						<td ><nobr><%=objRs("WriteDay")%></td>
						<td align=right><nobr><%=formatnumber(reInt(objRs("bMoney"),0),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(reInt(ToNNPoint,0),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(reInt(objRs("SumbMoney"),0),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(reInt(objRs("rMoney"),0),[])%>&nbsp;</td>
						<td align=right><nobr><b><%If ToSumMoney > 0  Then %><font color=FF0000><%Else%><font color=0000CD><%End If%><%=formatnumber(reInt(objRs("SumbMoney"),0),[])%>&nbsp;<!--( <%=ToPercent%> )--></td>
					</tr>
<%
							allTobMoney		= allTobMoney + reInt(objRs("bMoney"),0)
							allTorMoney		= allTorMoney + reInt(objRs("rMoney"),0)
							allToSumMoney	= allToSumMoney + reInt(objRs("SumbMoney"),0)

					       gSeq = gSeq - 1
					       count = count + 1
					       objRs.MoveNext
					   Loop
					End IF

%>
					<tr height=27 bgcolor="#FFFFFF" >
						<td align=center></td>
						<td align=center><b>합계</td>
						<td align=right><b><%=formatnumber(reInt(allTobMoney,0),[])%>&nbsp;</td>
						<td align=right><b><%=formatnumber(reInt(allbSMoney,0),[])%>&nbsp;</td>
						<td align=right><b><%=formatnumber(reInt(allTocMoney,0),[])%>&nbsp;</td>
						<td align=right><b><%=formatnumber(reInt(allTorMoney,0),[])%>&nbsp;</td>
						<td align=right><b><%If reInt(allToSumMoney,0) > 0  Then %><font color=FF0000><%Else%><font color=0000CD><%End If%><%=formatnumber(reInt(allToSumMoney,0),[])%>&nbsp;</td>
					</form >
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
	