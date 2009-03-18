<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<html>
<head>
<title>환영합니다</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script language="javascript" src="script/mEmbed.js"></script>
<script language="javascript" src="script/jkl-parsexml.js"></script>
<link rel="stylesheet" type="text/css" href="style/style.css">
</head>
<body bgcolor="#000000" topmargin="0" leftmargin="0" marginwidth='0' marginheight='0'>
<form name="regist">
<table cellpadding="0" cellspacing="0" width="1024" height="768" background="img/index.jpg" style="background-repeat:no-repeat;" align="center">
    <tr>
        <td width="339" height="460">
            <p>&nbsp;</p>
        </td>
        <td width="370" height="460" colspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="315" height="460">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="339" height="77" rowspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="85" height="23">
            <p></p>
        </td>
        <td width="186" height="23">
            <p><input name="userId" type="text" class="input1" id="m_id"></p>
        </td>
        <td width="99" height="77" rowspan="3" align="center" valign="top">
            <p><img src="img/login.jpg" border="0" align="abstop" id="login_bttn" onclick="checkIT()"></p>
        </td>
        <td width="315" height="77" rowspan="3">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="85" height="32">
            <p>&nbsp;</p>
        </td>
        <td width="186" height="32">
            <p><input name="password" type="password" class="input1" id="m_passwd" onkeydown="goButton()"></p>
        </td>
    </tr>
    <tr>
        <td width="85" height="22">
            <p>&nbsp;</p>
        </td>
        <td width="186" height="22">
            <p><input name="pin" type="password" class="input1" id="m_passwd" onkeydown="goButton()"></p>
        </td>
    </tr>
    <tr>
        <td width="339" height="242" rowspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="370" height="14" colspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="315" height="242" rowspan="3">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="85" height="38">
            <p>&nbsp;</p>
        </td>
        <td width="186" height="38" align="center">
            <p><a href="join.aspx?mode=viewJoinLoginForm"><img src="img/entry.jpg" border="0"></a></p>
        </td>
        <td width="99" height="38">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="370" height="190" colspan="3">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
</form>
</body>
</html>


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

if((regist.userId.value != "") && (regist.password.value != "")){
		document.getElementById("login_bttn").click();
}
//-->
</SCRIPT>