
<!--	#include virtual="/Admin/top.asp"				-->
<!--	#include virtual=/common/asp/config.asp				-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include file=config.asp							-->
<%
pageSize = reInt(Request("pageSize"),200)
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
TableName	= Request("TableName")

SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit, Hidden FROM "& TableName &" WHERE Notk = 1 And Sect='"& Sect &"'"
If Session("SYS_ID") <> "IN" Then SQL = SQL &" And Hidden = 0 "

Set objRs = RunSQLReturnRS(SQL)
	If objRs.EOF or objRs.BOF Then
		arrnRsCnt = -1
	Else	
		nData = objRs.GetRows()
		arrnRsCnt = Ubound(nData,2)
	End If
objRs.Close
	
Select Case strSortColumn
	Case "Idx"		: order = " ORDER BY Idx "& strSort
	Case "writer"	: order = " ORDER BY writer "& strSort
	Case "writeday"	: order = " ORDER BY writeday "& strSort
	case "hit"		: order = " ORDER BY hit "& strSort
	case "subject"	: order = " ORDER BY ref "& strSort &" , re_step ,Idx "& strSort &""
	case else		: order = " ORDER BY ref DESC , re_step ,Idx DESC"
End Select

SQL = "SELECT Idx, Subject, Writer, WriteDay, Id, Hit, re_level, Addoption, ip, content, Hidden FROM "& TableName &" WHERE Notk=0 And Sect='"& Sect &"' "
If Session("SYS_ID") <> "IN" Then SQL = SQL & " And Hidden=0 "
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

If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//���Ĺ�� ���� ����
%>

<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gPs, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["TableName"]	= '<%=TableName%>';
		if (gPs=='') {
		getQuery["pageSize"]	= '<%=TableName%>';
		} else {
		getQuery["pageSize"]	= gPs;
		}
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
		getQuery["TableName"]	= '<%=TableName%>';
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
		getQuery["TableName"]	= '<%=TableName%>';
		action();
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
						<td><font color="#ffffff" size="4"><b>[<%=bTitle%>]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>

		<tr>
			<td align="center">
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="List.asp">
					<input type=HIDDEN name=TableName value="<%=TableName%>">
					<input type=HIDDEN name=Sect value="<%=Sect%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Id">���̵�</option>
								<option value="Writer">�ۼ���</option>
								<option value="Subject">�� ��</option>
								<option value="content">�� ��</option>
							</select>
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord>
								<input type=submit value="�� ��">
								&nbsp;&nbsp;&nbsp;
							<select name=pageSize onchange="MovePage('','InList.asp','','',this.value,'');">
								<option <%=gSelection(pageSize,10,"selected")%> value="10">10 ����</option>
								<option <%=gSelection(pageSize,20,"selected")%> value="20">20 ����</option>
								<option <%=gSelection(pageSize,50,"selected")%> value="50">50 ����</option>
								<option <%=gSelection(pageSize,80,"selected")%> value="80">80 ����</option>
								<option <%=gSelection(pageSize,100,"selected")%> value="100">100 ����</option>
								<option <%=gSelection(pageSize,150,"selected")%> value="150">150 ����</option>
								<option <%=gSelection(pageSize,200,"selected")%> value="200">200 ����</option>
							</select>����
								&nbsp;&nbsp;&nbsp;
								<input type=radio value=1 onclick="ContentViewFlag(1)")��ħ����
								<input type=radio value=0 onclick="ContentViewFlag(0)")�Ϲݺ���
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>

		<tr>
			<td align=center><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=frms>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" ></td>
						<td width="80">�� ȣ</td>
						<td width="800"><%If SortColumn="Subject" And strSort = "DESC" Then %><a href="javascript:ReSortList('Subject','ASC');"><font color=#EEEEEE>��<%ElseIf SortColumn="Codes" And strSort = "ASC" Then%><a href="javascript:ReSortList('Subject','DESC');"><font color=#EEEEEE>��<%Else%><a href="javascript:ReSortList('Subject','DESC');"><%End If%>�� ��</td>
						<!--<td width="150">���̵�</td>-->
						
						<td width="150">�ۼ���</td>
						<!--<td width="120">������</td>-->
						<td width="120">�����</td>
						<td width="70">��ȸ��</td>
					</tr>
<%
					'====================================
					'== �������� ������츦 ���� ó��
					'====================================
					If arrnRsCnt <> -1 Then
						For i = 0 To arrnRsCnt	'�迭ũ�� ��ŭ ������.																				
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & nData(0,i) & " And Hidden=0 "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td></td>
						<td >[����]</td>
						<td align="left" >&nbsp;&nbsp;<a href="javascript:MovePage('<%=nData(0,i)%>','Content.asp','','','','');"><%=nData(1,i)%></a></td>
						<td><%=nData(2,i)%></td>
						<td><%=DateViewLen(nData(3,i),"/",10)%></td>
						<td><%=nData(4,i)%></td>
					</tr>
<%
						Next
					End If
					'====================================
					' ���� ó�� ��
					'====================================

					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
						cCnt = 0
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & objRs("Idx") & " And Hidden=0 "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
%>

					<tr height="20" align="center"  <% If LCase(Session("SYS_ID"))="in" And objRs("Hidden") Then%> bgcolor="#FFCAD5"  <%Else%> bgcolor="#FFFFFF" <%End If%> onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""' >
						<td><input type=checkbox name=selcheck value="<%=objRs("Idx")%>"></td>
						<td ><%=gSeq%></td>
						<td align="left">
							<%If reInt(objRs("re_level"),0) > 0  Then %><img src='/images/bbs/Space.gif' WIDTH="<%=objRs("re_level")*10%>" height=0 BORDER=0><img src='/images/bbs/icon_reply.gif' BORDER=0><%End If%>
							&nbsp;&nbsp;<a href="javascript:MovePage('<%=objRs("Idx")%>','Content.asp','','','','');">
							<%If inRStr(objRs("addoption"),1,",",1,1) Then%><!--<img src=/images/bbs/icon_private.gif align=absmiddle>--><%End If%>
							<%=reString(TextLeft(objRs("subject"),60),"text")%></a>
							<%If objRs("ip") = "delete" Then %><font color=#999999><b>[������]<b></font><%End If%>
							<%If cCnt > 0 Then %> <font color=red>[<%=cCnt%>]</font><%End If%>&nbsp;&nbsp;
							<% If DateDiff("h",objRs("WriteDay"),now()) < 24 Then %> <img src=/images/bbs/icon_new.gif align=absmiddle> <% End If %>
						
						</td>
						<!--<td><%=objRs("Id")%></td>-->
						<td align="left"><nobr><%=objRs("writer")%></td>
						<!--<td align="left"><nobr><%=objRs("Ip")%></td>-->
						<td ><nobr><%=objRs("WriteDay")%></td>
						<td ><%=objRs("Hit")%></td>
					</tr>
					<tr <%If reInt(objRs("re_level"),0) > 0  Then %> bgcolor=FFDCFF <%Else%> bgcolor=EFEFEF <%End If%> style="padding-top:5pt;padding-bottom:5pt;">
						<td colspan=10 style="padding-left:20pt"><%=reString(objRs("content"),"text")%></td>
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
			<td height=40 align=center>
				<TABLE cellSpacing=0 cellPadding=0 width=790 border=0>
					<TR>
						<TD align=middle width=750>
							<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
					<tr>
						<td >
							&nbsp;&nbsp;<input type=button value="���û���" onclick="if(confirm('���� �Ͻðڽ��ϱ�?')){ MovePage('','CkDel.asp','','','',frms); }"  id=button2 name=button2>
						</td>
						<td align=right>
							<input type=button value="�� ��" onclick="MovePage('','Write.asp','WRITE','','','');" id=button1 name=button1>		
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
		</form>
	</table>
</body>
</html>
	