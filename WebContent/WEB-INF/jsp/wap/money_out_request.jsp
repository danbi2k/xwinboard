<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* 환전신청
<br>
<form name="moneyOutRequest" action="sendcache.wap">
<input name="mode" type="hidden" value="moneyOutRequest"/>
환전신청액 : <input name="money" type="text" value=""/><br>
PIN번호 : <input name="pin" type="password" value=""/><br>
<input type="submit" value="환전신청"/>
</form>
<a href="main.wap">돌아가기</a>
</body>
</html>