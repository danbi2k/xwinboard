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
<a href="play.wap?mode=viewGameList&type=wdl">승무패</a>&nbsp;
<a href="play.wap?mode=viewGameList&type=handy">핸디캡</a>&nbsp;
<a href="betlog.wap?mode=viewMyBettingList">배팅내역</a><br>
<a href="sendcache.wap?mode=viewMoneyOutRequest">환전신청</a>&nbsp;
<a href="sendcache.wap?mode=viewMoneyOutRequestList">환전신청내역</a><br>
<a href="earncache.wap?mode=viewMoneyInRequest">충전신청</a>&nbsp;
<a href="earncache.wap?mode=viewMoneyInRequestList">충전신청내역</a><br>
</body>
</html>