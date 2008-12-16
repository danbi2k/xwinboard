
<!--	#include virtual="/Admin/top.asp"				-->
<!--	#include virtual=/common/asp/config.asp				-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%
pageSize = 200
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
TableName	= Request("TableName")


SQL = "SELECT * FROM Sms_TB WHERE Content is Not NULL order By Idx DESC"
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
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["TableName"]	= '<%=TableName%>';
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
						<td><font color="#ffffff" size="4"><b>[SMS내역]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>



		<tr>
			<td align=center><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=frms>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" ></td>
						<td width="80">번 호</td>
						<td width="800">내 용</td>
						<td width="120">등록일</td>
					</tr>

<%


					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
						cCnt = 0

%>

					<tr height="20" align="center"  bgcolor="#FFFFFF"  onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""' >
						<td><input type=checkbox name=selcheck value="<%=objRs("Idx")%>"></td>
						<td ><%=gSeq%></td>
						<td align="left"><%=reString(objRs("Content"),"text")%></a>
					
						</td>
						<td ><nobr><%=objRs("WriteDay")%></td>
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
							&nbsp;&nbsp;<input type=button value="선택삭제" onclick="if(confirm('삭제 하시겠습니까?')){ MovePage('','CkDel.asp','','',frms); }"  id=button2 name=button2>
						</td>
						<td align=right>
							<input type=button value="등 록" onclick="MovePage('','Write.asp','WRITE','','');" id=button1 name=button1>		
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
		</form>
	</table>
</body>
</html>
	