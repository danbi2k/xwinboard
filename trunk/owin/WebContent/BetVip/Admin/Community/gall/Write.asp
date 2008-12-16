
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include file="config.asp"							-->
<%
Dim strFile(10)
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
Sect		= Request("Sect")
'strWriter	= "STAGEPLUS"
strPwd		= RandomCode()
If strFlag	= "MODIFY" or strFlag = "REPLY" Then

	SQL = "SELECT * FROM "& TableName &" WHERE Idx = "& IntIdx &""
	Set objRs = RunSQLReturnRS(SQL)
	If objRs.BOF or objRs.EOF Then Call descment("잘못된 요청입니다.","","")

		strWriter	= objRs("Writer")		: 
		strMail		= objRs("email")		: strSubject	= objRs("subject")
		IntHtml		= objRs("html")			: strAddoption= objRs("addoption")
		strContent	= objRs("content")		: strfile(1)	= objRs("file1")
		strfile(2)	= objRs("file2")		: strfile(3)	= objRs("file3")
		strPwd		= objRs("pwd")			: strId		= objRs("Id")
		IntNotk		= objRs("Notk")			: part		= objRs("part")
		
'			If strFlag = "REPLY"  Then
'				strSubject	= "[RE]:" &  " " & strSubject
'				strContent	= "> " & strContent
'				strContent	= Replace(strContent, chr(10), ">")
'				strMail		= ""
'				strHomePage	= ""
'				IntHtml		= ""
'				strAddoption= ""
'				strfile(1)	= ""
'				strfile(2)	= ""
'			End If
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
		getQuery["Sect"]	= '<%=Sect%>';
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
				<input type="hidden" name=Sect		value="<%=Sect%>">
				<input type="hidden" name=UId		value="<%=strId%>">
<% 
		If Sect=3 Then		'디자인 시안
%>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;제목</td>
						<td bgcolor="#FFFFFF"><input type=text name=subject size=50 MaxBytes="100" value="<%=strSubject%>" Information="Required" title="제목" class=text ></td>
					</tr>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;시안</td>
						<td bgcolor="#FFFFFF">
							<select name="part">
								<option <%=gSelection(part,"1차시안","selected")%> value="1차시안">1차시안</option>
								<option <%=gSelection(part,"2차시안","selected")%> value="2차시안">2차시안</option>
								<option <%=gSelection(part,"확정시안","selected")%> value="확정시안">확정시안</option>
							</select>						
						</td>
					</tr>
					
<% 
		ElseIf Sect=4 or Sect=6 Then '로고 샘플실, 납품사례
%>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;제목</td>
						<td bgcolor="#FFFFFF"><input type=text name=subject size=50 MaxBytes="100" value="<%=strSubject%>" Information="Required" title="제목" class=text ></td>
					</tr>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;구분</td>
						<td bgcolor="#FFFFFF"><input type=text name=part size=30 MaxBytes="50" value="<%=part%>" Information="Required" title="구분" class=text ></td>
					</tr>

<% 
		ElseIf Sect=7 Then '이용후기 앨범
%>
					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;이름</td>
						<td bgcolor="#FFFFFF"><input type=text name=writer size=50 MaxBytes="100" value="<%=strWriter%>" Information="Required" title="이름" class=text ></td>
					</tr>
					
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;제목</td>
						<td bgcolor="#FFFFFF"><input type=text name=subject size=50 MaxBytes="100" value="<%=strSubject%>" Information="Required" title="제목" class=text ></td>
					</tr>
<%
		End If
%>	

					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;HTML 적용</td>
						<td bgcolor="#FFFFFF">
							<select name="html">
								<option <%=gSelection(reInt(IntHtml,2),2,"selected")%> value="2">태그사용 안함</option>
								<option <%=gSelection(reInt(IntHtml,2),4,"selected")%> value="4">태그사용</option>
							</select>						
						</td>
					</tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;내 용</td>
						<td bgcolor="#FFFFFF">
							<textarea name=content Information="Required" title="내용" style="width:400;height:200" ><%=strContent%></textarea>
						</td>
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
				</table>
			</td>
		</tr>

		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=submit value="등 록"  id=submit1 name=submit1></td>
						<td ><input type=button value="리스트" onclick="MovePage('','List.asp','','','');"></td>
						
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
	