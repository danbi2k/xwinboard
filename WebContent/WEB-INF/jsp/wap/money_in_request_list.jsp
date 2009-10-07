<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* 충전신청내역<br>
* 최근 5개 만 보입니다.
<br><br>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>
	<table border=1>
		<tr>
			<td>신청일자</td>
			<td><%=moneyIn.getReqDateStr()%></td>
		</tr>
		<tr>
			<td>입금계좌</td>
			<td>[<%=moneyIn.getBankName()%>] <%=moneyIn.getNumber()%> <%=moneyIn.getName()%></td>
		</tr>
		<tr>
			<td>입금자</td>
			<td><%=moneyIn.getName()%></td>
		</tr>
		<tr>
			<td>입금액</td>
			<td><%=XwinUtil.comma3(moneyIn.getMoney())%></td>
		</tr>
		<tr>
			<td>상태</td>
			<td><%=Code.getValue(moneyIn.getStatus())%></td>
		</tr>
		<tr>
			<td>처리일시</td>
			<td><%=moneyIn.getProcDateStr()%></td>
		</tr>
		<tr>
			<td>취소</td>
			<td></td>
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