
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
	If objRs.BOF or objRs.EOF Then Call descment("�߸��� ��û�Դϴ�.","","")

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
				<!--�ʼ��ѱ��� ������-->
				<input type="hidden" name="TableName"	value="<%=TableName%>"><!--����������[�̵���������]-->
				<input type="hidden" name="CurBlock"	value="<%=CurBlock%>"><!--������������.-->
				<input type="hidden" name="KeyField"	value="<%=strKeyField%>"><!--�˻��ʵ�.-->
				<input type="hidden" name="KeyWord"		value="<%=strKeyWord%>"><!--�˻� Ű����.-->
				<input type="hidden" name="SortColumn"	value="<%=SortColumn%>"><!--���� �÷�.-->
				<input type="hidden" name="Sort"		value="<%=strSort%>"><!--���� ���.-->
				<input type="hidden" name="CurPage"		value="<%=CurPage%>"><!--������ ��ȣ.-->
				<input type="hidden" name=flag			value="<%=strFlag%>">
				<input type="hidden" name=Idx			value="<%=IntIdx%>">
				<input type="hidden" name=Sect		value="<%=Sect%>">
				<input type="hidden" name=UId		value="<%=strId%>">
<% 
		If Sect=3 Then		'������ �þ�
%>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF"><input type=text name=subject size=50 MaxBytes="100" value="<%=strSubject%>" Information="Required" title="����" class=text ></td>
					</tr>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;�þ�</td>
						<td bgcolor="#FFFFFF">
							<select name="part">
								<option <%=gSelection(part,"1���þ�","selected")%> value="1���þ�">1���þ�</option>
								<option <%=gSelection(part,"2���þ�","selected")%> value="2���þ�">2���þ�</option>
								<option <%=gSelection(part,"Ȯ���þ�","selected")%> value="Ȯ���þ�">Ȯ���þ�</option>
							</select>						
						</td>
					</tr>
					
<% 
		ElseIf Sect=4 or Sect=6 Then '�ΰ� ���ý�, ��ǰ���
%>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF"><input type=text name=subject size=50 MaxBytes="100" value="<%=strSubject%>" Information="Required" title="����" class=text ></td>
					</tr>
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF"><input type=text name=part size=30 MaxBytes="50" value="<%=part%>" Information="Required" title="����" class=text ></td>
					</tr>

<% 
		ElseIf Sect=7 Then '�̿��ı� �ٹ�
%>
					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;�̸�</td>
						<td bgcolor="#FFFFFF"><input type=text name=writer size=50 MaxBytes="100" value="<%=strWriter%>" Information="Required" title="�̸�" class=text ></td>
					</tr>
					
					<tr >
						<td width="20%" bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF"><input type=text name=subject size=50 MaxBytes="100" value="<%=strSubject%>" Information="Required" title="����" class=text ></td>
					</tr>
<%
		End If
%>	

					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;HTML ����</td>
						<td bgcolor="#FFFFFF">
							<select name="html">
								<option <%=gSelection(reInt(IntHtml,2),2,"selected")%> value="2">�±׻�� ����</option>
								<option <%=gSelection(reInt(IntHtml,2),4,"selected")%> value="4">�±׻��</option>
							</select>						
						</td>
					</tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;�� ��</td>
						<td bgcolor="#FFFFFF">
							<textarea name=content Information="Required" title="����" style="width:400;height:200" ><%=strContent%></textarea>
						</td>
					</tr>

<%
					For i=1 To CONF_FILE_CNT
%>					
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;÷������</td>
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
						<td ><input type=submit value="�� ��"  id=submit1 name=submit1></td>
						<td ><input type=button value="����Ʈ" onclick="MovePage('','List.asp','','','');"></td>
						
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
	