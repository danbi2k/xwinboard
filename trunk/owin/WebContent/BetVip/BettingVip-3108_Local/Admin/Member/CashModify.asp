<!--	#include virtual="/Admin/top.asp"					-->
<%
	strId		= Request("Id")
	Sect		= Request("Sect")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	Flag		= Request("flag")
	refPage		= IfElse(Request("refPage"),"MemberList.asp")
	If Flag = "MODIFY" Then
		RunSQL("UPDATE Member_TB Set Point='"& Request("Point") &"' WHERE Id='"& strId &"'")
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","Modify.asp?Id="&strId&"&CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If

	If Flag = "DELETE" Then
		Call MemberDel(strId)
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","MemberList.asp?CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
		
	SQL = "SELECT * FROM Member_TB WHERE Id='"& strId &"'"
	Set objRs = RunSQLReturnRs(SQL)
	If objRs.EOF or objRs.BOF Then
		Call CloseDB()
		Call descment("������ ȸ�������Դϴ�.","back","")		
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
		getQuery["Id"]			= gId;
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
						<td><font color="#ffffff" size="4"><b>[ȸ������]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
	
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;ȸ������</td></tr>					<form name=frms method=post action="Modify.asp" onsubmit="return DefaultFormValidation(this);" >
					<input type=hidden name=flag value="MODIFY">
					<input type=hidden name=CurPage value="<%=CurPage%>">
					<input type=hidden name=CurBlock value="<%=CurBlock%>">
					<input type=hidden name=KeyField value="<%=KeyField%>">
					<input type=hidden name=KeyWord value="<%=KeyWord%>">
					<input type=hidden name=id value="<%=strId%>">
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;���̵�</td>
						<td bgcolor="#FFFFFF"><%=strId%></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�� ��</td>
						<td bgcolor="#FFFFFF"><%=objRs("Name")%></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�ֹι�ȣ</td>
						<td bgcolor="#FFFFFF"><%=getInfo(objRs("Jumin"),0,"-")%>-*******</td>
					</tr>
										<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�̸���</td>
						<td bgcolor="#FFFFFF"><%=objRs("mail")%></td>
					</tr>					
										<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�޴��ȣ</td>
						<td bgcolor="#FFFFFF"><%=objRs("cell")%></td>
					</tr>					
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;������</td>
						<td bgcolor="#FFFFFF"><%=objRs("WriteDay")%></td>
					</tr>					<!--
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���纸�� ������</td>
						<td bgcolor="#FFFFFF"><%=objRs("Point")%><input type=text name=Point size=10 class=input4 value="<%=objRs("Point")%>" Information="Required" MaxBytes="10" title="���纸���Ӵ�"  TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();"  ></td>
					</tr>					-->
				</table>
			</td>
		</tr>
	
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >						<!--<td ><input type=submit value="����"  id=submit1 name=submit1></td>-->
						<td ><input type=button value="����Ʈ" onclick="MovePage('','<%=refPage%>','','','');"></td>
						<td ><input type=button value="�� ��" onclick="if(confirm('������ ȸ���� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=strId%>','Modify.asp','DELETE','','');}" id=button1 name=button1></td>
					</tr>
				</form>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
<%
Call CloseDB()
%>
	