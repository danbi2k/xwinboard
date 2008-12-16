<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual="/common/asp/oops.asp"			-->
<!--	####################################				-->
<!--	#include file="config.asp"							-->
<!--	####################################				-->
<%
Dim strFlag
Dim IntIdx
strFlag			= Request("flag")
IntIdx			= Request("Idx")
TableName		= Request("TableName")
KeyField		= Request("KeyField")
KeyWord			= Request("KeyWord")
SortColumn		= Request("SortColumn")
strSort			= Request("Sort")
CurPage			= Request("CurPage")
Sect			= Request("Sect")

Dim strFile(2)
Dim strWriter
Dim strMail
Dim strHomePage
Dim strSubject
Dim IntHtml
Dim strAddoption
Dim strContent

strWriter	= Session("UName")
If strFlag	= "MODIFY" or strFlag = "REPLY" Then

	SQL = "SELECT * FROM "& TableName &" WHERE Idx = "& IntIdx &" And Sect='"& Sect &"'"
'	Response.Write SQL
	Set objRs = RunSQLReturnRS(SQL)
	
		If objRs.BOF or objRs.EOF Then Call descment("잘못된 요청입니다.","","")
			strWriter	= objRs("Writer")	: strMail		= objRs("email")
			strSubject	= objRs("subject")	: IntHtml		= objRs("html")
			strAddoption= objRs("addoption"): strContent	= objRs("content")
			strfile(1)	= objRs("file1")	: strfile(2)	= objRs("file2")
			strPwd		= objRs("pwd")		: strId		= objRs("Id")
		
'			If strFlag = "MODIFY" Then If strId <> Session("UId") Then Call descment("수정권한이 없습니다.","list.asp","")
		
			If strFlag = "REPLY"  Then
				strWriter	= Session("UName")
				strSubject	= "[RE]:" &  " " & strSubject
				strContent	= "> " & strContent
				strContent	= Replace(strContent, chr(10), ">")
				strMail		= ""	: strHomePage	= ""
				IntHtml		= ""	: strAddoption= ""
				strfile(1)	= ""	: strfile(2)	= ""
			End If
End If
Call CloseDB()
strRefPage = "/community/board/Write.asp?TableName="& TableName &"&Sect="&Sect&"&flag="&strFlag
'If inRStr(strAddoption,1,",",1,1) And strFlag = "MODIFY" Then If Not isShowPrivate(TableName,IntIdx,strPwd) Then Call descment("list.asp?TableName="& TableName ,"","")
If reInt(CONF_READONLY,1) = 1 Then Call descment("잘못된 요청입니다.","back","")
'If isNone(strWriter) And Sect=4 Then Call descMentPage("","location.href='List.asp?TableName="& TableName &"&Sect="&Sect&"';","window.open('/login.asp?flag=1&refPage="& server.URLEncode(strRefPage) &"','LI','width=300,height=150');") 
%>
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
function MovePage(goP) {
	getQuery["goPage"]		= '<%=CurPage%>';
	getQuery["CurPage"]		= '<%=CurPage%>';
	getQuery["CurBlock"]	= '<%=CurBlock%>';
	getQuery["TableName"]	= '<%=TableName%>';
	getQuery["KeyField"]	= '<%=KeyField%>';
	getQuery["KeyWord"]		= '<%=KeyWord%>';
	getQuery["SortColumn"]	= '<%=strSortColumn%>';
	getQuery["Sort"]		= '<%=strSort%>';
	getQuery["Sect"]		= '<%=Sect%>';
	action('',goP);
}
</script> 	
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" width=980>
							
							<tr>
								<td  valign=top>
									<table border="0" cellpadding="0" cellspacing="0" width=100%>
										<tr>
											<td valign=top >
												
													
													
													
												<table border="0" cellpadding="0" cellspacing="0" width=99%>
													<tr><td height=10></td></tr>
													<tr>
														<td ><img src=/images/<%=bTitleImg%> ></td>
													</tr>
													<tr><td height=10></td></tr>
													<tr>
														<td>
															<table border="0" cellpadding="0" cellspacing="0" width=100%>
																<form name=rform action="action.asp" method=post onsubmit="return DefaultFormValidation(this);"  enctype="multipart/form-data" >
																<input type="hidden" name="TableName"	value="<%=TableName%>"><!--현재페이지[이동할페이지]-->
																<input type="hidden" name="CurBlock"	value="<%=CurBlock%>"><!--현재페이지블럭.-->
																<input type="hidden" name="KeyField"	value="<%=strKeyField%>"><!--검색필드.-->
																<input type="hidden" name="KeyWord"		value="<%=strKeyWord%>"><!--검색 키워드.-->
																<input type="hidden" name="SortColumn"	value="<%=SortColumn%>"><!--정렬 컬럼.-->
																<input type="hidden" name="Sort"		value="<%=strSort%>"><!--정렬 방식.-->
																<input type="hidden" name="CurPage"		value="<%=CurPage%>"><!--페이지 번호.-->
																<input type="hidden" name=flag			value="<%=strFlag%>">
																<input type="hidden" name=Idx			value="<%=IntIdx%>">
																<input type="hidden" name=Sect			value="<%=Sect%>">
																<tr><td height=2 colspan=10 bgcolor=393839></td></tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr height=30 >
																	<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>작성자&nbsp;&nbsp;&nbsp;</td>
																	<td>&nbsp;
																		<input type=text size=20 class=input11 name=writer value="<%=strWriter%>" readonly Information="Required" title="작성자" MaxBytes=15>
																	</td>
																</tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr height=30 >
																	<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>제 목&nbsp;&nbsp;&nbsp;</td>
																	<td>&nbsp;
																		<input type=text size=50 class=input11 name=subject value="<%=strSubject%>" Information="Required" title="제목" MaxBytes=100>
																	</td>
																</tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr height=30 >
																	<td bgcolor=4A494A align=right><font color=9C9A9C><b>내 용&nbsp;&nbsp;&nbsp;</td>
																	<td>&nbsp;
																		<textarea rows=13 cols=80 name="content" Information="Required" title="내 용" class="textarea1"><%=strContent%></textarea>
																	</td>
																</tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
			<%
																For i=1 To CONF_FILE_CNT
			%>													
																<tr height=30 >
																	<td bgcolor=4A494A align=right><font color=9C9A9C><b>첨부파일&nbsp;&nbsp;&nbsp;</td>
																	<td>&nbsp;
																		<input type=file class=input11 size=50 name="file<%=i%>">
																	</td>
																</tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
																<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
			<%
																Next
			%>													
															</table>
														</td>
													</tr>
													
													<tr><td height=10></td></tr>
													<tr>
														<td align=center>
															<table border="0" cellpadding="0" cellspacing="0" width=100%>
																
																	<td align=center>
																		<input type=submit class=btn6 value="입 력">
																		<input type=button class=btn8 value="취 소" onclick="MovePage('list.asp');">
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