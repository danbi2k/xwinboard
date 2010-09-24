<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>


<html>
<head>
<title>환영합니다</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="stylesheet" type="text/css" href="style/style.css">
	<script language="javascript" src="script/mEmbed.js"></script>
	<script LANGUAGE="JavaScript" src="script/jkl-parsexml.js"></script>
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkIT() {
	var d=document.regist;
	if(!d.inviteKey.value) { alert('초대장번호를 입력하세요'); d.inviteKey.focus(); return false; }
	if(!d.userId.value) { alert('초대해준 회원님의 아이디를 입력하세요'); d.userId.focus(); return false; }
	
	var query = "mode=processJoinLogin";
	query += "&inviteKey=" + d.inviteKey.value;
	query += "&userId=" + d.userId.value;
	
	var http = new JKL.ParseXML("userform.php", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);	
		return;
	}
	
	location.href = "userform.php?mode=viewJoinForm";
}

function goButton(form)
{
	if (event.keyCode == 13) {
		checkIT();
	}
}


	
//-->
</SCRIPT>

<body bgcolor="#ffffff" topmargin="300" leftmargin="0" marginwidth='0' marginheight='0'style="background:url(images/main/intro_bg.gif) no-repeat center top;">
<form name="regist">
  <table width="337" height="105" border="0" align="center" cellpadding="0" cellspacing="0" background="images/main/intro_login1_bg.gif">
  <tr>
    <td valign="top" style="padding-top:20px;"><table width="100%" height="65" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="68%" valign="top" style="padding-top:3px;padding-left:90px;">
		<table width="72%" border="0" cellspacing="0" cellpadding="0" style="margin-top:3px;">
          <tr>
            <td><input style="width:85pt;" name="inviteKey" type="text" class="input1" id="m_passwd"></td>
          </tr>
        </table>
          <table width="72%" border="0" cellspacing="0" cellpadding="0" style="margin-top:16px;">
            <tr>
              <td><input style="width:85pt;" name="userId" type="text" class="input1" id="m_id"></td>
            </tr>
          </table></td>
        <td width="32%"><img src="images/main/intro_go1_bt.gif" name="login_bttn"  id="login_bttn" onClick="checkIT()"></td>
      </tr>
    </table></td>
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