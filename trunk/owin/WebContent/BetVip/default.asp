<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%
	If Not isNone(Session("UId")) Then Call descment("","/index.asp","")
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<META http-equiv="Pragma" content="no-cache">
<link href="/common/css/style.css" rel="stylesheet" type="text/css">
<link href="/common/css/default.css" rel="stylesheet" type="text/css">
<script language=javascript src="/js/common.js"></script>
<script language=javascript src="/common/js/common.js"></script>
<title>ODD</title>
</HEAD>
<BODY onload="rfrms.fid.focus();" style="margin:0" bgcolor=000000 oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >
	<table border="0" cellpadding="0" cellspacing="0" height="27" width=100% >
		
		<tr>
			<td height=600 >
				<table border="0" cellpadding="0" cellspacing="0" height="27" width=100% >
					<tr><td height=2 bgcolor="424142"></td></tr>
					<tr>
						<td height=100 bgcolor="212021">
							<table align=center border="0" cellpadding="0" cellspacing="0" height="27" >
								<form name=rfrms method=post action="/member/login_Prc.asp" onsubmit="return DefaultFormValidation(this);" >
								<tr>
									<td align=right><font color=D2D2D2><b>ID : </td>
									<td>&nbsp;<input type=text size=15 tabindex=1 size=10 class=input14 name="fid" Information="Required" MaxBytes="15" title="아이디" ></td>
									<td rowspan=2><input tabindex=3 type=submit class=btn6 value=LOGIN style="width:50;height:45"></td>
								</tr>
								<tr>	
									<td align=right><font color=D2D2D2><b>PWD : </td>
									<td>&nbsp;<input type=password size=15 tabindex=2 class=input14 name="fpwd" Information="Required" MaxBytes="15" title="비밀번호" ></td>
								</tr>
								<tr><td height=10></td></tr>
								<tr>
									<td colspan=3 align=center>
										<input tabindex=3 type=button class=btn10 value=아이디/비번찾기 style="width:195;" onclick="MM_winopen('FindIdPwd.asp','FDP','width=450,height=230');">
									</td>
								</form>
							</table>
						</td>
					</tr>
					<tr><td height=1 bgcolor="424142"></td></tr>
				</table>
			</td>
		</tr>
		
	</table>				
</body>
</html>