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
	if(!d.inviteKey.value) { alert('추천장을 입력하세요'); d.inviteKey.focus(); return false; }
	if(!d.userId.value) { alert('소개인ID를 입력하세요'); d.userId.focus(); return false; }
	
	var query = "mode=processJoinLogin";
	query += "&inviteKey=" + d.inviteKey.value;
	query += "&userId=" + d.userId.value;
	
	var http = new JKL.ParseXML("join.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);	
		return;
	}
	
	location.href = "join.aspx?mode=viewJoinForm";
}

function goButton(form)
{
	if (event.keyCode == 13) {
		checkIT();
	}
}


	
//-->
</SCRIPT>

<body onLoad="document.regist.inviteKey.focus()" bgcolor="#446677">
	<form method='post' name='regist'">
	<table height="100%" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0" id="table1">
		<tr>
			<td align="center" valign="top"  style="padding-top:100px">
			<table style="BORDER-RIGHT: #000000 5px solid; BORDER-TOP: #000000 5px solid; BORDER-LEFT: #000000 5px solid; BORDER-BOTTOM: #000000 5px solid" height="250" cellSpacing="0" cellPadding="0" width="480" bgColor="#d9d8d6" id="table2">
				<tr>
					<td style="PADDING-LEFT: 20px; FONT: bold 20pt verdana; COLOR: #ffffff" bgColor="#000000" height="70" align="center">
					추천장등록</td>
				</tr>
				<tr>
					<td valign="center" align="middle">
					<table cellSpacing="0" cellPadding="0" border="0" id="table3">
						<tr>
							<td>추천장</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="1" name="inviteKey" value=""></td>
							<td style="PADDING-LEFT: 5px" rowSpan="2">							
							<img src="images/admin/btn_login.gif" onclick="checkIT()" width="56" border="0" style="width:56px;height:41px" ID="login_bttn"></td>
						</tr>
						<tr>
							<td>소개인ID</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="2" type="text" maxLength="20"  value="" name="userId" onkeydown="goButton()"></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="480" border="0" id="table4" height="40">
				<tr>
					<td align="center"><font color="#ffffff">문의 : <%=Admin.ADMIN_EMAIL%></font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</form>
</body>
</html>

<SCRIPT LANGUAGE="JavaScript">
<!--
if((regist.inviteKey.value != "") && (regist.userId.value != "")){
		document.getElementById("login_bttn").click();
}
//-->
</SCRIPT>