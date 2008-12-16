
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->

<%
IntIdx		= Request("Idx")
pageSize = 20
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")

f_date		= Request("f_date")
t_date		= Request("t_date")

'If Not isDate(f_date) Then f_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
'If Not isDate(t_date) Then t_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)

If Flag="DELETE" Then
'	SQL = "DELETE FROM BetGame_TB WHERE gCnt='"& Request("Idx") &"'"
	SQL = "UPDATE BetGame_TB Set VisbledBN=1 WHERE gCnt=='"& Request("Idx") &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	Call descment("삭제 되었습니다.","bList.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")
End If


order = " Order By gCnt DESC "
SQL = "SELECT gCnt, Id, bmoney, rMoney, hMoney, WriteDay FROM SumBetGame_TB "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" like '%"& KeyWord &"%'"
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
'Response.Write sql &"<br>"
SQL = SQL & order
Set objCon = getConnection
Set objRs = getRecordSet(objCon, SQL)
If objRs.EOF or objRs.BOF Then
	rsCount = -1
Else
    objRs.PageSize = pageSize
    objRs.AbsolutePage = CurPage
    rsCount = objRs.RecordCount
    gSeq = getReverseRow(pageSize, CurPage, rsCount)    
End If

g_pageCount = getPageSize(pageSize, rsCount)
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//정렬방식 순서 변경
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
		getQuery["ThisPage"]	= window.location.pathname;
		getQuery["Idx"]			= gId;
		getQuery["cIdx"]		= gSe;
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
	
	function UpdateGoldhit() {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["flag"]		= 'HITUPDATE';
		action('frmsgod','bMem_Prc.asp');
	}
	
	function seArch() {
		location.href = window.location.pathname+'?Sect=<%=Sect%>&f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&KeyField='+document.all.KeyField.value+'&KeyWord='+document.all.KeyWord.value;
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
						<td><font color="#ffffff" size="4"><b>[베팅내역]</b></font></td>
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
										<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 
										<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
										~
										<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 
										<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
										&nbsp;&nbsp;&nbsp;
										<select name=KeyField>
											<option value="Id">아이디</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord value="<%=KeyWord%>">
									</td>
									<td rowspan=2>
										<input type=button value="검 색" onclick="seArch();" id=button1 name=button1>
									</td>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=10></td></tr>
		<tr>
			<td>
	
							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
								<form  name=frms>
								<tr height="30" align="center" bgcolor="#e0e0e0">
									<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" id=checkbox1 name=checkbox1></td>
									<td width="100"><nobr>번호</td>
									<td width="150"><nobr>아이디</td>
									<td width="100"><nobr>이름</td>
									<td width="110"><nobr>금액</td>
									<td width="100"><nobr>예상배당률</td>
									<td width="100"><nobr>예상적중금액</td>
									<td width="100"><nobr>실제적중금액</td>
									<td width="70"><nobr>상태</td>
									<td width="170"><nobr>등록일</td>
									<td width="70"><nobr>관리</td>
								</tr>
<%
								If rsCount = -1 Then
										Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
								Else
								    count = 0
								    Do Until objRs.EOF Or count >= pageSize																
'										SQL = "SELECT TOP 1 ResuFlag FROM BetGame_TB  WHERE gCnt='"& objRs("gCnt") &"' Order By WriteDay ASC"
'										Response.Write sql &"<br>"
'										Set Rss = RunSQLReturnRs(SQL)
'										If Not Rss.EOF Then ResuFlag = Rss("ResuFlag") : Set Rss = Nothing
					
										SQL = "SELECT Name FROM Member_TB WHERE Id='"& objRs("Id") &"' "
'										Response.Write sql &"<br>"
										Set Rss = RunSQLReturnRs(SQL)
										If Not Rss.EOF Then Name = Rss("Name") : Set Rss = Nothing
%>	
								<tr height="25" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
									<td ><input type=checkbox name=selcheck value="<%=objRs("gCnt")%>"></td>
									<td ><nobr><%=gSeq%></td>
									<td ><nobr><%=objRs("Id")%></td>
									<td ><nobr><%=Name%></td>
									<td align="right"><nobr><%=formatnumber(objRs("bMoney"),[])%>&nbsp;</td>
									<td align="right"><nobr><%=getToAlot(objRs("gCnt"))%>&nbsp;</td>
									<td align="right"><nobr><%=formatnumber(objRs("hMoney"),[])%>&nbsp;</td>
									<td align="right"><nobr><%=formatnumber(objRs("rMoney"),[])%>&nbsp;</td>
									<td ><nobr><% If ResuFlag=0 Then %>대기<%Else%>완료<%End If%></td>
									<td ><nobr><%=objRs("WriteDay")%></td>
									<td ><nobr><input type=button value="삭제" onclick="if(confirm('삭제 하시겠습니까?')){MovePage('<%=objRs("gCnt")%>', 'bList.asp', 'DELETE', '', '');}" id=button2 name=button2></td>
								</tr>
<%

				gSeq = gSeq - 1
				count = count + 1
		       objRs.MoveNext
		   Loop
		End IF

%>								
								</form>
							</table>
						</td>
					</tr>


			</td>
		</tr>
		
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<TR>
						<TD align=middle >
							<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
				</TABLE>			
			</td>
		</tr>
		<tr>
			<td align=right>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<form name=frmsgod >
					<input type=hidden name=statusVals>
					<input type=hidden name=CurPage value="<%=CurPage%>">
					<input type=hidden name=CurBlock value="<%=CurBlock%>">
					<input type=hidden name=SortColumn value="<%=SortColumn%>">
					<input type=hidden name=strSort value="<%=strSort%>">
					<input type=hidden name=Sect value="<%=Sect%>">
					<input type=hidden name=ScFlag value="<%=ScFlag%>">
					<input type=hidden name=KeyField value="<%=KeyField%>">
					<input type=hidden name=KeyWord value="<%=KeyWord%>">
					</form>
					<TR >
						<TD >
							<input type=button value="선택삭제" onclick="if(confirm('삭제 하시겠습니까?')){MovePage('','All_Prc.asp','2','',frms);}" id=button1 name=button1>		
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
						</TD>
					</TR>
					</form>
				</TABLE>				
			</td>
		</tr>
	</table>
</body>
</html>
		