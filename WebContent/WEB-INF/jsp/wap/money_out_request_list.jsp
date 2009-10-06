<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* 환전신청내역<br>
* 최근 3개 만 보입니다.
<br><br>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
	<table border=1>
		<tr>
			<td>신청날짜</td>
			<td><%=moneyOut.getReqDateStr()%></td>
		</tr>
		<tr>
			<td>계좌번호</td>
			<td>[<%=moneyOut.getBankName()%>] <%=moneyOut.getNumber()%> <%=moneyOut.getName()%></td>
		</tr>
		<tr>
			<td>환전금액</td>
			<td><%=XwinUtil.comma3(moneyOut.getMoney())%></td>
		</tr>
		<tr>
			<td>상태</td>
			<td><%=Code.getValue(moneyOut.getStatus())%></td>
		</tr>
		<tr>
			<td>환전날짜</td>
			<td><%=moneyOut.getProcDateStr()%></td>
		</tr>
	</table>
	<br><br>
<%
	}
} else {
	out.println("환전신청 내역이 없습니다");
}
%>
<br>
<br>
<a href="main.wap">돌아가기</a>
</body>
</html>