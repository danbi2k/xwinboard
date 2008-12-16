<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual="/common/asp/oops.asp"			-->
<!--	#include virtual="/common/asp/RecordPasing.asp"		-->
<!--	#include file="config.asp"							-->
<!--	####################################				-->
<%
KeyField		= Request("KeyField")
KeyWord			= Request("KeyWord")
strSortColumn	= Request("SortColumn")
strSort			= Request("Sort")

pageSize = 20
CurPage		= reInt(Request("CurPage"),1)
goPage		= Request("goPage")
TableName	= "community_TB"
CurBlock	= Trim(Request("CurBlock"))
Sect		= reInt(Request("Sect"),0)

order = " ORDER BY ref DESC , re_step ,Idx DESC"
SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit, Content, file1, HomePage FROM "& TableName &" WHERE Notk = 1 And Hidden=0 "
If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
SQL = SQL & order
Set objRs = RunSQLReturnRS(SQL)
	If objRs.EOF or objRs.BOF Then
		arrnRsCnt = -1
	Else	
		nData = objRs.GetRows()
		arrnRsCnt = Ubound(nData,2)
	End If
objRs.Close

'Response.Write SQL &"<br>"	
'검색


SQL = "SELECT Idx, Subject, Writer, WriteDay, Hit, re_level, Addoption, ip, Id, file1, Email, Content, file1 FROM "& TableName &" WHERE Notk=0 And Sect='"& Sect &"' And Hidden=0 "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
SQL = SQL & order
'Response.Write sql &"<br>"
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
If(strSort="" Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//정렬방식 순서 변경

%>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';	
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["Sort"]		= Sort;
		getQuery["SortColumn"]	= SortColumn;
		action();
	}	

	function MovePage(gId, goP, goF, gSe) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["SortColumn"]	= '<%=strSortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["Idx"]			= gId;
		getQuery["flag"]		= goF;
		action('',goP);
	}
	
	function ListPageGo(PageIndex) {
		getQuery["CurPage"]		= PageIndex;
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["SortColumn"]	= '<%=strSortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		action();
	}
</script>    
	
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" width=95%>
							
							<tr>
								<td  >
									<table border="0" cellpadding="0" cellspacing="0" width=980>
										<tr>
											<td valign=top >
												<table border="0" cellpadding="0" cellspacing="0" width=99%>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=99%>
																<tr><td height=10></td></tr>
																<tr>
																    <td ><img src=/images/<%=bTitleImg%> ></td>
																</tr>
																<tr>
																    <td >
																		
																		
																		<table border="0" cellpadding="0" cellspacing="0" width=100%>
												                            <tr>
																				<td>
																					<table border="0" cellpadding="0" cellspacing="0" width=100%>
																						<tr>
																							<td >
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr><td height=1 bgcolor=424142 colspan=10></td></tr>
																									<tr align="center" height="27" bgcolor=212021> 
																										<td width="70" ><font color=FFFFFF><b>번 호</td>
																										<td width="500"><font color=FFFFFF><b>제 목</td>
																										<td width="100" ><font color=FFFFFF><b>이 름</td>
																										<td width="90" ><font color=FFFFFF><b>작성일</td>
																										<td width="45" ><font color=FFFFFF><b>조회수</td>
																									</tr>
																									<tr><td height=1 bgcolor=000000 colspan=10></td></tr>
																									<tr><td height=1 bgcolor=424142 colspan=10></td></tr>
																									
																								</table>
																							</td>
																						</tr>
																						<tr>
																							<td >
																								<table border="0" cellpadding="0" cellspacing="0" width=100%>
												<%

																									If arrnRsCnt <> -1 Then
																										For i = 0 To arrnRsCnt	'배열크기 만큼 돌린다.
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & nData(0,i) & " And Hidden=0 "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
																										%>
																									<tr height=30 align=center bgcolor=212021>
																										<td width=70 align=center><font color=C6C7C6><b>⊙</td>
																										<td align=left width="500">
																											
																											<a href="javascript:MovePage('<%=nData(0,i)%>','Content.asp','','','');">
																											<font color=C6C7C6><b><%=reString(TextLeft(nData(1,i),70),"text")%></a>
																											<% If DateDiff("h",nData(3,i),now()) < 24 Then %> <img src=/images/bbs/icon_new.gif align=absmiddle> <% End If %>
																										</td>
																										<td width=100><font color=949494><%=nData(2,i)%></td>
																										<td width=90><font color=949494><%=DateViewLen(nData(3,i),"/",10)%></td>
																										<td width=45><font color=949494><%=nData(4,i)%></td>
																									</tr>
																									<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																									<tr><td height=1 colspan=10 bgcolor=313431></td></tr>
																										
																										
																										
<%
																										Next
																									End If
																									'====================================
																									' 공지 처리 끝
																									'====================================																										
						
						
						
																									If objRs.EOF or objRs.BOF Then
																										Response.Write "<tr><td height=200 align=center colspan=20 >등록된 자료가 없습니다.</td></tr>"
																									Else
																									    Dim count : count = 0
																									    Do Until objRs.EOF Or count >= pageSize
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT Count(num) FROM "& TableName &"_comment WHERE bnum = " & objRs("Idx") & " And Hidden=0 "
	Set Rss = RunSQLReturnRS(SQL)
	cCnt = Rss(0)
	Rss.Close
End If
												%> 												
																									<tr height=30 align=center>
																										<td width=70 align=center><font color=949494><%=gSeq%></td>
																										<td align=left width=500>
																											<%If reInt(objRs("re_level"),0) > 0  Then %><img src='/images/bbs/Space.gif' WIDTH="<%=objRs("re_level")*10%>" height=0 BORDER=0><img src='/images/bbs/icon_reply.gif' BORDER=0><%End If%>
																											&nbsp;<%If Sect=3 Then %><img src='/images/bbs/icon_private.gif'><%End If%>&nbsp;<%If Sect=1 or Sect=2 Then %><a href="javascript:MovePage('<%=objRs("Idx")%>','Content.asp','','','');"><%Else%><%If Session("UId")=objRs("Id")  Then %><a href="javascript:MovePage('<%=objRs("Idx")%>','Content.asp','','','');"><%End If%><%End If%>
																											<%If inRStr(objRs("addoption"),1,",",1,1) Then%><img src=/images/bbs/icon_private.gif align=absmiddle><%End If%><font color=C6C7C6><%=reString(TextLeft(objRs("Subject"),70),"text")%></a>
																											<%If objRs("ip") = "delete" Then %><font color=#C6C7C6><b>[삭제글]<b></font><%End If%>
																											<%If cCnt > 0 Then %> <font color=red>[<%=cCnt%>]</font><%End If%>&nbsp;&nbsp;
																											<% If DateDiff("h",objRs("writeday"),now()) < 24 Then %> <img src=/images/bbs/icon_new.gif align=absmiddle> <% End If %>
																										</td>
																										<td width=100><font color=949494><%=objRs("Writer")%></td>
																										<td width=90><font color=949494><%=DateViewLen(objRs("WriteDay"),"/",10)%></td>
																										<td width=45><font color=949494><%=objRs("Hit")%></td>
																									</tr>
																									<tr><td height=1 colspan=10 bgcolor=313431></td></tr>
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
																						<tr><td height=10></td></tr>
																						<tr>
																							<td align=center>
																								<table border="0" cellpadding="0" cellspacing="0" width=100%>
																									<form name=sfrms method=post action="List.asp">
																									<input type=hidden name=TableName value="<%=TableName%>">
																									<input type=hidden name=Sect value="<%=Sect%>">
																									<tr height=30 >
																										<td width=400 align=right>
																											<select name=KeyField class=select1>
																												<option value="Writer">작성자</option>
																												<option value="Subject">제목</option>
																												<option value="Content">내용</option>
																											</select>
																										</td>
																										<td>
																											<input type=text class=input11 name=KeyWord><input type=submit value="검색" class=btn9 >
																										</td>
																										
																											
																										<td width=10 align=right>
																											<% If reInt(CONF_READONLY,0)=0 Then%><input type=button value="글쓰기" class=btn8 onclick="MovePage('','Write.asp','WRITE','')"><%End If%>
																										</td>
																									</tr>
																									</form>
																								</table>
																							</td>
																						</tr>
																						<tr><td height=10></td></tr>
																						<tr>
																							<td colspan=10 align=center>
																							<%=getPrintPagingBoard(pageSize, CurPage, rsCount)%>
																								<!--<img src=/images/icon_arr5.gif align=absmiddle>| <b>1</b></font> | 2 |<img src=/images/icon_arr6.gif align=absmiddle>-->
																										
																							</td>
																						</tr>
																							
																					</table>
																				</td>
																			</tr>
												                        </table>
                        
                        
                        
                        
																	</td>
																</tr>
															</table>
														
														</td>
													</tr>
												</table>
								
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>							
			</table>
		</td>
	</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										