<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<html>
<head>
<title>환영합니다</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="stylesheet" href="style/admin.css">
	<script LANGUAGE="JavaScript" src="script/jkl-parsexml.js"></script>
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkIT() {
	var d=document.regist;
	if(!d.userId.value) { alert('아이디를 입력하세요'); d.userId.focus(); return false; }
	if(!d.password.value) { alert('비밀번호를 입력하세요'); d.password.focus(); return false; }
	if(!d.pin.value) { alert('환전비밀번호를 입력하세요'); d.pin.focus(); return false; }
	
	var query = "mode=processLogin";
	query += "&userId=" + d.userId.value;
	query += "&password=" + d.password.value;
	query += "&pin=" + d.pin.value;
	
	var http = new JKL.ParseXML("login.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);	
		return;
	}
	
	location.href = "home.aspx";
}

function goButton(form)
{
	if (event.keyCode == 13) {
		checkIT();
	}
}


	
//-->
</SCRIPT>

<body onLoad="document.regist.userId.focus()" bgcolor="#000000">
<img src="images/genesis.jpg" style="position:absolute;left:50%;top:70px;width:950px;margin-left:-470px;">
<div style="position:absolute;left:50%;top:400px;width:950px;z-index:1;margin-left:-470px;">
	<form method='post' name='regist'">
	<table height="100%" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0" id="table1">
		<tr>
			<td align="center" valign="top"  style="padding-top:100px">
			<table style="BORDER-RIGHT: #000000 2px solid; BORDER-TOP: #000000 2px solid; BORDER-LEFT: #000000 2px solid; BORDER-BOTTOM: #000000 2px solid" cellSpacing="0" height="80" cellPadding="0" width="280" bgColor="#d9d8d6" id="table2">
				<tr>
					<td valign="center" align="middle">
					<table cellSpacing="0" cellPadding="0" border="0" id="table3">
						<tr>
							<td>아이디</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="1" maxLength="20" name="userId" value=""></td>
							<td style="PADDING-LEFT: 5px" rowSpan="3">							
							<img src="images/admin/btn_login.gif" onclick="checkIT()" width="56" border="0" style="width:56px;height:61px" ID="login_bttn"></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="2" type="password" maxLength="20"  value="" name="password" onkeydown="goButton()"></td>
						</tr>
						<tr>
							<td>PIN번호</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="2" type="password" maxLength="20"  value="" name="pin" onkeydown="goButton()"></td>
						</tr>
						<tr><td></td></tr>
					</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="480" border="0" id="table4" height="40">
				<tr>
					<td align="center" height="30"><font color="#ffffff">문의 : <%=Admin.ADMIN_EMAIL%></font></td>

				</tr>
				<tr><td height="15"></td></tr>
				<tr>
					<td align="center"><font size="3" color="#ffffff"><B><a href="join.aspx?mode=viewJoinLoginForm">[추천장등록]</a></B></font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>

<SCRIPT LANGUAGE="JavaScript">
<!--
if((regist.userId.value != "") && (regist.password.value != "")){
		document.getElementById("login_bttn").click();
}
//-->
</SCRIPT>