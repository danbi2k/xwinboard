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

<body topmargin="0" leftmargin="0" marginwidth='0' marginheight='0'>
<form name="regist">
<table cellpadding="0" cellspacing="0" width="1024" height="768" background="img/invi.jpg" style="background-repeat:no-repeat;" align="center">
    <tr>
        <td width="122" height="230">
            <p>&nbsp;</p>
        </td>
        <td width="575" height="230" colspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="204" height="230">
            <p>&nbsp;</p>
        </td>
 
       
        <td width="123"></td>
    </tr>
    <tr>
        <td width="122" height="72" rowspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="306" height="26">
            <p></p>
        </td>
        <td width="191" height="26">
            <p><input name="inviteKey" type="text" id="m_passwd"></p>
        </td>
        <td width="78" height="72" rowspan="3" align="center" valign="top">
            <p><input type="button" value="등록" onclick="checkIT()"></p>
        </td>
        <td width="204" height="72" rowspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="123" height="26"></td>
    </tr>
    <tr>
        <td width="306" height="26">
            <p>&nbsp;</p>
        </td>
        <td width="191" height="26">
            <p><input name="userId" type="text" id="m_id"></p>
        </td>
        <td width="123" height="26"></td>
    </tr>

    <tr>
        <td width="306" height="242" rowspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="473" height="14" colspan="3">
            <p>&nbsp;</p>
        </td>
        <td width="123" height="242" rowspan="3">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="122" height="242" rowspan="2">
            <p>&nbsp;</p>
        </td>
        <td width="473" height="34" colspan="3">
           <p>문의 : <%=Admin.ADMIN_EMAIL%></p>
        </td>
    </tr>

    <tr>
        <td width="473" height="208" colspan="3">
            <p>&nbsp;</p>
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