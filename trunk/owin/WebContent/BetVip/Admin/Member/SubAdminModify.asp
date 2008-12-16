<!--	#include virtual="/Admin/top.asp"						-->
<!--	#include virtual="/common/asp/MemberClass.asp"			-->
<%
	IntIdx		= Request("Idx")
	Sect		= Request("Sect")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	Flag		= Request("flag")
	refPage		= IfElse(Request("refPage"),"SubAdminList.asp")
	
	If Flag = "WRITEACT" Then
		isId = isDupliSubAdminData("SId", reString(Request("Sid"),"sql"), blnEOF)
		If blnEOF=False Then  Call DescMent("이미등록된 아이디 입니다.\n\n다시 확인해주시기 바랍니다.","back","")
		
		SQL = "INSERT INTO Admin_TB (SId,Sname,Spwd,Ssection) VALUES('"& reString(Request("Sid"),"sql") &"','"& reString(Request("sname"),"sql") &"','"& reString(Request("spwd"),"sql") &"','1')"
'		Response.Write SQL
		RunSQL(SQL)
		Call CloseDB()
		Call descment("","SubAdminList.asp?CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
	
	If Flag = "MODIFYACT" Then
'		isId = isDupliSubAdminData("SId", reString(Request("Sid"),"sql"), blnEOF)
'		If blnEOF=False Then  Call DescMent("이미등록된 아이디 입니다.\n\n다시 확인해주시기 바랍니다.","back","")
		
		RunSQL("UPDATE Admin_TB Set Sname='"& reString(Request("Sname"),"sql") &"',spwd='"& reString(Request("spwd"),"sql") &"' WHERE Idx='"& IntIdx &"'")
		Call CloseDB()
		Call descment("수정되었습니다.","SubAdminModify.asp?Idx="&IntIdx&"&CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If

	If Flag = "DELETE" Then
		RunSQL("DELETE FROM Admin_TB WHERE Idx='"& IntIdx &"'")
		Call CloseDB()
		Call descment("삭제되었습니다.","SubAdminList.asp?CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
	
	SQL = "SELECT * FROM Admin_TB WHERE Idx='"& IntIdx &"'"
	Set objRs = RunSQLReturnRs(SQL)
	If Not objRs.EOF or Not objRs.BOF Then
		SId	=objRs("Sid")	:Sname	=objRs("Sname")	
		Spwd	=objRs("Spwd")
	End If
	
	If Flag = "MODIFY" Then
		Flag = "MODIFYACT"
	ElseIf Flag = "WRITE" Then
		Flag = "WRITEACT"
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
						<td><font color="#ffffff" size="4"><b>[부 운영자관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
	
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;정보</td></tr>
					<form name=frms method=post action="SubAdminModify.asp" onsubmit="return DefaultFormValidation(this);" >
					<input type=hidden name=flag value="<%=Flag%>">
					<input type=hidden name=CurPage value="<%=CurPage%>">
					<input type=hidden name=CurBlock value="<%=CurBlock%>">
					<input type=hidden name=KeyField value="<%=KeyField%>">
					<input type=hidden name=KeyWord value="<%=KeyWord%>">
					<input type=hidden name=idx value="<%=IntIdx%>">

					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;아이디</td>
						<td bgcolor="#FFFFFF">
							<% If Flag = "MODIFYACT" Then %>
							<%=Sid%>
							<% Else %>
							<input type=text name=Sid value="<%=Sid%>" size=30 Information="Required" MaxBytes="50" title="아이디">
							<a href="javascript:checkSubAdminId();"><img src=/images/btn_idck.gif align=absmiddle></a>
							<% End If%>
						</td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;성 명</td>
						<td bgcolor="#FFFFFF"><input type=text name=sname size=30 value="<%=SName%>" Information="Required" MaxBytes="50" title="성 명"></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;비밀번호</td>
						<td bgcolor="#FFFFFF"><input type=text name=spwd size=30 value="<%=SPwd%>" Information="Required" MaxBytes="50" title="비밀번호"></td>
					</tr>
					
					
				</table>
			</td>
		</tr>
	
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=submit value="등 록"  id=submit1 name=submit1></td>
						<td ><input type=button value="리스트" onclick="MovePage('','SubAdminList.asp','','','');"></td>
						<% If Flag = "MODIFYACT" Then%><td ><input type=button value="삭 제" onclick="if(confirm('삭제된 회원은 복구할 수 없습니다.\n\n삭제하시겠습니까?')){MovePage('<%=IntIdx%>','SubAdminModify.asp','DELETE','','');}" id=button1 name=button1></td><%End If%>
					</tr>
				</form>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>

	