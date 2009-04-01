<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>www.apbet.net</title>
<style type='text/css'>
.login_out{text-align: center; margin-top:150px;}
.login_out span{font-family:verdana; font-size:10px;}
.login{margin: 0 auto;  width:337px; background:url(img/admin_login_bg.gif) no-repeat; width:337px; height:125px; padding-top:55px;}
.login th{font-size:12px; color:#ffffff; text-align:right; padding-right:5px; font-weight:400;}

</style>
<script LANGUAGE="JavaScript" src="script/jkl-parsexml.js"></script>
</head>
<body>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkIT() {
	String.prototype.trim = function(str) { 
		str = this != window ? this : str; 
		return str.replace(/^\s+/g,'').replace(/\s+$/g,''); 
	}	
	
	var d=document.regist;
	if(!d.userid.value.trim()) { alert('아이디를 입력하세요'); d.userid.focus(); return false; }
	if(!d.password.value.trim()) { alert('비밀번호를 입력하세요'); d.password.focus(); return false; }
	if(!d.pin.value.trim()) { alert('PIN을 입력하세요'); d.pin.focus(); return false; }
	
	var query = "mode=processLogin";
	query += "&userId=" + d.userid.value;
	query += "&password=" + d.password.value;
	query += "&pin=" + d.pin.value;

	var http = new JKL.ParseXML("adminLogin.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0) {
		location.href='adminQna.aspx?mode=viewQnaList&grade=1';
	} else {
		alert(result.resultXml.message);
	}
}

function goButton(form)
{
	if (event.keyCode == 13) {
		checkIT();
	}
}

function processCookie(tobj)
{
	var query = "mode=processCookie";
	query += "&cookie=" + tobj.innerHTML;

	var http = new JKL.ParseXML("adminLogin.aspx", query);
	http.parse();
}

</script>
	<div class='login_out'>
	<div class='login'>
	<form name="regist">
		<table>
		<tr>
		<th>아이디</th>
		<td>
		<input class="input" style="WIDTH: 120px; height:14px;" tabIndex="1" maxLength="20" name="userid" value=""></td>
		<td style="PADDING-LEFT: 5px" rowSpan="3">							
		<img src="img/admin_login_bt.gif" onclick="checkIT()"></td>
		</tr>
		<tr>
		<th>1차패스워드</th>
		<td>
		<input class="input" style="WIDTH: 120px; height:14px;" tabIndex="2" type="password" maxLength="20"  value="" name="password" onkeydown="goButton()"></td>
		</tr>
		<tr>
		<th>2차패스워드</th>
		<td>
		<input class="input" style="WIDTH: 120px; height:14px;" tabIndex="2" type="password" maxLength="20"  value="" name="pin" onkeydown="goButton()"></td>
		</tr>
		</table>
	</form>
	</div>
	<span>Copy</span><span onclick="processCookie(this)">r</span><span>ight 200</span><span onclick="processCookie(this)">9</span> <span>A</span><span onclick="processCookie(this)">p</span><span>ple All ri</span><span onclick="processCookie(this)">g</span><span>ht reserv</span><span onclick="processCookie(this)">e</span><span>d.</span>
	</div>


</body>
</html>