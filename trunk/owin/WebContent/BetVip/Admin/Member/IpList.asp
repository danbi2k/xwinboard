<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<%

pageSize = 20
strId		= Request("Id")
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")


If Flag="DELETE" Then
	Call MemberDel(strId)
	Call descment("","MemberList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord,"")
	
ElseIf Flag="STOP" Then
	SQL = "UPDATE Member_TB Set Seceid='1' WHERE Id='"& strId &"'"
'	Response.Write SQL
'	Response.end
	RunSQL(SQL)
	Call descment("","MemberList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord,"")

End If


If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY LloginIp DESC "
End If

SQL = "SELECT Id, name, Point, VipFlag, Mail, Cell, WriteDay, FloginIp, LloginIp FROM Member_TB WHERE Id<>''"
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
		getQuery["ThisPage"]	= window.location.pathname;
		getQuery["Id"]			= gId;
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
		action();
	}

	
	function GoSearch() {
		lfm.action=window.location.pathname
		lfm.submit()
	}
		
</script>
<script language='javascript' src=/common/js/common.js></script>
	<table width="850" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[�����ǰ���]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="MemberList.asp">
					<input type=HIDDEN name=Sect value="<%=Sect%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Writeip" <%=gSelection(KeyField,"Writeip","selected")%>>ȸ������ ������</option>
								<option value="FloginIp" <%=gSelection(KeyField,"FloginIp","selected")%>>���ʷα��� ������</option>
								<option value="LloginIp" <%=gSelection(KeyField,"LloginIp","selected")%>>�������α��� ������</option>
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord value="<%=KeyWord%>">
								<input type=submit value="�� ��">
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" bgcolor="#e0e0e0">
					<form name=frms>
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)"></td>
						<td width="50"><nobr>��ȣ</td>
						<td width="130"><nobr>���̵�</td>
						<td width="130"><nobr>����</td>
						<td width="130"><nobr>�����ݾ�</td>
						<td width="150"><nobr>�ڵ���</td>
						<td width="100"><nobr><a href="javascript:ReSortList('LloginIp','<%=strSort%>');">������������</td>
						<td width="100"><nobr>������</td>
						<td width="100"><nobr>������</td>
					</tr>
<%
					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td><input type=checkbox name=selcheck value="<%=objRs("Id")%>"></td>
						<td><nobr><%=gSeq%></td>
						<td align="center"><nobr><a href="javascript:MovePage('<%=objRs("Id")%>','Modify.asp','','','');"><%=objRs("Id")%></a></td>
						<td><nobr><%=objRs("name")%></td>
						<td align=right><nobr><%=formatnumber(objRs("Point"),[])%></td>
						<td><nobr><%=objRs("cell")%></td>
						<td><nobr><%=objRs("LloginIp")%></td>
						<td><nobr><%=objRs("VipFlag")%></td>
						<td><nobr><%=objRs("WriteDay")%></td>
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
					<!--
					<TR>
						<TD width=750>
							<select name="vipFlag">
								<option value="okbet365.com">okbet365.com</option>
								<option value="okbet-vip.com">okbet-vip.com</option>
							</select>
							<input type=button value="����ȸ�� ������ ����" onclick="MovePage('','AllMember_Prc.asp','ALLCHANGEDOMAIN','',frms);" style="cursor:hand">
							&nbsp;&nbsp;<input type=button value="����ȸ�� ����" onclick="if(confirm('���� �Ͻðڽ��ϱ�?')){ MovePage('','AllDel.asp','MEMBERCHECKDEL','',frms); }" >
							
						</TD>				
					</TR>
					-->
					<TR>
						<TD align=middle width=750>
							<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
					</form>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
	