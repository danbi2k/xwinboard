
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%IntIdx		= Request("Idx")pageSize = 20

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
	
	Call descment("","bMem.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
End If
order = " ORDER BY b.Idx DESC"
SQL = "SELECT b.Idx, b.Id, b.gName, convert(varchar(16),b.gsDate,120 ) As gsDat, b.hTname, b.hAllot, b.hCap, "
SQL = SQL &" b.HcapAllotl, b.vTname, b.vAllot, b.gbTem, convert(varchar(16),b.WriteDay,120 ) As WriteDay, b.bMoney, b.ResuFlag, b.rMoney, g.rtel "
SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE b.gIdx='"& IntIdx &"' And g.Idx=b.gIdx "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
SQL = SQL & order
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
		getQuery["ScFlag"]		= '<%=ScFlag%>';		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Idx"]			= '<%=IntIdx%>';		getQuery["cIdx"]		= gId;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';			getQuery["ScFlag"]		= '<%=ScFlag%>';
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
		getQuery["KeyWord"]		= '<%=KeyWord%>';			getQuery["KD1"]			= '<%=KD1%>';
		getQuery["KD2"]			= '<%=KD2%>';		getQuery["ScFlag"]		= '<%=ScFlag%>';
		action();
	}
</script><body style="margin:0">
<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[베팅회원 관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="List.asp?Sect=<%=Sect%>">
					<input type=hidden name="KD1" value="<%=KD1%>">					<input type=hidden name="KD2" value="<%=KD2%>">					<input type=hidden name="KD3" value="<%=KD3%>">
					<input type=hidden name="ScFlag" value="<%=ScFlag%>">
					
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>							<table  border="0" cellspacing="1" cellpadding="0" >								<tr height="30" >
									<td>
										<select name=KeyField>
											<option value="Id">아이디</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord>									</td>									<td rowspan=2>
										<input type=submit value="검 색" id=submit1 name=submit1>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;									</td>							</table>
						</td>
					</tr>					
					</form>
				</table>
			</td>
		</tr>		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="110">아이디</td>						<td width="180">베팅일시</td>
						<td width="90">종목</td>
						<!--<td width="180">경기날짜</td>-->						<td width="100">승(홈팀)</td>						<td width="80">핸드캡</td>
						<td width="70">배당율</td>
												<td width="130">패(원정팀)</td>
						<td width="80">핸드캡</td>
						<td width="70">배당율</td>
						<td width="70">배당팀</td>						<td width="90">경기결과</td>						<td width="100">배팅금액</td>						<td width="80">정산금액</td>						<td width="110">상태</td>						<td width="50">정산</td>
						<td width="60">실제정립</td>						<td width="60">삭제</td>
					</tr>					<form  name=frms>					<input type=hidden name=idxs >
<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
					    Do Until objRs.EOF Or count >= pageSize
%>
					<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>						<form  name=frms >
						<input type=hidden name="Idx" value="<%=IntIdx%>">
						<input type=hidden name="KeyWord" value="<%=KeyWord%>">
						<input type=hidden name="KeyField" value="<%=KeyField%>">
						<input type=hidden name="Flag" value="MODIFY">
						<input type=hidden name="cIdx" value="<%=objRs("Idx")%>">										
						<td ><%=objRs("Id")%></td>						<td ><%=objRs("WriteDay")%></td>
						<td align=left ><%=objRs("gName")%></td>						
						<!--<td ><%=objRs("gsDat")%></td>-->						<td align="right"><%=objRs("hTname")%></td>						<td align="left">-<%=objRs("hCap")%></td>						<td align="left"><%=objRs("hAllot")%></td>						<td align="left"><%=objRs("vTname")%></td>						<td align="left"><%=objRs("hCap")%></td>						<td align="left"><%=objRs("vAllot")%></td>						<td align="left"><%If objRs("gbTem")=1 Then %>홈팀<%Else%>원정팀<%End If%></td>						<td align="left"><%=objRs("rtel")%></td>						<td align="left"><%=formatnumber(objRs("bMoney"),[])%></td>						<td ><input type=text name="rMoney" value="<%=objRs("rMoney")%>" size=10></td>
						<td align="left">
							<input type=radio name=ResuFlag value=0 <%=gSelection(objRs("ResuFlag"),0,"checked")%>>정산전
							<input type=radio name=ResuFlag value=1 <%=gSelection(objRs("ResuFlag"),1,"checked")%>>완료						</td>						<td ><input type=submit value="적용" id=submit2 name=submit2></td>
						<td ><input type=button value="정립" onclick="MM_winopen('CashCh.asp?Id=<%=objRs("Id")%>&Idx=<%=objRs("Idx")%>&Cash=<%=objRs("bMoney")%>','CA','width=400,height=300');" id=button1 name=button1></td>
						<td ><input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=objRs("Idx")%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2></td>					</form>      
					</tr>					
<%
					       gSeq = gSeq - 1
					       count = count + 1
					       objRs.MoveNext
					   Loop
					End IF
%>					</form>
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
	