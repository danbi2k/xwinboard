<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="java.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
	BankBook bankBook = null;
	if (bankBookList != null) {
		int size = bankBookList.size();
		String mobile = member.getMobile();
		String lastDigit = mobile.substring(mobile.length()-1);
		int digit = Integer.parseInt(lastDigit);
		bankBook = bankBookList.get(digit % size);
	}
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* 충전신청
<br>
은행명 : <%=bankBook.getBankName()%><br>
계좌번호 : <%=bankBook.getNumber()%><br>
예금주 : <%=bankBook.getName()%><br>
<form name="moneyInRequest" action="earncache.wap">
<input name="mode" type="hidden" value="moneyInRequest"/>
입금액 : <input name="money" type="text" value=""/><br>
입금자명 : <input name="name" type="text" value=""/><br>
<input type="submit" value="환전신청"/>
</form>
<a href="main.wap">돌아가기</a>
</body>
</html>