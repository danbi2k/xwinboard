
<!--	#include virtual="/Admin/top.asp"				-->
<!--	#include virtual="/common/asp/FileManage.asp"	-->
<!--	#include file = config.asp						-->
<!--	#include file = readClass.asp					-->
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=strKeyField%>';
		getQuery["KeyWord"]		= '<%=strKeyWord%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["pageSize"]	= '<%=pageSize%>';
		getQuery["ListFlag"]	= '<%=ListFlag%>';		
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
			<td align=center ><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;작성자</td>
						<td bgcolor="#FFFFFF"><%=strWriter%> ㅣ <%=Id%> |  작성일 : <%=strWriteDay%> ㅣ 조회수 : <%=IntHit%>  ㅣ 아이피 : <%=strIp%> </td>
					</tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;제 목</td>
						<td bgcolor="#FFFFFF"><%=strSubject%></td>
					</tr>					
<% 
					If Not isNone(strEmail) Then 
%>					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;메 일</td>
						<td bgcolor="#FFFFFF"><a href="mailto:<%=strEmail%>"><%=strEmail%></a></td>
					</tr>
<%
					End If
%>
<!--
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;TOP공지 적용</td>
						<td bgcolor="#FFFFFF"><%If IntNotk = 0 Then %> 아니요<%Else%> 등 록<%End If%></td>
					</tr>
					-->
<% 
					If Not isNone(strfile1) Then 
%>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;첨부파일</td>
						<td bgcolor="#FFFFFF"><%=strDownFile1%></td>
					</tr>
<% 
					End If
					If Not isNone(strfile2) Then 
%>					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;첨부파일</td>
						<td bgcolor="#FFFFFF"><%=strDownFile2%></td>
					</tr>
<% 
					End If
%>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;내 용</td>
						<td bgcolor="#FFFFFF" >
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr><td>&nbsp;</td></tr>
								<tr><td id="mainTD">
<%
									fileDisplay		= AutoPlay(strfile1, IntIdx, 1, 1, 1, 0, 0)
									fileDisplay2	= AutoPlay(strfile2, IntIdx, 2, 1, 1, 0, 0)
									If Not isNone(fileDisplay) Then Response.Write fileDisplay &"<br><br>"
									If Not isNone(fileDisplay2) Then Response.Write fileDisplay2
%>
								</td></tr>
								<tr><td style="word-break:break-all;"><%=strContent%></td></tr>
								<tr><td>&nbsp;</td></tr>
							</table>						
						</td>
					</tr>
<%
					If reInt(CONF_USECOMMENT,0) = 1 Then
					If arrComCnt > 0 Then
%>
					<tr bgcolor=FFFFFF >
						<td align=right colspan=10 style="word-break:break-all;">
							<table border=0 width=100% cellpadding=0 cellspacing=2>
							
<%
							For i=0 To arrComCnt-1
							' arrCom(0,i) ; num
							' arrCom(1,i) ; cname
							' arrCom(2,i) ; cComment
							' arrCom(3,i) ; WriteDay
							' arrCom(4,i) ; Ip
%>
								<tr>
									<td width=30 style="word-break:break-all;"><img src=/images/bbs/memo_icon.gif></td>
									<td width=80 style="word-break:break-all;"><%=arrCom(1,i)%></td>
									<td width=350 style="word-break:break-all;"><%=arrCom(2,i)%></td>
									<td width=90 style="word-break:break-all;"><%=arrCom(4,i)%></td>
									<td width=90 style="word-break:break-all;"><%=arrCom(6,i)%></td>
									<%If Sect=14 Then%>
									<td width=90 style="word-break:break-all;">
									<% For c=1 To arrCom(5,i) %> 
										<img src=/images/ss.gif>
									<%Next%>
									</td>
									<% End If%>
									
									<td width=20 align=center style="word-break:break-all;"><a href="javascript:if(confirm('삭제하시겠습니까?')) { MovePage('<%=IntIdx%>','CommentProcess.asp','comdelete','<%=arrCom(0,i)%>',''); }"><img src=/images/bbs/icon_comment_del.gif ></td>
									<td width=80 style="word-break:break-all;"><%=DateViewLen(arrCom(3,i), "/",10) %></td>
								</tr>
								<tr><td colspan=6 bgcolor="e0e0e0"></td></tr>
<%
							Next
%>
							</table>
						</td>
					</tr>
<%								
					End If
					Randomize 
					NanNumber	= int(rnd()*24)+1
					strPwd		= replace(left(now(),10),"-","")&NanNumber
%>

					<tr bgcolor=FFFFFF >
						<td align=right colspan=10>
							<table width=100% border=0 cellpadding=0 cellspacing=5>
								<form name=cofrm method=post action="CommentProcess.asp" onsubmit="return DefaultFormValidation(this);">
								<%If Sect=14 Then%>
								<tr>
									<td colspan=10>
										<table border=0 width=100% align=center>
											<tr>
												<td>
													<table width=100% border=0 align=center>
														<tr>
<%
															For i=1 To 10
															
%>														
															<td>
																<input type=radio name=rCnt <%If i=5 Then %> checked <%End If%> value="<%=i%>">
<%
																For c=1 To i
%>																
																<img src=/images/ss.gif>
<%
																Next
%>																
															</td>
<%
															If i mod 4=0 Then Response.Write "</tr><tr>"
															Next
%>															
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr><td height=1 bgcolor=aaaaaa></td></tr>
								<%End If%>
								<input type=hidden name="flag" value="comwrite">
								<input type=hidden name="Idx" value="<%=IntIdx%>">
								<input type=hidden name="TableName" value="<%=TableName%>">
								<input type=hidden name="KeyField" value="<%=strKeyField%>">
								<input type=hidden name="KeyWord" value="<%=strKeyWord%>">
								<input type=hidden name="SortColumn" value="<%=strSortColumn%>">
								<input type=hidden name="Sort" value="<%=strSort%>">
								<input type=hidden name="CurPage" value="<%=CurPage%>">
								<input type=hidden name="Sect" value="<%=Sect%>">
								<input type="hidden" name=pageSize		value="<%=pageSize%>">
								<input type="hidden" name=ListFlag		value="<%=ListFlag%>">
								
								<tr>
									<td align=right>
										<table border=0>
											<tr>
												<td colspan=2>
													작성자
													<input type="text" name=cname size=15 Information="Required" title="작성자" value="" MaxBytes="20" class="text" tabindex=1>
												</td>
											</tr>
											<tr>
												<td width=500>
													<textarea name=comment rows=1 cols=50 Information="Required" title="내용" MaxBytes="1000" tabindex=3 class=ggambo_textarea2></textarea>
												</td>
												<td >
													<input type=submit value="등록" style="width:67;height:45;border: solid 1" tabindex=4>
												</td>
											</tr>
												<input type="HIDDEN" name=pwd size=15 Information="Required" title="비밀번호" MaxBytes="15" value="<%=strPwd%>" class="text" tabindex=2>
											</form>
										</table>
									</td>
								</tr>
							</table>
													
						</td>
					</tr>

					<tr><td height="10" bgcolor=FFFFFF colspan=10></td></tr>

<%
					End If
%>

					<tr bgcolor="#e0e0e0" ><td height="3" colspan=10></td></tr>
<% 
					If Not isNone(PreIdx) Then 
%>
<!--
					<tr> 
						<td height="28" bgcolor=FFFFFF colspan=10>&nbsp;&nbsp;이전글 ▼ : 
							<a href="javascript:MovePage('<%=PreIdx%>','content.asp','');"><%=PreTitle%></a>
						</td>
																			
					</tr>
					<tr bgcolor="#e0e0e0"><td height="3" colspan=10></td></tr>
-->
<% 
					End If 
					If Not isNone(NextIdx) Then 
%>
<!--
					<tr> 
						<td height="28" bgcolor=FFFFFF colspan=10>&nbsp;&nbsp;다음글 ▲ : 
							<a href="javascript:MovePage('<%=NextIdx%>','content.asp','');"><%=NextTitle%></a>
						</td>
																			
					</tr>
					<tr bgcolor="#e0e0e0"><td height="3" colspan=10></td></tr>
-->
<% 
					End If 
%>


					<tr><td colspan="2" bgcolor=FFFFFF colspan=10>&nbsp;</td></tr>
					<tr align="right" bgcolor=FFFFFF colspan=10>
						<td colspan="2">
							<input type=button value="목 록" onclick="MovePage('','List.asp','','','');" class="btn" id=button1 name=button1>&nbsp;
							<input type=button value="수 정" onclick="MovePage('<%=IntIdx%>','write.asp','MODIFY','','');" class="btn" id=button1 name=button1> &nbsp;
							<input type=button value="삭 제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=IntIdx%>','del.asp','DELETE','',''); }" class="btn" id=button1 name=button1> &nbsp;
<%
							If reInt(CONF_USEREPLY,0) = 1 Then  
								If reInt(IntNotk,0) = 0 Then 
%>
							<input type=button value="답 변" onclick="MovePage('<%=IntIdx%>','write.asp','REPLY','','');" class="btn" id=button1 name=button1>
<%
								End If
							End If
%>
							<input type=button value="글쓰기" onclick="MovePage('<%=IntIdx%>','write.asp','WRITE','','');" class="btn" id=button1 name=button1> 
						</td>
					</tr>
<%			

					If arrRsCnt > 1 Then
%>	
<!--
					<tr><td colspan="2" bgcolor=FFFFFF>&nbsp;</td></tr>
					<tr>
						<td colspan="2" bgcolor=FFFFFF>
							<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
							    <tr height="30" align="center" bgcolor="#e0e0e0">
									<td width="60" height="28">번호</td>
							        <td width="351">제 목</td>
							        <td width="80">작성자</td>
							        <td width="80">등록일</td>
							        <td width="65">조회수</td>
							    </tr>
<%
								For i = 0 To arrRsCnt-1	'배열크기 만큼 돌린다.
																		
								If CONF_USECOMMENT = 1 Then
									
									Set objRs = RunSQLReturnRs("SELECT Count(num) FROM "& TableName &"_Comment WHERE bnum="& arrRs(0,i) &"")
									If Not objRs.BOF or Not objRs.EOF Then cCnt = objRs(0)
									Call CloseDB()
								End If
%>
								<tr align="center"  <%If inRStr(reInt(arrRs(0,i),0),IntIdx,"",1,0) Then%> bgcolor=#EFEFEF <%Else%>  bgcolor=FFFFFF onMouseOut="this.style.backgroundColor='FFFFFF';return true;" onMouseOver="this.style.backgroundColor='EFEFEF';return true;" <%End If%>> 
									<td height="26"><%=i+1%></td>
									<td align="left">
										<%If reInt(arrRs(8,i),0) > 0  Then %><img src='/images/bbs/Space.gif' WIDTH="<%=arrRs(8,i)*10%>" height=0 BORDER=0><img src='/images/bbs/icon_reply.gif' BORDER=0><%End If%>
										&nbsp;&nbsp;<a href="javascript:MovePage('<%=arrRs(0,i)%>','content.asp','');">
										<%If inRStr(arrRs(9,i),1,",",1,1) Then%><img src=/images/bbs/icon_private.gif align=absmiddle><%End If%>
										<%If inRStr(strKeyField,"subject","",1,0) Then%> <%=ReadText(TextLeft(arrRs(1,i),60),strKeyWord)%> <% Else %> <%=TextLeft(arrRs(1,i),60)%> <%End If%></a>
										<%If arrRs(10,i) = "delete" Then %><font color=#999999><b>[삭제글]<b></font><%End If%>
										<%If cCnt > 0 Then %> <font color=red>[<%=cCnt%>]</font><%End If%>&nbsp;&nbsp;
										<%If DateDiff("h",arrRs(6,i),now()) < 24 Then %> <img src=/images/bbs/icon_new.gif align=absmiddle> <% End If %>
									</td>
									<td><%If inRStr(strKeyField,"writer","",1,0) Then%> <%=ReadText(arrRs(2,i),strKeyWord)%> <% Else %> <%=arrRs(2,i)%> <%End If%></td>
									<td><%=DateViewLen(arrRs(6,i),"-",10)%></td>
									<td><%=arrRs(7,i)%></td>
								</tr>
<%
								Next
%>
							</table>
						</td>
					</tr>
					-->
<%
					End If
%>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
<%
Call CloseDB()
%>
	