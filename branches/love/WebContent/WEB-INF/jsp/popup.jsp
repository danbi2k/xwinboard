<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="style/style.css">
</head>
<body>
<table align="center" width="100%" cellpadding="0" cellspacing="0" style="margin-top:7px;">
<tr align="center">
<td width="10"></td>
<td width="*" background="images/title_bg.gif"><b style="color:white">공지사항</td>
<td width="10"></td>
</tr>
</table>

<table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #4a4a4a;">
<tr height="100%" valign="top"><td style="padding:13px;" bgcolor="#555555" style="color:black;">
<span style="width:100%;height:490;OVERFLOW:auto">
    <%
    String context = Admin.POPUP;
    context = StringEscapeUtils.escapeHtml(context);
    context = context.replaceAll("\n", "<br>");
    out.print(context);
    %>
</span>
</td></tr>
<tr><td bgcolor="#525252">
    <table width="100%" style="color:#8b8b8b;">
    <tr>
        <td width="50%"><b style="color:black">작성자 : <b>관리자</b></td>
        <td width="50%" align="right"><b style="color:black">
			오늘하루이창을열지않음 <input type="checkbox" id="popupcheck">
			닫기 <img src="img/x.gif" onclick="popupclose()">	
		</td>
    </tr></table>
</td></tr>
</table>
&nbsp;
</div>

<script>
function popupclose()
{
	var popupcheck = document.getElementById("popupcheck");
	if (popupcheck.checked) {
		setCookie("COOKIEFLAG", "N", 1);
	}
	window.close();
}

function setCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
</script>
</body>
</html>