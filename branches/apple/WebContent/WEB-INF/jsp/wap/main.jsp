<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
닉네임 : <%=member.getNickName()%>님<br>
잔고 : <%=XwinUtil.comma3(member.getBalance())%>
<br>
<br>
<br>
<a href="sendcache.wap?mode=viewMoneyOutRequest">환전신청</a><br>
<a href="sendcache.wap?mode=viewMoneyOutRequestList">환전신청내역</a><br>
<a href="betlog.wap">배팅내역</a>
</body>
</html>