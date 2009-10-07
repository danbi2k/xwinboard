<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* 배팅내역<br>
* 최근 10개 만 보입니다.
<br><br>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
배팅일시 : <%=betting.getDateStr()%><br>
배당율 : <%=betting.getRateStr()%><br>
배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%><br>
예상적중금액 : <%=XwinUtil.comma3(betting.getExpect())%><br>
적중금액 :
<%
if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
	out.print(XwinUtil.comma3(betting.getExpect()));
else
	out.print(0);							
%>
<br>
<a href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>">상세보기</a><br><br>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
<br>
<br>
<a href="main.wap">돌아가기</a>
</body>
</html>