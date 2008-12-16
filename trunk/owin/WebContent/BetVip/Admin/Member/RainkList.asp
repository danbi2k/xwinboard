
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




order = " Group by Id Order By ToBmoney DESC "
SQL = "SELECT Id, sum(bmoney) As ToBmoney, sum(hmoney) As Tohmoney, sum(rmoney) As Tormoney, SUM(bmoney)-SUM(rmoney) As ToSumMoney FROM SumBetGame_TB "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" like '%"& KeyWord &"%'"
SQL = SQL & order
'Response.Write sql &"<br>"
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
	
	function addGoldhit(val) {
		
		var goldhits = document.frmsgod.goldhits.value;
		if (goldhits=="") {
			document.frmsgod.goldhits.value = val;
		} else {
			document.frmsgod.goldhits.value = goldhits+'@'+val;
		}
//		alert(document.frmsgod.goldhits.value);
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
					<form name=regfrm method=post action="RainkList.asp">

					<input type=hidden name="Sect" value="<%=Sect%>">

					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table  border="0" cellspacing="1" cellpadding="0" >
								<tr height="30" >
									<td>
										<select name=KeyField>
											<option value="Id">아이디</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord>
									</td>
									<td rowspan=2>
										<input type=submit value="검 색" id=submit1 name=submit1>
									</td>
							</table>
						</td>
					</tr>
					
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td>
	
							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
								<tr height="30" align="center" bgcolor="#e0e0e0">
									<td width="60"><nobr>번호</td>									<td width="150"><nobr>아이디</td>
									<td width="200"><nobr>배팅금액</td>
									<td width="250"><nobr>예상적중금액(모두당첨시)</td>
									<td width="150"><nobr>실제적중금액</td>									<td width="200"><nobr>수익(배팅액-실제적중)</td>								</tr>
<%
								If rsCount = -1 Then
										Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
								Else
								    count = 0
								    Do Until objRs.EOF Or count >= pageSize																
%>	
								<tr height="25" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
									<td ><nobr><%=gSeq%></td>
									<td ><nobr><%=objRs("Id")%></td>
									<td align="right"><nobr><%=formatnumber(objRs("ToBmoney"),[])%>&nbsp;</td>
									<td align="right"><nobr><%=formatnumber(objRs("Tohmoney"),[])%>&nbsp;</td>
									<td align="right"><nobr><%=formatnumber(objRs("Tormoney"),[])%>&nbsp;</td>
									<td align="left"><nobr>
										<input type=text class=input2 size=10 value="<%=formatnumber(objRs("ToBmoney"),[])%>" style=text-align:right>-
										<input type=text class=input2 size=10 value="<%=formatnumber(objRs("Tormoney"),[])%>" style=text-align:right>=
										<input type=text class=input2 size=10 value="<%=formatnumber(objRs("ToSumMoney"),[])%>" style=text-align:right>&nbsp;
									</td>

								</tr>
<%

				gSeq = gSeq - 1
				count = count + 1
		       objRs.MoveNext
		   Loop
		End IF

%>								
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
	</table>
</body>
</html>
		