<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="org.apache.commons.lang.*" %>
<%
	Member member = (Member) request.getAttribute("member");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
<%=member.getNickName()%>님 환영합니다!<br>
<%
String pin = member.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
PIN 번호를 입력하시고 전송을 눌러주세요
<form name="pinCheck" action="login.wap">
<input name="pin" type="password" value=""/>
<input type="submit" value="전송"/>
</form>
<%}  else {%>
모바일서비스를 이용하시려면 홈페이지 '정보수정' 에서 '모바일PIN번호' 6자리를 등록하셔야 합니다.
<%} %>
</body>
</html>