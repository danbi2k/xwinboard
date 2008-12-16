
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%
ScFlag		= Request("ScFlag")
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
ltitle		= "핸디캡"
Select Case Sect
	Case "1" : Titles = "야구(핸디) "
	Case "2" : Titles = "축구(핸디) "
	Case "3" : Titles = "농구(핸디) "
	Case "4" : Titles = "핸디캡"
	Case "5" : Titles = "승무패" : ltitle = "무"
	Case Else Titles = "All "
End Select

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
'	order = " ORDER BY Idx DESC "
order = " ORDER BY convert(varchar(20),gsDate,120 ) ASC "

End If

SQL = "SELECT * FROM Game_TB WHERE Status<>'2' "
If Not isNone(Sect) Then
	If Sect=4 Then  
		SQL = SQL &" And  ( Sect ='1' or Sect ='2' or Sect ='3' or Sect ='4' ) "
	Else
		SQL = SQL &" And  Sect ='"& Sect &"'"
	End If
End If	
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
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Idx"]			= gId;
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

function UpdateStatus() {
		getQuery["flag"]		= 'STATUSCHANGE';
		action(frmsgod,'List_Prc.asp');
	}				
function Statusch(val) {
		
	var stVal = document.frmsgod.statusVals.value;
	if (stVal=="") {
		document.frmsgod.statusVals.value = val;
	} else {
		document.frmsgod.statusVals.value = stVal+'@'+val;
	}
//		alert(document.frmsgod.statusVals.value);
}

 function AllStatusch(val){
	para = document.frms.chstat;
	if(typeof(para)=="object") {
		if(para.length) {
			if (para.length > 1) {
				for (var x=0; x< para.length; x++){
					para[x].value=val;
					tmpval = 
				}
				
				var stVal = document.frmsgod.statusVals.value;
					if (stVal=="") {
						document.frmsgod.statusVals.value = para[x].value;
					} else {
						document.frmsgod.statusVals.value = stVal+'@'+para[x].value;
					}
					alert(document.frmsgod.statusVals.value);
			} else {
				para.value=val;
			}
		} else {
			para.value=val;	
		}
	} else {
		alert("변경 대상이 없습니다");
		return false;
	}
}</script>
<script language='javascript' src=/common/js/common.js></script>
	<table width="1000" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[<%=Titles%> 관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
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
					
					
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
								<tr height="30" >
									<td>
										<input type=button value="베팅" onclick="AllStatusch(1);">										<input type=button value="마감" onclick="AllStatusch(0);">										<input type=button value="마감경기" onclick="AllStatusch(2);">										<input type=button value="숨김" onclick="AllStatusch(3);">										&nbsp;&nbsp;&nbsp;
										<input type=button value="상태 일괄변경" onclick="UpdateStatus();" id=button1 name=button1>									</td>
							</table>
						</td>
					</tr>
					
					</form>
				</table>
			</td>
		</tr>
		<!--
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="List.asp?Sect=<%=Sect%>">
					<input type=hidden name="KD1" value="<%=KD1%>">
					<input type=hidden name="KD2" value="<%=KD2%>">
					<input type=hidden name="KD3" value="<%=KD3%>">
					<input type=hidden name="ScFlag" value="<%=ScFlag%>">
					
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
								<tr height="30" >
									<td>
										<select name=KeyField>
											<option value="Product">제품명</option>
											<option value="Codes+Idx">제품코드</option>
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
		</tr>
		-->
		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>					<form  name=frms>
					<input type=hidden name=idxs >
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="170"><nobr>경기일시</td>
						<td width="60"><nobr>리그</td>
						<td width="350"><nobr>승(홈팀)</td>
						<td width="110"><nobr>홈배팅횟수</td>
						<td width="110"><nobr>홈배팅금액</td>
						<td width="80"><nobr><%=ltitle%></td>
						<% If Sect=5 Then %>
						<td width="110"><nobr>무배팅횟수</td>
						<td width="110"><nobr>무배팅금액</td>
						<%End If%>
						<td width="350"><nobr>패(원정팀)</td>
						<td width="110"><nobr>패배팅횟수</td>
						<td width="110"><nobr>패배팅금액</td>
						<td width="80"><nobr>상태변경</td>
					</tr>

<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
					    Do Until objRs.EOF Or count >= pageSize
					    Set Rs = RunSQLReturnRs("SELECT COUNT(gbTem), SUM(bMoney) FROM BetGame_TB WHERE gIdx='"& objRs("Idx") &"' And gbTem=1 ")
					    If Not Rs.EOF Then hCnt = Rs(0) : hbSum = Rs(1) : Set Rs = Nothing
					    
					    Set Rs = RunSQLReturnRs("SELECT COUNT(gbTem), SUM(bMoney) FROM BetGame_TB WHERE gIdx='"& objRs("Idx") &"' And gbTem=2 ")
					    If Not Rs.EOF Then vCnt = Rs(0) : vbSum = Rs(1) : Set Rs = Nothing
					    
					    Set Rs = RunSQLReturnRs("SELECT COUNT(gbTem), SUM(bMoney) FROM BetGame_TB WHERE gIdx='"& objRs("Idx") &"' And gbTem=3 ")
					    If Not Rs.EOF Then mCnt = Rs(0) : mbSum = Rs(1) : Set Rs = Nothing
%>
					<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<!--<td align="center"><input type=button value="회원보기" onclick="MM_winopen('bMem.asp?Idx=<%=objRs("Idx")%>','BM','width=1000,height=700,scrollbars=1');" id=button2 name=button2></td>
						<td align="center"><input type=button value="회원보기" onclick="MM_winopen('bList.asp?Idx=<%=objRs("Idx")%>','BL','width=1000,height=700,scrollbars=1');" id=button2 name=button2></td>-->
						<td ><nobr><a href="javascript:MovePage('<%=objRs("Idx")%>','Write.asp','MODIFY','','');"><%=objRs("gsDate")%></font></td>
						<td ><nobr><%=objRs("League")%></td>
						<td align="right"><nobr><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(hCnt,[])%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(reInt(hbSum,0),[])%>&nbsp;</td>
						<td align="center"><nobr><%If Sect=5 Then %><%=objRs("HcapAllotl")%><%Else%><%=objRs("hCap")%><%End If%></td>
						<% If Sect=5 Then %>
						<td align="right"><nobr><font color=red><%=formatnumber(mCnt,[])%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(reInt(mbSum,0),[])%>&nbsp;</td>
						<%End If%>
						<td align="left"><nobr>&nbsp;<%=objRs("vTname")%>&nbsp;<%=objRs("vAllot")%></td>
						<td align="right"><nobr><font color=red><%=formatnumber(vCnt,[])%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(reInt(vbSum,0),[])%>&nbsp;</td>
						<td align="center">							<select name=chstat onchange="Statusch(this.value);">								<option value="<%=objRs("Idx")%>|1" style="background-color:#0000CD;color:#FFFFFF" <%=gSelection(objRs("Status"),1,"selected")%> >베팅</option>								<option value="<%=objRs("Idx")%>|0" style="background-color:#FFEA00" <%=gSelection(objRs("Status"),0,"selected")%>>마감</option>								<option value="<%=objRs("Idx")%>|2" style="background-color:#b4b4b4" <%=gSelection(objRs("Status"),2,"selected")%>>마감경기</option>								<option value="<%=objRs("Idx")%>|3" style="background-color:#282828;color:#FFFFFF" <%=gSelection(objRs("Status"),3,"selected")%>>숨김</option>							</select>
						</td>
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
		<tr>
			<td align=center>
				<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
					<TR >
						<TD align=right >							<%If isNone(ScFlag) Then%><%If Sect <> 4 Then%><input type=button value="게임등록" onclick="MovePage('','Write.asp','WRITE','','');" id=button1 name=button1><%ENd If%><%ENd If%>							&nbsp;&nbsp;&nbsp;						</TD>
					</TR>					
				</TABLE>				
			</td>
		</tr>
	</table>
</body>
</html>
	