
<!--	#include virtual="/Admin/top.asp"				-->
<!--	#include virtual=/common/asp/config.asp				-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include file=config.asp							-->
<%
pageSize = 20
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
TableName	= Request("TableName")

SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit FROM "& TableName &" WHERE Notk = 1 And Sect='"& Sect &"' And Hidden=0 "
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

SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit, content, re_level, Addoption, ip FROM "& TableName &" WHERE Notk=0 And Sect='"& Sect &"' And Hidden=0 "
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
						<td><font color="#ffffff" size="4"><b>[<%=bTitle%>]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<!--
		<tr>
			<td align="center">
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="List.asp">
					<input type=HIDDEN name=TableName value="<%=TableName%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Subject">제 목</option>
								<option value="content">내 용</option>
							</select>
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord>
								<input type=submit value="검 색">
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		-->
		<tr>
			<td align=center><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="80">번 호</td>
						<td width="800">내 용</td>
						<!--<td width="150">작성자</td>
						<td width="120">등록일</td>
						<td width="70">조회수</td>-->
					</tr>
<%
					'====================================
					'== 공지글이 있을경우를 위한 처리
					'====================================
					If arrnRsCnt <> -1 Then
						For i = 0 To arrnRsCnt	'배열크기 만큼 돌린다.																				
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & nData(0,i) & " "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td >[공지]</td>
						<td align="left" >&nbsp;&nbsp;<a href="javascript:MovePage('<%=nData(0,i)%>','Content.asp','','','');"><%=nData(1,i)%></a></td>
						<td><%=nData(2,i)%></td>
						<td><%=DateViewLen(nData(3,i),"/",10)%></td>
						<td><%=nData(4,i)%></td>
					</tr>
<%
						Next
					End If
					'====================================
					' 공지 처리 끝
					'====================================

					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
						cCnt = 0
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & objRs("Idx") & " "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
%>

					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td ><%=gSeq%></td>
						<td align="left">
							<%If reInt(objRs("re_level"),0) > 0  Then %><img src='/images/bbs/Space.gif' WIDTH="<%=objRs("re_level")*10%>" height=0 BORDER=0><img src='/images/bbs/icon_reply.gif' BORDER=0><%End If%>
							&nbsp;&nbsp;<a href="javascript:MovePage('<%=objRs("Idx")%>','Write.asp','MODIFY','','');">
							<%If inRStr(objRs("addoption"),1,",",1,1) Then%><!--<img src=/images/bbs/icon_private.gif align=absmiddle>--><%End If%>
							<%=reString(objRs("content"),"text")%></a>
							<%If objRs("ip") = "delete" Then %><font color=#999999><b>[삭제글]<b></font><%End If%>
							<!--<%If cCnt > 0 Then %> <font color=red>[<%=cCnt%>]</font><%End If%>&nbsp;&nbsp;-->
							<!--<% If DateDiff("h",objRs("WriteDay"),now()) < 24 Then %> <img src=/images/bbs/icon_new.gif align=absmiddle> <% End If %>-->
						</td>
						<!--<td><%=objRs("writer")%></td>
						<td ><%=DateViewLen(objRs("WriteDay"),"/",10)%></td>
						<td ><%=objRs("Hit")%></td>-->
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
						<td align=right>
							<input type=button value="등 록" onclick="MovePage('','Write.asp','WRITE','','');" id=button1 name=button1>		
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
	