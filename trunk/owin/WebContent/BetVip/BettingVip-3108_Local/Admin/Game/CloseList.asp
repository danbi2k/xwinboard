
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
ltitle		= "�ڵ�ĸ"

Select Case Sect
	Case "1" : Titles = "�߱� "
	Case "2" : Titles = "�౸"
	Case "3" : Titles = "��"
	Case "4" : Titles = "Etc"
	Case "5" : Titles = "�¹���" : ltitle = "��"
	Case Else Titles = "All "
End Select

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY gsDate DESC "
End If

SQL = "SELECT * FROM Game_TB WHERE Status='2'  "
'If Not isNone(Sect) Then SQL = SQL &" And  Sect ='"& Sect &"'"
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
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//���Ĺ�� ���� ����
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
						<td><font color="#ffffff" size="4"><b>[������� ����]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="List.asp?Sect=<%=Sect%>">

					<input type=hidden name="KD1" value="<%=KD1%>">
					<input type=hidden name="KD2" value="<%=KD2%>">
					<input type=hidden name="KD3" value="<%=KD3%>">

					<input type=hidden name="ScFlag" value="<%=ScFlag%>">

					<!--

					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
								<tr height="30" >
									<td>
										<select name=KeyField>
											<option value="Product">��ǰ��</option>
											<option value="Codes+Idx">��ǰ�ڵ�</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord>
									</td>
									<td rowspan=2>
										<input type=submit value="�� ��" id=submit1 name=submit1>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
							</table>
						</td>
					</tr>
					-->
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form  name=frms>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" id=checkbox1 name=checkbox1></td>
						<td width="190"><nobr>����Ͻ�</td>
						<td width="90"><nobr>����</td>
						<td width="300"><nobr>��(Ȩ��)</td>
						<td width="120"><nobr>Ȩ����Ƚ��</td>
						<td width="120"><nobr>Ȩ���ñݾ�</td>
						<td width="110"><nobr>��/�ڵ�ĸ</td>
						
						<td width="120"><nobr>������Ƚ��</td>
						<td width="120"><nobr>�����ñݾ�</td>
						
						<td width="300"><nobr>��(������)</td>
						<td width="120"><nobr>�й���Ƚ��</td>
						<td width="120"><nobr>�й��ñݾ�</td>
						
					</tr>
					
<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
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
					<tr height="25" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td ><input type=checkbox name=selcheck value="<%=objRs("Idx")%>"></td>
						<td ><nobr>&nbsp;<a href="javascript:MovePage('<%=objRs("Idx")%>','Write.asp','MODIFY','','');"><%=objRs("gsDate")%></font></td>
						<td align="center"><nobr><%=objRs("League")%></td>
						<td align="right"><nobr><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(hCnt,[])%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(reInt(hbSum,0),[])%>&nbsp;</td>
						<td align="center"><nobr><%If objRs("Sect")=5 Then %><%=objRs("HcapAllotl")%><%Else%><%=objRs("hCap")%><%End If%></td>
						
						<td align="right"><nobr><font color=red><%=formatnumber(mCnt,[])%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(reInt(mbSum,0),[])%>&nbsp;</td>
						
						<td align="left"><nobr>&nbsp;<%=objRs("vTname")%>&nbsp;<%=objRs("vAllot")%></td>
						<td align="right"><nobr><font color=red><%=formatnumber(vCnt,[])%>&nbsp;</td>
						<td align="right"><nobr><font color=red><%=formatnumber(reInt(vbSum,0),[])%>&nbsp;</td>
						
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
					<tr>
						<td >
							<input type=button value="���û���" onclick="if(confirm('���� �Ͻðڽ��ϱ�?')){MovePage('','Close_Prc.asp','CHECKDEL','',frms);}" id=button1 name=button1>		
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
		
	</table>
</body>
</html>
	