
<!--	#include virtual="/Admin/top.asp"					-->
<%
	strId	= Request("Id")
	strName	= Request("Name")
	strMail	= Request("Mail")
	If Request("flag") ="SEND" Then
		Call SendMailAdver(4, Request("subject"), Request("content"), strMail)
		Call descment("�߼۵Ǿ����ϴ�.","close","")
	End If
%>
	<body onload="window.focus();">
	<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[���Ϻ�����]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<form name=frms method=post action="SendMail.asp" onsubmit="return DefaultFormValidation(this)">
					<input type=HIDDEN name=Id value="<%=strId%>">
					<input type=HIDDEN name=flag value="SEND">
					<input type=HIDDEN name="Mail" value="<%=strMail%>">
					<TR >
						<TD bgcolor="#e0e0e0">�޴»��</TD>
						<TD bgcolor="#FFFFFF">[<%=strId%>] <%=strName%></TD>
					</TR>
					<TR >
						<TD bgcolor="#e0e0e0">�޴»�� �ּ�</TD>
						<TD bgcolor="#FFFFFF"><%=strMail%></TD>
					</TR>
					<TR >
						<TD bgcolor="#e0e0e0">�����»�� �ּ�</TD>
						<TD bgcolor="#FFFFFF"><%=CONF_MASTER_MAIL%></TD>
					</TR>
					<TR >
						<TD bgcolor="#e0e0e0">�� ��</TD>
						<TD bgcolor="#FFFFFF"><input type=text name=subject Information="Required" title="�� ��" class=text size=40></TD>
					</TR>
					<TR>
						<TD bgcolor="#e0e0e0">�� ��</TD>
						<TD bgcolor="#FFFFFF"><textarea name=content style="width:290;height:130" Information="Required" MaxBytes="1000" title="����"></textarea></TD>
					</TR>

				</TABLE>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" >

					<TR>
						<TD colspan=10 align=center> <input type=submit value="�� ��"  id=submit1 name=submit1><input type=button value="�� ��" onclick="window.self.close();" id=button1 name=button1></TD>
					</TR>
					</form>
				</TABLE>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
