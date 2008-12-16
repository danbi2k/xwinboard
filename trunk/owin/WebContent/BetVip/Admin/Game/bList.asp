
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->

<%
IntIdx		= Request("Idx")
pageSize = 50

goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")

If Flag="MODIFY" Then
	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(Request("rMoney"),0) &", ResuFlag="& Request("ResuFlag") &" WHERE Idx='"& Request("cIdx") &"'"
	RunSQL(SQL)
	Call descment("","bList.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
End If

If Flag="DELETE" Then
	SQL = "DELETE FROM BetGame_TB WHERE Idx='"& Request("cIdx") &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	Call descment("","bList.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
End If

SQL = "SELECT Sect, League, gIdx, gsDate, hTname, vTname, Sum(bmoney) As TobMondy FROM BetGame_TB group by gIdx, Sect,League, gsDate, hTname, vTname Order By gsDate DESC"
'Response.Write SQL
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
		getQuery["Idx"]			= '<%=IntIdx%>';
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
						<td><font color="#ffffff" size="4"><b>[베팅금액]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>		<!--
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="bList.asp">

					<input type=hidden name="Idx" value="<%=IntIdx%>">
				

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
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
							</table>
						</td>
					</tr>
					
					</form>
				</table>
			</td>
		</tr>		-->
		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="60"><nobr>번호</td>						<td width="70"><nobr>종류</td>
						<td width="100"><nobr>리그</td>
						<td width="110"><nobr>게임일시</td>
						<td width="130"><nobr>홈팀</td>
						<td width="130"><nobr>원정팀</td>
						<td width="150"><nobr>배팅금액(승/무/패)</td>
					</tr>
					<form  name=frms>
					<input type=hidden name=idxs >
<%
					If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
					    Do Until objRs.EOF Or count >= pageSize
					    Set Rss = RunSQLReturnRs("SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=1 and gIdx='"& objRs("gIdx") &"'")
					    If Not Rss.EOF Then TobMondy1 = Rss(0) : Set Rss = Nothing
					    
					    Set Rss = RunSQLReturnRs("SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=2 and gIdx='"& objRs("gIdx") &"'")
					    If Not Rss.EOF Then TobMondy2 = Rss(0) : Set Rss = Nothing
					    
					    Set Rss = RunSQLReturnRs("SELECT Sum(bmoney) FROM BetGame_TB WHERE gbTem=3 and gIdx='"& objRs("gIdx") &"'")
					    If Not Rss.EOF Then TobMondy3 = Rss(0) : Set Rss = Nothing%>
					<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<input type=hidden name="Idx" value="<%=IntIdx%>">
						<input type=hidden name="KeyWord" value="<%=KeyWord%>">
						<input type=hidden name="KeyField" value="<%=KeyField%>">
						<input type=hidden name="Flag" value="MODIFY">
						<input type=hidden name="cIdx" >
									
						<td ><nobr><%=gSeq%></td>						<td ><nobr><%If objRs("Sect")=5 Then%>승무패<%Else%>핸디캡<%End If%></td>
						<td align=left><nobr>&nbsp;<%=objRs("League")%></td>
						<td ><nobr><%=objRs("gsDate")%></td>
						<td align=left><nobr>&nbsp;<%=objRs("hTname")%></td>
						<td align=left><nobr>&nbsp;<%=objRs("vTname")%></td>
						<td align=left><nobr>							<input size=10 value="<%=formatnumber(reInt(TobMondy1,0),[])%>" style="text-align:right">							<input size=10 value="<%=formatnumber(reInt(TobMondy2,0),[])%>" style="text-align:right">							<input size=10 value="<%=formatnumber(reInt(TobMondy3,0),[])%>" style="text-align:right">						</td>
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
	