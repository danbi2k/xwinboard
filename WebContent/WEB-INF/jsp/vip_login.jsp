<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.*" %>    
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<html>
<head>
<title>환영합니다</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script language="javascript" src="script/mEmbed.js"></script>
<script language="javascript" src="script/jkl-parsexml.js"></script>
<link rel="stylesheet" type="text/css" href="style/style.css">
</head>

<body bgcolor="#ffffff" topmargin="300" leftmargin="0" marginwidth='0' marginheight='0'style="background:url(images/main/intro_bg.gif) no-repeat center top;">
<form name="regist">
  <table width="334" height="131" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:30px;">
    <tr>
      <td height="131" background="images/main/intro_login_bg.gif"><table width="100%" height="107" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="70%" valign="top" style="padding-top:35px;"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="30%">&nbsp;</td>
                  <td width="72%"><input style="width:100pt;font-family:verdana;font-size:9pt;border:solid 0; color:#1a1a1a;background-color:transparent;" name="userId" type="text" id="m_id"></td>
                </tr>
              </table>
              <table width="100%" height="24" border="0" cellpadding="0" cellspacing="0" style="margin-top:12px;">
                <tr>
                  <td width="30%">&nbsp;</td>
                  <td width="70%"><input style="width:100pt;font-family:verdana;font-size:9pt;border:solid 0; color:#1a1a1a;background-color:transparent;" name="password" type="password" id="m_passwd" onKeyDown="goButton()"></td>
                </tr>
              </table></td>
            <td width="30%" valign="top" style="padding-top:36px;"><img src="images/main/intro_go_bt.gif"onClick="checkIT()"  id="login_bttn" ></td>
          </tr>
      </table></td>
    </tr>
  </table>
  <div align="center"><a href="userform.php?mode=viewJoin<%=SiteConfig.SITE_GRADE.equals(Code.USER_GRADE_VIP)?"Login":""%>Form"><img src="images/main/intro_member_bt.gif" style="margin-top:15px;" border="0"></a></div> 
</form>
</body>
</html>


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

if((regist.userId.value != "") && (regist.password.value != "")){
		document.getElementById("login_bttn").click();
}
//-->
</SCRIPT>