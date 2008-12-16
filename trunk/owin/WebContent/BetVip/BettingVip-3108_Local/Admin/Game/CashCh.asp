
<!--	#include virtual="/Admin/top.asp"					-->
<%
	strId	= Request("Id")
	IntIdx	= Request("Idx")
	Cash	= replace(Request("Cash"),",","")
	strName	= Request("Name")
	flag	= Request("flag")
	flags	= Request("flags")
	
	If flags ="SEND" Then
		Call MileageChange(strId, Cash, flag)
		Call descment("적용 되었습니다.","close","")
	End If
%>
<script>
	function frmsSubmit() {
		if(!frms.flag[0].checked && !frms.flag[1].checked ) {
			alert('구분을 선택해 주세요');
			return false;
		}else if(frms.cash.value=="") {
			alert('금액을 입력해 주세요');
			return false;
		}
	}
</script>
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
						<td><font color="#ffffff" size="4"><b>[베팅머니 적용하기]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<form name=frms method=post action="CashCh.asp" onsubmit="return frmsSubmit()">
					<input type=HIDDEN name=Idx value="<%=IntIdx%>">
					<input type=HIDDEN name=Id value="<%=strId%>">
					<input type=HIDDEN name=flags value="SEND">
					<TR  height=35>
						<TD bgcolor="#e0e0e0" width=100>회원아이디</TD>
						<TD bgcolor="#FFFFFF">[<%=strId%>] <%=strName%></TD>
					</TR>
					<TR height=35>
						<TD bgcolor="#e0e0e0">구분</TD>
						<TD bgcolor="#FFFFFF">
							<input type="radio" name=flag value="2" > +
							<input type="radio" name=flag value="3" > -
						</TD>
					</TR>
					<TR height=35>
						<TD bgcolor="#e0e0e0">금액</TD>
						<TD bgcolor="#FFFFFF">
							<input name="cash" size="17" type="text" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)" OnKeydown="onlyNumber();" Information="Required" title="충전금액" class=input5>&nbsp;<font color="#FD0000">"," 없이 숫자만 입력 하세요
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
						<input type=submit value="적 용"  id=submit1 name=submit1>
						<input type=button value="닫 기" onclick="window.self.close();" id=button1 name=button1></TD>
					</TR>
					</form>
				</TABLE>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
