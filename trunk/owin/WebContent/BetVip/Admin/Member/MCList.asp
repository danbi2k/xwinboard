<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%

pageSize = 20
IntIdx		= Request("Idx")
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
senum		= Request("senum")
strId		= Request("Id")

If Flag="DELETE" Then
	RunSQL("DELETE FROM Cash_TB WHERE Idx='"& IntIdx &"'")
	Call descment("","MCList.asp?Id="& strId &"&CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord,"")
End If

If Flag="MODIFY" Then
	RunSQL("UPDATE Cash_TB Set Status='"& senum &"' WHERE Idx='"& IntIdx &"'")
	Call descment("","MCList.asp?Id="& strId &"&CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord,"")
End If

Select Case Sect
	Case 0 : titl = strId & " ȸ�� ĳ������ ��û"	: titl2 = "���� �ݾ�"
	Case 1 : titl = strId & " ȸ�� ĳ��ȯ�� ��û"	: titl2 = "ȯ�� �ݾ�"
End Select

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY WriteDay DESC "
End If

SQL = "SELECT * FROM Cash_TB WHERE Type='"& Sect &"' And Id='"& strId &"'"
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
SQL = SQL & order

'Response.Write sql
Set objCon = getConnection
Set objRs = getRecordSet(objCon, SQL)

If Not objRs.EOF or Not objRs.BOF Then
    objRs.PageSize = pageSize
    objRs.AbsolutePage = CurPage
    rsCount = objRs.RecordCount
    gSeq = getReverseRow(pageSize, CurPage, rsCount)
Else
    rsCount = 0
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
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Id"]			= '<%=strId%>';
		getQuery["senum"]		= gSe;
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
		getQuery["Sect"]		= '<%=Sect%>';		
		action();
	}

	
	function GoSearch() {
		lfm.action=window.location.pathname
		lfm.submit()
	}
		
</script>
<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[<%=titl%> ����]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<!--
		<tr>
			<td align="center">
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="MemberList.asp">
					<input type=HIDDEN name=Sect value="<%=Sect%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Id">���̵�</option>
								<option value="Name">�� ��</option>
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord>
								<input type=submit value="�� ��">
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		-->
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" bgcolor="#e0e0e0">
					<% If Sect=0 Then %>
						<td width="110">����</td>
						<!--<td width="80">�����ϱ�</td>-->
						<td width="150">���̵�</td>
						<td width="130">�Ա��� �̸�</td>
						<td width="180"><%=titl2%></td>
						<td width="180">��û��</td>
						<td width="40">����</td>
					<% Else %>
						<td width="100">����</td>
						<td width="130">���̵�</td>
						<td width="130">������</td>
						<td width="150">�ŷ�����</td>
						<td width="150">���¹�ȣ</td>
						<td width="180"><%=titl2%></td>
						<td width="200">��û��</td>
						<td width="40">����</td>
					<% End If %>
					</tr>
<%
					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
					<% If Sect=0 Then %>
						<td align="center">
						<% If objRs("Status")=0 Then %>
						<font color=C3B801><b>���� �����</font></b>
						<%Else %>
						<font color=08AA00><b>���� �Ϸ�</font></b>
						<% End If %>
						<!--
							<select name="Status">
								<option <%=gSelection(objRs("Status"),0,"selected")%> value=0 style="background-color:#FFEA00">���� �����</option>
								<option <%=gSelection(objRs("Status"),1,"selected")%> value=1 style="background-color:#00FF2A">���� �Ϸ�</option>
							</select>
							-->
						</td>
						<!--<td align="center"><input type=button value="�����ϱ�" onclick="MM_winopen('Cash.asp?Id=<%=objRs("Id")%>&Idx=<%=objRs("Idx")%>&Cash=<%=objRs("RCash")%>','CA','width=400,height=300');"></td>-->
						<td align="center"><%=objRs("Id")%></a></td>
						<td><%=objRs("Depos")%></td>
						<td><%=formatnumber(objRs("RCash"),[])%> ��</td>
						<td><%=objRs("WriteDay")%></td>
						<td ><input type=button value="����" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=objRs("Idx")%>','MCList.asp','DELETE','','');}" id=button1 name=button1></td>
					<% Else %>
						<td align="center"><nobr><% If objRs("Status")=0 Then %><font color=C3B801><b>ȯ�� �����<%Else%><font color=08AA00><b>ȯ�� �Ϸ�<%End If%>
						<!--
							<select name="Status" onchange="MovePage('<%=objRs("Idx")%>', 'MCList.asp', 'MODIFY', this.value, '')">
								<option <%=gSelection(objRs("Status"),0,"selected")%> value=0 style="background-color:#FFEA00">ȯ�� �����</option>
								<option <%=gSelection(objRs("Status"),1,"selected")%> value=1 style="background-color:#00FF2A">ȯ�� �Ϸ�</option>
							</select>
						-->
						</td>
						<td align="center"><%=objRs("Id")%></a></td>
						<td><%=objRs("Depos")%></td>
						<td><%=objRs("BankName")%></td>
						<td><%=formatnumber(objRs("RCash"),[])%> ��</td>
						<td><%=objRs("BankCode")%></td>
						<td><%=objRs("WriteDay")%></td>
						<td ><input type=button value="����" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=objRs("Idx")%>','MCList.asp','DELETE','','');}" id=button1 name=button1></td>
					<% End If %>
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
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<TR>
						<TD align=middle width=750>
<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
				</TABLE>			
			</td>
		</tr>
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<TR>
						<TD align=middle width=750>
<input type=button value="�� ��" onclick="self.close();">
						</TD>				
					</TR>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
	