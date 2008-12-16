
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
pageSize	= reInt(Request("pageSize"),20)
ListFlag	= reInt(Request("ListFlag"),1)

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

SQL = "SELECT Idx, Subject, Writer, WriteDay, Id, Hit, re_level, Addoption, ip, Hidden, Content FROM "& TableName &" WHERE Notk=0 And Sect='"& Sect &"' "
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

If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//정렬방식 순서 변경
%>

<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gPs, gLf, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["TableName"]	= '<%=TableName%>';
		if (gLf=='') {
		getQuery["ListFlag"]	= '<%=ListFlag%>';
		} else {
		getQuery["ListFlag"]	= gLf;
		}
		if (gPs=='') {
		getQuery["pageSize"]	= '<%=pageSize%>';
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
		getQuery["pageSize"]	= '<%=pageSize%>';
		getQuery["ListFlag"]	= '<%=ListFlag%>';
		action();
	}

	
function ShowModals(Id){
	var IdPopup = '/admin/Member/IframeModify.asp?Id='+Id;
	window.showModalDialog(IdPopup,self,'width=200,height=800')
	return;
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
								<option <%=gSelection(KeyField,"Id","selected")%> value="Id">아이디</option>
								<option <%=gSelection(KeyField,"Writer","selected")%> value="Writer">작성장</option>
								<option <%=gSelection(KeyField,"Subject","selected")%> value="Subject">제 목</option>
								<option <%=gSelection(KeyField,"content","selected")%> value="content">내 용</option>
							</select>
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord value="<%=KeyWord%>">
								<input type=submit value="검 색">
								&nbsp;&nbsp;&nbsp;
							<select name=pageSize onchange="MovePage('','List.asp','','',this.value,'','');">
								<option <%=gSelection(pageSize,10,"selected")%> value="10">10 출력</option>
								<option <%=gSelection(pageSize,20,"selected")%> value="20">20 출력</option>
								<option <%=gSelection(pageSize,50,"selected")%> value="50">50 출력</option>
								<option <%=gSelection(pageSize,80,"selected")%> value="80">80 출력</option>
								<option <%=gSelection(pageSize,100,"selected")%> value="100">100 출력</option>
								<option <%=gSelection(pageSize,150,"selected")%> value="150">150 출력</option>
								<option <%=gSelection(pageSize,200,"selected")%> value="200">200 출력</option>
							</select>
							&nbsp;&nbsp;&nbsp;
							<input type=radio name="ListFlag" value=0 <%=gSelection(ListFlag,0,"checked")%> onclick="MovePage('','List.asp','','','',this.value,'');">리스트보기
							<input type=radio name="ListFlag" value=1 <%=gSelection(ListFlag,1,"checked")%> onclick="MovePage('','List.asp','','','',this.value,'');" id=checkbox1 name=checkbox1>펼침보기
							
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
						<td width="80">번 호</td>
						<td width="800">제 목</td>
						<!--<td width="150">아이디</td>-->
						
						<td width="150">작성자</td>
						<!--<td width="120">아이피</td>-->
						<td width="120">등록일</td>
						<td width="70">조회수</td>
					</tr>
<%
					'====================================
					'== 공지글이 있을경우를 위한 처리
					'====================================
					If arrnRsCnt <> -1 Then
						For i = 0 To arrnRsCnt	'배열크기 만큼 돌린다.																				
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & nData(0,i) & " And Hidden=0 "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td></td>
						<td >[공지]</td>
						<td align="left" >&nbsp;&nbsp;<a href="javascript:MovePage('<%=nData(0,i)%>','Content.asp','','','','');"><%=nData(1,i)%></a></td>
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
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & objRs("Idx") & " And Hidden=0 "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
%>

					<tr height="20" align="center"  <%If reInt(objRs("re_level"),0) > 0  Then %> bgcolor=FFDCFF <%Else%> bgcolor=FFFFFF <%End If%> onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""' >
						<td><input type=checkbox name=selcheck value="<%=objRs("Idx")%>"></td>
						<td ><%=gSeq%></td>
						<td align="left">
							<%If reInt(objRs("re_level"),0) > 0  Then %><img src='/images/bbs/Space.gif' WIDTH="<%=objRs("re_level")*10%>" height=0 BORDER=0><img src='/images/bbs/icon_reply.gif' BORDER=0><%End If%>
							&nbsp;&nbsp;<a href="javascript:MovePage('<%=objRs("Idx")%>','Content.asp','','','','');">
							<%If inRStr(objRs("addoption"),1,",",1,1) Then%><!--<img src=/images/bbs/icon_private.gif align=absmiddle>--><%End If%>
							<%=reString(TextLeft(objRs("subject"),60),"text")%></a>
							<%If objRs("ip") = "delete" Then %><font color=#999999><b>[삭제글]<b></font><%End If%>
							<%If cCnt > 0 Then %> <font color=red>[<%=cCnt%>]</font><%End If%>&nbsp;&nbsp;
							<% If DateDiff("h",objRs("WriteDay"),now()) < 24 Then %> <img src=/images/bbs/icon_new.gif align=absmiddle> <% End If %>
						
						</td>
						<td><%=objRs("Id")%></td>
						<td align="left"><nobr><%=objRs("writer")%></td>
						<!--<td align="left"><nobr><%=objRs("Ip")%></td>-->
						<td ><nobr><%=objRs("WriteDay")%></td>
						<td ><%=objRs("Hit")%></td>
					</tr>
					<% If ListFlag=1 Then %>
					<tr <%If reInt(objRs("re_level"),0) > 0  Then %> bgcolor=FFDCFF <%Else%> bgcolor=EFEFEF <%End If%> style="padding-top:5pt;padding-bottom:5pt;">
						<td colspan=10 style="padding-left:20pt">
							<table border=0 cellpadding=0 cellspacing=0 width=100%>
								<tr>
									<td valign=top>
										<table border=0 cellpadding=2 cellspacing=0>
											<tr height=30>
												<%If Not isNone(objRs("Id")) And reInt(objRs("re_level"),0) = 0  Then %>
												<td ><input type=button value="회원정보" class=btn1 onclick="MM_winopen('/admin/Member/IframeModify.asp?Id=<%=objRs("Id")%>','IM','width=850,height=600,scrollbars=1');" ></td>
												<td ><input type=button value="배팅내역" class=btn1 onclick="MM_winopen('/admin/Game/IframebMem.asp?Id=<%=objRs("Id")%>','IM','width=980,height=650,scrollbars=1');"></td>

												<%End If %>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td ><%=reString(objRs("content"),"text")%></td>
								</td>
							</table>
						</td>
					</tr>
					<%End If %>
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
							&nbsp;&nbsp;<input type=button value="선택삭제" onclick="if(confirm('삭제 하시겠습니까?')){ MovePage('','CkDel.asp','','','',frms); }"  id=button2 name=button2>
						</td>
						<td align=right>
							<input type=button value="등 록" onclick="MovePage('','Write.asp','WRITE','','','','');" id=button1 name=button1>		
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
		</form>
	</table>
</body>
</html>
<iframe id="exeFrame" name="exeFrame" width=0 height=0></iframe>
