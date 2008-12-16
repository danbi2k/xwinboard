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
										<input type=button value="검 색" onclick="seArch();">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
							</table>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		<tr>
			<td align="center"><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table  border="0" cellspacing="1" cellpadding="0" >
								<tr height="30" >
									<td>전체 충전금액 </td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash1,[])%></td>
									<td rowspan=2 align=right>&nbsp;충전금액-환전금액&nbsp;<font color=red><b><%=formatnumber(reInt(Cash1,0)-reInt(Cash2,0),[])%></td>
								</tr>
								<tr>
									<td>전체 환전금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash2,[])%></td>
								</tr>
								<tr height="30" >
									<td>전체 현제머니(MEMBER) </td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash7,[])%></td>
								</tr>
								<tr>
									<td>전체 배팅사용금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash4,[])%></td>
									<td rowspan=2 align=right>&nbsp;배팅금액-적중금액&nbsp;<font color=red><b><%=formatnumber(reInt(Cash4,0)-reInt(Cash3,0),[])%></td>
								</tr>
								<tr>
									<td>전체 배팅적중 금액</td>
									<td align=right>&nbsp;<font color=red><b><%=formatnumber(Cash3,[])%></td>
									
								</tr>
								
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
						<td width="100"><nobr>전체 배팅대기</td>
						<td width="110"><nobr>실제 미적중액</td>
						<td width="130"><nobr>실제적중액</td>
						<td width="250"><nobr>수익(배팅합계-실제적중)</td>
					</tr>
<%

					SQL = " SELECT convert(varchar(10),WriteDay,120 ) As WriteDay FROM BetGame_TB "
					'SQL = "exec Admin_Sum_bDayList '"& f_date &"', '"& t_date &"'"
					'Response.Write SQL
					Set objRs = RunSQLReturnRs(SQL)

					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
					    ToSumMoney	= 0
					    allTocMoney = 0
					    ToNPoint	= 0
					    TobMondy	= 0
					    TorMondy	= 0
					    Do Until objRs.EOF 

						'이날 전체배팅 머니
					    SQLs = "select isNull(SUM(Rcash),0) FROM Cash_TB WHERE Status=1 And Type=3 And convert(varchar(10),writeday,120)='"& objRs("WriteDay") &"'"
					    Set Rss = RunSQLReturnRs(SQLs)
					    TobMondy = Rss(0) : Set Rss = Nothing

						'이날 전체적중 머니
					    SQLs = "select isNull(SUM(Rcash),0) FROM Cash_TB WHERE Status=1 And Type=2 And convert(varchar(10),writeday,120)='"& objRs("WriteDay") &"'"
					    Set Rss = RunSQLReturnRs(SQLs)
					    TorMondy = Rss(0) : Set Rss = Nothing

						'이날 전체 미적중 머니	
'					    SQLs = "exec Admin_Sum_bDayList_NgoldHit'"& arrRs(0,i) &"'"
					    SQLs = " SELECT SUM(bmoney) Tobmoney FROM (SELECT gCnt, bmoney FROM BetGame_TB WHERE convert(varchar(10),WriteDay,120 ) = convert(varchar(10),'"& objRs("WriteDay") &"',120 ) And GoldHit=2 group by gCnt, bmoney ) a "
					    Set Rss = RunSQLReturnRs(SQLs)
					    ToNrMondy = Rss(0) : Set Rss = Nothing
					    
						If DateDiff("d",Now(),objRs("WriteDay"))=0 Then	
							Set Rss = RunSQLReturnRs("SELECT SUM(Point) FROM Member_TB ")
							ToNPoint = Rss(0)
							Call closeResource(Rss)
						Else
							Set Rss = RunSQLReturnRs("SELECT Point FROM ToDayPoint_TB WHERE convert(varchar(10),ToDay,120 ) = convert(varchar(10),'"& objRs("WriteDay") &"',120 ) ")
							If Not Rss.EOF Then ToNPoint = Rss(0) : Call closeResource(Rss)
						End If
											
					    ToSumMoney		= reInt(TobMondy,0)-reInt(TorMondy,0)		'(배팅합계-실제적중)
						
						allTobMoney		= allTobMoney + reInt(TobMondy,0)			' 전체 베팅 합계
						allbSMoney		= reInt(allbSMoney,0)+reInt(ToNPoint,0)		' 전체 베팅 대기
						allTocMoney		= reInt(allTocMoney,0)+reInt(ToNrMondy,0)	' 전체 베팅 완료				
						allTorMoney		= allTorMoney + reInt(TorMondy,0)			' 전체 베팅 대기
						allToSumMoney	= allToSumMoney + ToSumMoney				' 전체 수익(배팅합계-실제적중)
%>
					<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td ><input type=checkbox name=selcheck value="<%=objRs("WriteDay")%>"></td>
						<td >&nbsp;&nbsp;<nobr><%=objRs("WriteDay")%></td>
						<td align=right><nobr><%=formatnumber(reInt(TobMondy,0),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(reInt(ToNPoint,0),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(reInt(ToNrMondy,0),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(reInt(TorMondy,0),[])%>&nbsp;</td>
						<td align=right><nobr><b><%If ToSumMoney > 0  Then %><font color=FF0000><%Else%><font color=0000CD><%End If%><%=formatnumber(reInt(ToSumMoney,0),[])%>&nbsp;<!--( <%=ToPercent%> )--></td>
					</tr>
<%
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
	