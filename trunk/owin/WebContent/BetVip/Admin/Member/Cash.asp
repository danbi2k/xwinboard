
<!--	#include virtual="/Admin/top.asp"					-->
<%
	strId	= Request("Id")
	IntIdx	= Request("Idx")
	Cash	= rePlace(Request("Cash"),",","")
	strName	= Request("Name")
	If Request("flag") ="SEND" Then
		SQL1 = "UPDATE Cash_TB Set Status=1,InDay=getDate() WHERE Idx='"& IntIdx &"' "
		RunSQL(SQL1)
		SQL2 = "UPDATE Member_TB Set Point=Point+"& Cash &" WHERE Id='"& strId &"'"
		RunSQL(SQL2)
		Call CloseDB()
		Call descMentPage("충전 되었습니다.","self.close();","opener.location.reload()")
	End If
%>
<body style="margin:0">
	<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[충전하기]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<form name=frms method=post action="Cash.asp" onsubmit="return DefaultFormValidation(this)">
					<input type=HIDDEN name=Idx value="<%=IntIdx%>">
					<input type=HIDDEN name=Id value="<%=strId%>">
					<input type=HIDDEN name=flag value="SEND">
					<TR  height=35>
						<TD bgcolor="#e0e0e0" width=100>회원아이디</TD>
						<TD bgcolor="#FFFFFF">[<%=strId%>] <%=strName%></TD>
					</TR>
					<TR height=35>
						<TD bgcolor="#e0e0e0">충전금액</TD>
						<TD bgcolor="#FFFFFF">
							<input name="cash" size="17" type="text" value="<%=Cash%>" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)" Information="Required" title="충전금액" class=input5>&nbsp;<font color="#FD0000">"," 없이 숫자만 입력 하세요
						</TD>
					</TR>
				</TABLE>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" >

					<TR>
						<TD colspan=10 align=center> 
						<input type=submit value="충전하기"  id=submit1 name=submit1>
						<input type=button value="닫 기" onclick="window.self.close();" id=button1 name=button1></TD>
					</TR>
					</form>
				</TABLE>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
