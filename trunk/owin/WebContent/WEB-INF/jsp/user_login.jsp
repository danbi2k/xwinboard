<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<html>
<head>
<title>ODD</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="style/style.css" rel="stylesheet" type="text/css">
	<link href="style/default.css" rel="stylesheet" type="text/css">
	<script LANGUAGE="JavaScript" src="script/jkl-parsexml.js"></script>
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkIT() {
	var d=document.regist;
	if(!d.userId.value) { alert('아이디를 입력하세요'); d.userId.focus(); return false; }
	if(!d.password.value) { alert('비밀번호를 입력하세요'); d.password.focus(); return false; }
	
	var query = "mode=processLogin";
	query += "&userId=" + d.userId.value;
	query += "&password=" + d.password.value;
	
	var http = new JKL.ParseXML("login.php", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);	
		return;
	}
	
	location.href = "home.php";
}

function goButton(form)
{
	if (event.keyCode == 13) {
		checkIT();
	}
}


	
//-->
</SCRIPT>

<BODY onload="document.regist.userId.focus()" style="margin:0" bgcolor=000000 oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >
	<form method='post' name='regist'">
	<table border="0" cellpadding="0" cellspacing="0" height="27" width=100% >		
		<tr>
			<td height=600 >
				<table border="0" cellpadding="0" cellspacing="0" height="27" width=100% >
					<tr><td height=2 bgcolor="424142"></td></tr>
					<tr>
						<td height=100 bgcolor="212021">
							<table align=center border="0" cellpadding="0" cellspacing="0" height="27" >
								
								<tr>
									<td align=right><font color=D2D2D2><b>ID : </td>
									<td>&nbsp;<input type=text size=15 tabindex=1 size=10 class=input14 name="userId" Information="Required" MaxBytes="15" title="아이디" ></td>
									<td rowspan=2><input tabindex=3 type=button onclick="checkIT()" class=btn6 value=LOGIN style="width:50;height:45"></td>
								</tr>
								<tr>	
									<td align=right><font color=D2D2D2><b>PWD : </td>
									<td>&nbsp;<input type=password size=15 tabindex=2 class=input14 name="password" Information="Required" MaxBytes="15" title="비밀번호" ></td>
								</tr>
								<tr><td height=10></td></tr>
								<tr>
									<td colspan=3 align=center>
										<input tabindex=3 type=button class=btn10 value=아이디/비번찾기 style="width:195;" onclick="">
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

<SCRIPT LANGUAGE="JavaScript">
<!--
if((regist.userId.value != "") && (regist.password.value != "")){
		document.getElementById("login_bttn").click();
}
//-->
</SCRIPT>