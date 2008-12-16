
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
f_date		= Request("f_date")
t_date		= Request("t_date")
ltitle		= "핸디캡"
Select Case Sect
	Case "1" : Titles = "야구(핸디) "
	Case "2" : Titles = "축구(핸디) "
	Case "3" : Titles = "농구(핸디) "
	Case "4" : Titles = "핸디캡"
	Case "5" : Titles = "승무패" : ltitle = "무"
	Case "6" : Titles = "기타(핸디) "
	Case Else Titles = "All "
End Select

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
'	order = " ORDER BY Idx DESC "
order = " ORDER BY convert(varchar(20),gsDate,120 ) ASC, League ASC "

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
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
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
		getQuery["ThisPage"]	= 'List.asp';
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
		getQuery["ThisPage"]	= 'List.asp';
		getQuery["Sect"]		= '<%=Sect%>';
		action(frmsgod,'List_Prc.asp');
	}
	
			
function Statusch(val1, val2) {
		
	var stVal = document.frmsgod.statusVals.value;
	if (stVal=="") {
		document.frmsgod.statusVals.value = val1+val2;
	} else {
		document.frmsgod.statusVals.value = stVal+'@'+val1+val2;
	}
//		alert(document.frmsgod.statusVals.value);
}


	function seArch() {
//		alert(document.all.KeyWord.value);
//		location.href = window.location.pathname+'?Sect=<%=Sect%>&f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&KeyField='+document.all.KeyField.value+'&KeyWord='+document.all.KeyWord.value;
		location.href = window.location.pathname+'?Sect=<%=Sect%>&f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value;
	}
</script>
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
		</tr>
		
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
								<tr height="30" >
									<td>
										<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 
										<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
										~
										<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 
										<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
										&nbsp;&nbsp;&nbsp;
										<!--
										<select name=KeyField>
											<option value="hTname" <%=gSelection(KeyField,"hTname","selected")%>>홈팀</option>
											<option value="vTname" <%=gSelection(KeyField,"vTname","selected")%>>원정팀</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord value="<%=KeyWord%>">
										-->
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type=button value="검 색" onclick="seArch();" id=button1 name=button1>
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
					<input type=hidden name=idxs >
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" id=checkbox1 name=checkbox1></td>
						<td width="170"><nobr>경기일시</td>
						<td width="60"><nobr>리그</td>
						<td width="350"><nobr>승(홈팀)</td>
						<td width="80"><nobr><%=ltitle%></td>
						<td width="350"><nobr>패(원정팀)</td>
						<td width="80"><nobr>상태변경</td>
						<!--<% If Sect=5 Then %><td width="80"><nobr>처리</td><%End If%>-->
					</tr>

<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
					    Do Until objRs.EOF Or count >= pageSize

%>
					<tr height="25" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td ><input type=checkbox name=selcheck value="<%=objRs("Idx")%>"></td>
						<td ><nobr><a href="javascript:MovePage('<%=objRs("Idx")%>','Write.asp','MODIFY','','');"><%=objRs("gsDate")%></font></td>
						<td ><nobr><%=objRs("League")%></td>
						<td align="right"><nobr><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
						<td align="center"><nobr><%If Sect=5 Then %><%=objRs("HcapAllotl")%><%Else%><%=objRs("hCap")%><%End If%></td>
						<td align="left"><nobr>&nbsp;<%=objRs("vTname")%>&nbsp;<%=objRs("vAllot")%></td>
						<td align="center">
							<select name=chstat onchange="Statusch('<%=objRs("Idx")%>|',this.value);">
								<option value="1" style="background-color:#0000CD;color:#FFFFFF" <%=gSelection(objRs("Status"),1,"selected")%> >베팅</option>
								<option value="0" style="background-color:#FFEA00" <%=gSelection(objRs("Status"),0,"selected")%>>마감</option>
								<option value="2" style="background-color:#b4b4b4" <%=gSelection(objRs("Status"),2,"selected")%>>마감경기</option>
								<option value="3" style="background-color:#282828;color:#FFFFFF" <%=gSelection(objRs("Status"),3,"selected")%>>숨김</option>
								<option value="4" style="background-color:#800080;color:#FFFFFF" <%=gSelection(objRs("Status"),4,"selected")%>>취소</option>
							</select>
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
							<input type=button value="선택삭제" onclick="if(confirm('삭제 하시겠습니까?')){MovePage('','List_Prc.asp','SELECTDELETE','',frms);}" id=button1 name=button1>		
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
							<%If isNone(ScFlag) Then%><%If Sect <> 4 Then%><input type=button value="게임등록" <%If Sect=5 Then%> onclick="MovePage('','LegList.asp','','','');" <%Else%> onclick="MovePage('','Write.asp','WRITE','','');" <%End If%>><%ENd If%><%ENd If%>
							&nbsp;&nbsp;&nbsp;
							
							<input type=button value="상태 일괄변경" onclick="UpdateStatus();" id=button1 name=button1>
						</TD>
					</TR>
					</form>
				</TABLE>				
			</td>
		</tr>
	</table>
</body>
</html>
	