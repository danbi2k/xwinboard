
<!--	#include virtual="/Admin/top.asp"	-->
<!--	#include file="config.asp"			-->
<%
Dim strFile(2)
Dim strWriter
Dim strMail
Dim strHomePage
Dim strSubject
Dim IntHtml
Dim strAddoption
Dim strContent

IntIdx		= Request("Idx")
Sect		= Request("Sect")
CurPage		= Request("CurPage")
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
TableName	= Request("TableName")
strFlag		= Request("flag")
strWriter	= ""
strPwd		= RandomCode()
If strFlag	= "MODIFY" or strFlag = "REPLY" Then

	SQL = "SELECT Writer, email, Subject, Html, Addoption, Content, File1, File2, Pwd, Id, Notk FROM "& TableName &" WHERE Idx = "& IntIdx &""
	Set objRs = RunSQLReturnRS(SQL)
	If objRs.BOF or objRs.EOF Then Call descment("잘못된 요청입니다.","","")
		strWriter	= objRs("Writer")		: strMail		= objRs("email")
		strSubject	= objRs("subject")	: IntHtml		= objRs("html")
		strAddoption= objRs("addoption"): strContent	= objRs("content")
		strfile(1)	= objRs("file1")	: strfile(2)	= objRs("file2")
		strPwd		= objRs("pwd")		: strId		= objRs("Id")
		IntNotk		= objRs("Notk")
		
		If strFlag = "REPLY"  Then
			strSubject	= "[RE]:" &  " " & strSubject
			strContent	= "> " & strContent
			strContent	= Replace(strContent, chr(10), ">")
			strMail		= ""	: strHomePage	= ""
			IntHtml		= ""	: strAddoption= ""
			strfile(1)	= ""	: strfile(2)	= ""
		End If
	Call CloseDB()
	
End If
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

		
</script>
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
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
				<form name=rform action="action.asp" method=post onsubmit="return DefaultFormValidation(this);" enctype="multipart/form-data" >
				<!--필수넘기질 데이터-->
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
				
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;내용</td>
						<td bgcolor="#FFFFFF"><input type=text name=content size=50 MaxBytes="10000" value="<%=strContent%>" Information="Required" title="제목" class=text></td>
					</tr>
					<!--					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;메 일</td>
						<td bgcolor="#FFFFFF"><input type=text name=email size=50 MaxBytes="100" value="<%=strMail%>" class=text></td>
					</tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;HTML 적용</td>
						<td bgcolor="#FFFFFF">
							<select name="html">
								<option <%=gSelection(reInt(IntHtml,0),2,"selected")%> value="2">Text + &lt;BR&gt;</option>
								<option <%=gSelection(reInt(IntHtml,0),1,"selected")%> value="1">Text Only</option>
								<option <%=gSelection(reInt(IntHtml,0),3,"selected")%> value="3">HTML Only</option>
								<option <%=gSelection(reInt(IntHtml,0),4,"selected")%> value="4">HTML + &lt;BR&gt;</option>
							</select>						
						</td>
					</tr>

<%
					If strFlag <> "REPLY" Then
%>					
					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;TOP공지 적용</td>
						<td bgcolor="#FFFFFF">
							<select name="Notk">
								<option <%=gSelection(reInt(IntNotk,0),0,"selected")%> value="0">아니요</option>
								<option <%=gSelection(reInt(IntNotk,0),1,"selected")%> value="1">등 록</option>
							</select>						
						</td>
					</tr>
					
<%
					End If
%>					

					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;비밀번호</td>
						<td bgcolor="#FFFFFF"><input type=password name=pwdd value="<%=strPwd%>"  size=30 MaxBytes="15" Information="Required" title="비밀번호" class=text></td>
					</tr>
					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;내 용</td>
						<td bgcolor="#FFFFFF"><textarea name=content Information="Required" title="내용" style="width:400;height:200" ><%=strContent%></textarea></td>
					</tr>
<%
					For i=1 To CONF_FILE_CNT
%>					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;첨부파일</td>
						<td bgcolor="#FFFFFF"><input type=file name="file<%=i%>" size=50 class=text></td>
						<input type=HIDDEN name="OldFile<%=i%>" value="<%=getInfo(strfile(i),0,chr(13)&chr(10))%>">
					</tr>
<%
					Next
%>					
-->
				</table>
			</td>
		</tr>

		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=submit value="등 록"  id=submit1 name=submit1></td>
						<td ><input type=button value="리스트" onclick="MovePage('','List.asp','','','');"></td>
						<% If strFlag = "MODIFY"  Then%><td ><input type=button value="삭제" onclick="MovePage('<%=IntIdx%>','del.asp','DELETE','','');" id=button1 name=button1></td><%End IF%>
						
					</tr>

				</table>
			</td>
		</tr>
		</form>
	</table>
</body>
</html>
<%
Call CloseDB()
%>
	