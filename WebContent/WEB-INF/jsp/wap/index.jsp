<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<%
	String nickName = (String) request.getAttribute("nickName");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
<%=nickName%>님 환영합니다!<br>
PIN 번호를 입력하시고 전송을 눌러주세요
<form name="pinCheck" action="login.wap">
<input name="pin" type="password" value=""/>
<input type="submit" value="전송"/>
</form>
</body>
</html>