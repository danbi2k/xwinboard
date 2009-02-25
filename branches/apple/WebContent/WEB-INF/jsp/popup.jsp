<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>애플벳</title>
<link href='style/default.css' rel='stylesheet' type='text/css'>
<script type="text/javascript"></script>
</head>
<body>
<div class='alert_notice'>
	<div class='alert_notice_top'></div>
	<div class='alert_notice_body'>
	<%
    String context = Admin.POPUP;
    context = StringEscapeUtils.escapeHtml(context);
    context = context.replaceAll("\n", "<br>");
    out.print(context);
    %>
	</div>
	<div class='alert_notice_bottom'>
		<div class='alert_notice_txt'>
		<input type="checkbox" id="popupcheck"> 오늘하루 이창 열지 않음
		<img src='img/alert_notice_close_bt.gif' alt='창닫기' class='img_bt ml5' onclick='popupclose()'>
		</div>
	</div>
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