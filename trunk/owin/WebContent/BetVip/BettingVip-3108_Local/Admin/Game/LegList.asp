
<!--	#include virtual="/Admin/top.asp"					-->

<%

IntIdx		= Request("Idx")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
If Flag="DELETE" Then
	RunSQL("DELETE FROM Leag_TB WHERE Idx='"& IntIdx &"'")
	Call descment("삭제되었습니다.","LegList.asp","")

End If
SQL = "SELECT * FROM Leag_TB WHERE Idx<>'' "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
SQL = SQL & " Order By League "
Set objRs = RunSQLReturnRs(SQL)
'Response.Write SQL
%>
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gLeg, ghCou, gvCou, ggNa, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= gSe;
		getQuery["League"]		= gLeg;
		getQuery["hCont"]		= ghCou;
		getQuery["vCont"]		= gvCou;
		getQuery["gName"]		= ggNa;
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Idx"]			= gId;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}
	
</script>

	<table width="780" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[리그 관리]</b></font></td>
					</tr>
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
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="40"><nobr>번호</td>
						<td width="650"><nobr>리그</td>
						<td width="80"><nobr>관리</td>
					</tr>
					<form  name=frms>
					<input type=hidden name=idxs >
<%
					If objRs.EOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    count = 0
					    cnt = 1
					    Do Until objRs.EOF
%>
					<tr height="30" bgcolor="#FFFFFF">	
						<td align="center"><nobr><%=count%></td>
						<td ><nobr><a href="javascript:MovePage('','Write.asp','WRITE','<%=objRs("Sect")%>','<%=objRs("League")%>','<%=objRs("hcont")%>','<%=objRs("vcont")%>','<%=objRs("gName")%>','');"><img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle>&nbsp;<%=objRs("League")%></td>
						<td align="center"><nobr><input type=button onclick="MovePage('<%=objRs("Idx")%>','LegList.asp','DELETE','','','');" value="삭제"></td>
					</tr>
<%
					       cnt = cnt - 1
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
			<td align=center>
				<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
					<TR >
						<TD align=right ><input type=button value="리그등록" onclick="MovePage('','LegWrite.asp','WRITE','','');" id=button1 name=button1></TD>
					</TR>
				</TABLE>				
			</td>
		</tr>
	</table>
</body>
</html>
	