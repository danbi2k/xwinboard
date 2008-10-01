<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>관리자인증</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="common/style.css" rel="stylesheet" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkIT() {
	String.prototype.trim = function(str) { 
		str = this != window ? this : str; 
		return str.replace(/^\s+/g,'').replace(/\s+$/g,''); 
	}	
	
	var d=document.regist;
	if(!d.userid.value.trim()) { alert('아이디를 입력하세요'); d.userid.focus(); return false; }
	if(!d.passwd.value.trim()) { alert('비밀번호를 입력하세요'); d.passwd.focus(); return false; }
	d.action='/admin_mode/login_exe.php';
}
	
//-->
</SCRIPT>

<body onLoad="document.regist.userid.focus()">

	<table height="100%" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0" id="table1">
		<tr>
			<td align="center" valign="top"  style="padding-top:100px">
			<table style="BORDER-RIGHT: #000000 5px solid; BORDER-TOP: #000000 5px solid; BORDER-LEFT: #000000 5px solid; BORDER-BOTTOM: #000000 5px solid" height="250" cellSpacing="0" cellPadding="0" width="480" bgColor="#d9d8d6" id="table2">
				<tr>
					<td style="PADDING-LEFT: 20px; FONT: bold 20pt verdana; COLOR: #ffffff" bgColor="#000000" height="70" align="center">
					Admin_Tool</td>
				</tr>
				<form method='post' name='regist' onSubmit="return checkIT()">
				<tr>
					<td vAlign="center" align="middle">
					<table cellSpacing="0" cellPadding="0" border="0" id="table3">
						<tr>
							<td>아이디</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="1" maxLength="20" name="userid" value=""></td>
							<td style="PADDING-LEFT: 5px" rowSpan="2">							
							<input type='image' height="41" src="image/btn_login.gif" width="56" border="0" style="width:56px;height:41px" ID="login_bttn"></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td style="PADDING-LEFT: 5px">
							<input class="input" style="WIDTH: 120px" tabIndex="2" type="password" maxLength="20"  value="" name="passwd"></td>
						</tr>
					</table>
					</td>
				</tr>
</form>
			</table>
			<table cellSpacing="0" cellPadding="0" width="480" border="0" id="table4" height="40">
				<tr>
					<td align="center">Copyright 2008 CASHBET24 All right 
					reserved.</td>
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
if((regist.userid.value != "") && (regist.passwd.value != "")){
		document.getElementById("login_bttn").click();
}
//-->
</SCRIPT>