
<!--	#include virtual="/Admin/top.asp"					-->
<%

	If Request("flag") = "DELETE" Then

		Idx		= Request("Idx")
		SQL = "SELECT Files FROM Banner_TB WHERE Idx='"& Idx &"'"
		Set objAdo = New ADOHelp
		Set objRs = objAdo.RunSQLReturnRs(SQL)
		If Not objRs.EOF or Not objRs.BOF Then
			Call DeleteFile(CONF_BANNER_PATH&objRs(0))	
		End If
		objAdo.RunSQL("DELETE FROM Banner_TB WHERE Idx='"& Idx &"'")
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","Modify.asp" ,"")
	End If	
	
	Set objAdo = New AdoHelp		
	SQL = "SELECT Idx, Files, Urls FROM Banner_TB Order By Idx DESC"
	Set objRs = objAdo.RunSQLReturnRs(SQL)
	If Not objRs.EOF or Not objRs.BOF Then
		arrRs = objRs.getRows()
		arrRsCnt = Ubound(arrRs,2)
	End If
	Call CloseDB()
%>
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' >
	function SubmisData(d,i) {
		if (d==1) {
			efrms.flag.value='MODIFY';
			efrms.submit();
		} else if (d==2) {
			if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){
				efrms.flag.value='DELETE';
				efrms.submit();
			}
		}
		
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
						<td><font color="#ffffff" size="4"><b>[���� ��ʰ���]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<form name="ifrms" method=post action="Modify_Process.asp" onsubmit="return DefaultFormValidation(this);" Enctype="multipart/form-data">
					<input type=HIDDEN name=flag  value="INSERT">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;��ʵ��</td></tr>
					<tr >
						<td bgcolor="#e0e0e0" width=20%>�������</td>
						<td bgcolor="#FFFFFF"><input type=file name=file size=50 class=text Information="Required" title="�������"></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0" >��ũ�ּ�</td>
						<td bgcolor="#FFFFFF"><input type=text name=url size=50 class=text></td>
					</tr>
					<tr >
						<td colspan=10 bgcolor="#FFFFFF" align=center rowspan=2><input type=submit value="�� ��" id=submit1 name=submit1></td>
					</tr>
					</form>
				</table>
			</td>
		</tr>		
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<form name="efrms" method=post action="Modify_Process.asp" onsubmit="return DefaultFormValidation(this);" Enctype="multipart/form-data">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;��ϵ� ���</td></tr>
					<input type=HIDDEN name=flag>
					<input type=HIDDEN name=RsCnt value="<%=arrRsCnt%>">
<%
					If Not isNone(arrRsCnt) Then
						For i=0 To arrRsCnt
						
%>
					<tr >
					
						<td bgcolor="#e0e0e0" rowspan=2 width=20%>
<%
						Exits = mid(arrRs(1,i), inStrRev(arrRs(1,i), ".") + 1)
						If Exits = Lcase("swf") Then
							Response.Write "<embed src='/FILES/BANNER/"& arrRs(1,i) &"' width='155' height='62'>"
						Else
							Response.Write "<a href="&arrRs(2,i)&" target='_blink'><img src='/FILES/BANNER/"& arrRs(1,i) &"' width='155' height='62' border=0></a>"
						End If
%>						
						</td>
						<td bgcolor="#e0e0e0" >�������</td>
						<td bgcolor="#FFFFFF"><input type=file name="file<%=i%>" size=50 class=text ></td>
						<input type="HIDDEN" name="OldFiles<%=i%>" value="<%=arrRs(1,i)%>">
						<td bgcolor="#e0e0e0" rowspan=2><input type=button value="�� ��" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){location.href='Modify.asp?Idx=<%=arrRs(0,i)%>&flag=DELETE';}"></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0" >��ũ�ּ�</td>
						<td bgcolor="#FFFFFF"><input type=text name=url size=50 class=text value="<%=arrRs(2,i)%>" ></td>
					</tr>
					
<%
	ss = ss & arrRs(0,i)&","
						Next
					End If
%>					
<input type=HIDDEN name=HIIdx value="<%=ss%>">
				</table>
			</td>
		</tr>
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=button value="�� ��" <%If isNone(arrRsCnt) Then %> onclick="alert('�ڷᰡ �����ϴ�.');" <%Else%>onclick="SubmisData(1);"<%End If%>></td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
	