<!--	#include virtual=/common/asp/top.asp			-->
<!--	####################################			-->
<!--	#include virtual="/common/asp/oops.asp"			-->
<!--	#include virtual="/common/asp/FileManage.asp"			-->
<!--	#include file=config.asp						-->
<!--	####################################			-->
<%

IntIdx			= Request("Idx")
KeyField		= Request("KeyField")
KeyWord		= Request("KeyWord")
strSortColumn	= Request("SortColumn")
strSort			= Request("Sort")
CurPage			= Trim(Request("CurPage"))
CurBlock		= Trim(Request("CurBlock"))
TableName		= Request("TableName")
Sect			= Request("Sect")

SQL ="SELECT *  FROM "& TableName &" WHERE Idx = "& IntIdx &" And Hidden=0 "
'Response.Write SQL
Set objRs = RunSQLReturnRS(SQL)
If objRs.EOF or objRs.BOF Then
	Call CloseDB()
	Call descment("잘못된 요청입니다.","back","") 
Else
	Dim strSubject, strWriter, strEmail
	strSubject	= objRs("subject")			: strWriter		= objRs("writer")
	strEmail	= objRs("email")			: strWriteday	= objRs("writeday")
	strContent	= objRs("content")			: IntHit		= objRs("hit")
	IntHtml		= objRs("html")				: Intref		= objRs("ref")
	strfile1	= objRs("file1")			: strfile2		= objRs("file2")
	IntNotk		= objRs("notk")				: strAddopt		= objRs("addoption")
	strIp		= objRs("ip")				: Id			= objRs("Id")
	HomePage	= objRs("HomePage")
	Re_Step		= objRs("Re_Step")
	

End If
If IntNotk <> 1 Then
If Sect =3  Then
If Session("UId") <> Id Then Call descment("","back","")
End If
End If
Select Case reInt(IntHtml, 1)
	Case 1 : strContent = reString(strContent, "text")
	Case 2 : strContent = reString(strContent, "mix")
	Case 3 : strContent = reString(strContent, "html")
	Case 4 : strContent = reString(strContent, "mix2")
	Case Else : strContent = reString(strContent, "mix")
End Select

If strIp = "delete" Then Call descment("잘못된 요청입니다.","back","")
If Sect = 2 Then
		RunSQL("UPDATE "& TableName &" SET Hit = hit + 1 WHERE Idx="& IntIdx &"")
Else
	If inStr("," & Request.Cookies("cookie")(TableName) & ",", "," & IntIdx & ",") = 0 Then
		RunSQL("UPDATE "& TableName &" SET Hit = hit + 1 WHERE Idx="& IntIdx &"")
		Response.cookies("cookie")(TableName) = Request.cookies("cookie")(TableName) & IntIdx & ","
	End If

End If


Dim TempFile, ViewStr1
If Not isNone(strfile1) Then
'	strDownFile1 = "<a href=javascript:getfile("& IntIdx &",1);>"& getInfo(strfile1,0,chr(13) & chr(10)) &"["& isIFAB(getInfo(strfile1,1,chr(13) & chr(10)) <> -1, reUnit(getInfo(strfile1,1,chr(13) & chr(10))) & "/ ", "") &" Down "& getInfo(strfile1,2,chr(13) & chr(10)) &"]</a>"
	strDownFile1 = "<a href=javascript:getfile("& IntIdx &",1);>"& getInfo(strfile1,0,chr(13) & chr(10)) &"</a>"
End If
	
If Not isNone(strfile2) Then 
'	strDownFile2 = "<a href=javascript:getfile("& IntIdx &",2);>"& getInfo(strfile2,0,chr(13) & chr(10)) &"["& isIFAB(getInfo(strfile2,1,chr(13) & chr(10)) <> -1, reUnit(getInfo(strfile2,1,chr(13) & chr(10))) & "/ ", "") &" Down "& getInfo(strfile2,2,chr(13) & chr(10)) &"]</a>"
	strDownFile2 = "<a href=javascript:getfile("& IntIdx &",2);>"& getInfo(strfile2,0,chr(13) & chr(10)) &"</a>"
End If


'코멘트 서치
If CONF_USECOMMENT = 1 Then
	SQL = "SELECT num, cname, cComment, WriteDay, Ip, Id FROM "& TableName &"_comment WHERE bnum = " & IntIdx & " And Hidden=0 ORDER BY num DESC"
	Set objRs = RunSQLReturnRS(SQL)
		If objRs.EOF or objRs.BOF Then
			arrComCnt = 0		
		Else	
			arrCom = objRs.GetRows()
			arrComCnt = Ubound(arrCom,2) +1
		End If
	objRs.Close
End If
 
	PWHERE = " WHERE Idx= (SELECT Top 1 Idx FROM "& TableName &" WHERE ref < "& Intref &" And re_step=0 And Sect='"& Sect &"' ORDER BY Idx DESC) "
	NWHERE = " WHERE Idx= (SELECT Top 1 Idx FROM "& TableName &" WHERE ref > "& Intref &" And re_step=0 And Sect='"& Sect &"' ORDER BY Idx ASC) "
'이전글 서치
SQL = "SELECT Idx,Subject FROM "& TableName & PWHERE & WHERE
'Response.Write sql
Set objRs = RunSQLReturnRS(SQL)
If Not objRs.BOF or Not objRs.EOF Then  PreIdx = objRs(0) : PreTitle = objRs(1)
objRs.Close

'다음글 서치
SQL = "SELECT Idx,Subject FROM "& TableName & NWHERE & WHERE
Set objRs = RunSQLReturnRS(SQL)
If Not objRs.BOF or Not objRs.EOF Then NextIdx = objRs(0) : NextTitle = objRs(1)
objRs.Close

'관련글 서치
SQL = "SELECT Idx, Subject, Writer, Email, File1, File2 ,WriteDay, Hit, re_level, "&_
" Addoption, ip FROM "& TableName &" WHERE Notk = 0 And ref='"& Intref &"' ORDER BY ref DESC, re_step"
Set objRs = RunSQLReturnRS(SQL)
	If objRs.EOF or objRs.BOF Then
		arrRsCnt = 1		
	Else	
		arrRs = objRs.GetRows()
		arrRsCnt = Ubound(arrRs,2) +1
	End If
Call CloseDB()
%>
<script language='javascript' src=/common/js/common.js></script>
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
		getQuery["senum"]		= gSe;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}
	
function getfile(fidx, fcnt) {
	window.location.href = "Download.asp?TableName=<%=TableName%>&Idx=" + fidx + "&fcnt=" + fcnt + "&dcnt=1";
}
		
function getviewImage(fidx, fcnt, f_file) {
	window.open("GetImgview.asp?TableName=<%=TableName%>&Idx=" + fidx + "&fcnt=" + fcnt + "&file=" + escape(f_file), "imgViewer", "top=10,left=10,toolbar=0,width=300,height=200,menubar=0,location=0,status=0,scrollbars=1");
}	
</script>	
<body onload="autoPlay();">
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

														<tr><td height=10></td></tr>
														<tr>
															<td height=21 width=750 background=/images/<%=bTitleImg%> style="background-repeat:no-repeat;"></td>
														</tr>
														<tr><td height=10></td></tr>
														<tr>
															<td>
																<table border="0" cellpadding="0" cellspacing="0" width=100%>
																	<tr><td height=2 colspan=10 bgcolor=393839></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr height=30 >
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>작성자&nbsp;&nbsp;&nbsp;</td>
																		<td width=250 >&nbsp;
																			<%=strWriter%>
																		</td>
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>조회수&nbsp;&nbsp;&nbsp;</td>
																		<td width=250 >&nbsp;
																			<%=IntHit%>
																		</td>
																	</tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr height=30 >
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>제 목&nbsp;&nbsp;&nbsp;</td>
																		<td colspan=5>&nbsp;
																			<%=strSubject%>
																		</td>
																	</tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr height=30 >
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>작성일&nbsp;&nbsp;&nbsp;</td>
																		<td colspan=5>&nbsp;
																			<%=DateViewLen(strWriteday,"/",10)%>
																		</td>
																	</tr>
																	<% If Not isNone(strDownFile1) Then %>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr height=30 >
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>첨부파일1&nbsp;&nbsp;&nbsp;</td>
																		<td colspan=5>&nbsp;
																			<%=strDownFile1%>
																		</td>
																	</tr>
																	<% End If%>
																	<% If Not isNone(strDownFile2) Then %>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr height=30 >
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>첨부파일&nbsp;&nbsp;&nbsp;</td>
																		<td colspan=5>&nbsp;
																			<%=strDownFile2%>
																		</td>
																	</tr>
																	<% End If%>
																	
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																	<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																	<tr height=30 >
																		<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>내 용&nbsp;&nbsp;&nbsp;</td>
																		<td colspan=5 style="padding-left:5pt">&nbsp;
																			<table border="0" cellpadding="0" cellspacing="0">
																				<tr><td id="mainTD">
				<%
																				fileDisplay1	= AutoPlay(strfile1, IntIdx, 1, 1, 1, 0, 0)
																				fileDisplay2	= AutoPlay(strfile2, IntIdx, 2, 1, 1, 0, 0)
																				If Not isNone(fileDisplay1) Then Response.Write fileDisplay1 &"<br><br>"
																				If Not isNone(fileDisplay2) Then Response.Write fileDisplay2
				%>
																				</td></tr>
																				<tr><td valign=top style="word-break:break-all;"><%=strContent%></td></tr>
																				<tr><td>&nbsp;</td></tr>
																			</table>
																		</td>
																	</tr>
																	<tr><td height=1 colspan=10 bgcolor=DADADA></td></tr>

																</table>
															</td>
														</tr>






<%

														If reInt(CONF_USECOMMENT,0)=1 Then
																			If arrComCnt > 0 Then
%>
													<tr><td height=10></td></tr>
													<tr>
														<td>
												<!-- 덧글리스트 -->
															<table width=100% border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td colspan=3 class=d_line><img src='/img/dsn/blank.gif' width=1 height=1></td>
																</tr>
<%
													For i=0 To arrComCnt-1
%>
																<tr height=30 align=center>
																	<td width=10%><%=arrCom(1,i)%></td>
																	<td width=75% align=left style="word-break:break-all;" style='padding-left:10px;'><%=arrCom(2,i)%><%If arrCom(5,i)=Session("UId") Then%><a href="javascript:if(confirm('삭제하시겠습니까?')) { MovePage('<%=IntIdx%>','Comment_Prc.asp','comdelete','<%=arrCom(0,i)%>','','sub_21_view.asp');}"><img src="/images/btn_xx.gif" align=absmiddle><%End If%></a></td></td>
																	<td width=15% class=no><%=DateViewLen(arrCom(3,i), ".",10) %></td>
																</tr>
																<tr><td height=1 colspan=10 bgcolor=DADADA></td></tr>
<%
													Next
%>																
																
															</table>
												<!-- 덧글리스트 끝// -->
														</td>
													</tr>
													<tr>
														<td><img src='/img/dsn/blank.gif' width=1 height=25></td>
													</tr>
<%
										End If
%>													
													<tr><td height=10></td></tr>
													<tr>
														<td>
												<!-- 덧글달기 -->

															<table width=100% border="0" cellspacing="0" cellpadding="0"><iframe name="cifrms" width=0 height=0></iframe>
																<form name="formscmt" method="post" onsubmit="return DefaultFormValidation(this);" action="Comment_Prc.asp">
																<input type=hidden name="Idx" value="<%=IntIdx%>">
																<input type=hidden name="TableName" value="<%=TableName%>">
																<input type=hidden name="KeyField" value="<%=KeyField%>">
																<input type=hidden name="KeyWord" value="<%=KeyWord%>">
																<input type=hidden name="SortColumn" value="<%=SortColumn%>">
																<input type=hidden name="Sort" value="<%=Sort%>">
																<input type=hidden name="CurPage" value="<%=CurPage%>">
																<input type=hidden name="Sect" value="<%=Sect%>">	
																<input type="hidden" name=flag			value="comwrite">
																
																<tr>
																	<td align=right>작성자&nbsp;<br>
																	<input class=input11 type=text name="cname" readonly value="<%=Session("UName")%>" Information="Required" title="이름" maxlength=15 size=10>&nbsp;</td>
																	
																	<td width=570><textarea cols=78 name="cComment" Information="Required" title="내용" rows=3 class=textarea2></textarea></td>
																	<td ><input type=submit value="등록" style="width:50;height:50" class=btn10></td>
																</tr>
																</form>
															</table>
												<!-- 덧글달기 끝// -->
														</td>
													</tr>
<tr>
														<td><img src='/img/dsn/blank.gif' width=1 height=20></td>
													</tr>

<%
								End If
%>	
<tr>
														<td><img src='/img/dsn/blank.gif' width=1 height=20></td>
													</tr>
													
													
													
													
													
													
													
																							
										<tr><td height=10></td></tr>
										<tr>
											<td align=center>
												<table border="0" cellpadding="0" cellspacing="0" width=100%>
													
														<td align=center>
															<input type=button value="목록" class="btn10" onclick="MovePage('','List.asp','','','');">
															<% If reInt(CONF_READONLY,1)=0 Then %>
															<input type=button value="글쓰기" class="btn10" onclick="MovePage('','Write.asp','WRITE','','');">
															<% If reInt(CONF_USEREPLY,0)=1 And IntNotk=0 Then%><input type=button value="답변" class="btn10" onclick="MovePage('<%=IntIdx%>','Write.asp','REPLY','','');"><% ENd If%>	
															<% If Id=Session("UId") And Re_Step=0 Then%><input type=button value="수정" class="btn10" onclick="MovePage('<%=IntIdx%>','Write.asp','MODIFY','','');">&nbsp;<% ENd If%>	
															
																<% If Sect=2 Then%>
																	<% If Id=Session("UId") Then%><input type=button value="삭제" class="btn10" onclick="if(confirm('삭제하시겠습니까?')){MovePage('<%=IntIdx%>','del.asp','DELETE','','');}"><% ENd If%>	
																<%Else%>
																	<% If Id=Session("UId") And Re_Step=0 Then%><input type=button value="삭제" class="btn10" onclick="if(confirm('삭제하시겠습니까?')){MovePage('<%=IntIdx%>','del.asp','DELETE','','');}"><%End If%>
																<% ENd If%>	
															<% ENd If%>	
														</td>
													</tr>
													
												</table>
											</td>
										</tr>
										</form>
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
	<tr><td height=50></td></tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										