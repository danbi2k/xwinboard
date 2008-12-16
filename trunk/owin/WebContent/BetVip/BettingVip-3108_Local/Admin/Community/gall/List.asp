
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/config.asp				-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include file=config.asp							-->
<%

pageSize = 12
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
TableName	= Request("TableName")
Sect	= Request("Sect")

SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit FROM "& TableName &" WHERE Notk = 1 And Sect='"& Sect &"'"
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

SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit, re_level, Addoption, ip, part, Email, Content, file1  FROM "& TableName &" WHERE Notk=0 And Sect='"& Sect &"'"
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
		if(gSe=="") {
			getQuery["Sect"]		= '<%=Sect%>';
		} else {
			getQuery["Sect"]		= gSe;
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
		getQuery["Sect"]	= '<%=Sect%>';
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
		getQuery["Sect"]	= '<%=Sect%>';
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
						<td><font color="#ffffff" size="4"><b>[<%=bTitle%>]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align=center><br>
				<table width="90%" border="0" cellspacing="0" cellpadding="1" align=center>
					<form name=frms>
					<tr height="20" bgcolor="#FFFFFF" >
<%
					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else

		If Sect=3 Then		'디자인 시안

					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
%>
						<td>
<%					    
					    If count mod 3=0 Then Response.Write "</tr><tr bgcolor=#FFFFFF>"
%>
						<td >
							<a href="javascript:MovePage('<%=objRs("Idx")%>','content.asp','','','');"><img src="<%=CONF_DEFAULTVIEW_PATH&TableName&"/"&"["&objRs("Idx")&"_1]"&getInfo(objRs("file1"),0,chr(13)&chr(10))%>" width='112' height='112' border=1 style='border:1 solid #999999;' ></a><br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox name=selcheck value="<%=objRs("Idx")%>">
						</td>
<%
					       gSeq = gSeq - 1
					       count = count + 1
					       objRs.MoveNext
					   Loop


		ElseIf Sect=4 or Sect=6 Then '로고 샘플실, 납품사례


					    Do Until objRs.EOF Or count >= pageSize
%>
					
						<td>
							<table border=0 width=70%>
								<tr>
									<td rowspan=3 width=100>
										<a href="javascript:MovePage('<%=objRs("Idx")%>','content.asp','','','');"><img src="<%=CONF_DEFAULTVIEW_PATH&TableName&"/"&"["&objRs("Idx")&"_1]"&getInfo(objRs("file1"),0,chr(13)&chr(10))%>" width='112' height='112' border=1 style='border:1 solid #999999;' ></a><br>
									</td>
									<td><%=objRs("part")%></td>
								</tr>
								<tr><td><%=objRs("Subject")%></td></tr>
								<tr><td><%=DateViewLen(objRs("WriteDay"),"/",10)%></td></tr>
								<tr><td align=center><input type=checkbox name=selcheck value="<%=objRs("Idx")%>"></td></tr>
							</table>
						</td>
					</tr>
<%
					       gSeq = gSeq - 1
					       count = count + 1
					       objRs.MoveNext
					   Loop


	
		Else '로고 샘플실, 납품사례


					    Do Until objRs.EOF Or count >= pageSize
%>
						<td>
<%					    
					    If count mod 3=0 Then Response.Write "</tr><tr bgcolor=#FFFFFF>"
%>
						<td >
							<a href="javascript:MovePage('<%=objRs("Idx")%>','content.asp','','','');"><img src="<%=CONF_DEFAULTVIEW_PATH&TableName&"/"&"["&objRs("Idx")&"_1]"&getInfo(objRs("file1"),0,chr(13)&chr(10))%>" width='112' height='112' border=1 style='border:1 solid #999999;' ></a><br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox name=selcheck value="<%=objRs("Idx")%>">
						</td>
<%
					       gSeq = gSeq - 1
					       count = count + 1
					       objRs.MoveNext
					   Loop



		End IF 		 
					End IF
%>
					</form>
					</tr>
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
						<td align=right>
						<%If CONF_READONLY="0" Then%><input type=button value="등 록" onclick="location.href='write.asp?TableName=<%=TableName%>&flag=WRITE&Sect=<%=Sect%>';" id=button1 name=button1><%End If%>
						</td>
					</tr>
					<tr>
						<td >
							<input type=button value="선택삭제" onclick="MovePage('','Ckdel.asp','','',frms);" id=button2 name=button2>		
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
	