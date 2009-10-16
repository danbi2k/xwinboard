<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<html>
    <head>
    <title>【충전신청】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【충전신청】</center></div>
<%	
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
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
            <div><input type="hidden" name="mode" value="moneyInRequest" /></div>
            <div><input type="hidden" name="bankBookId" value="<%=bankBook.getId()%>" /></div>
        <div>은행명 :&nbsp;<%=bankBook.getBankName()%></div>
        <div>계좌번호 :&nbsp;<%=bankBook.getNumber()%></div>
        <div>예금주 :&nbsp;<%=bankBook.getName()%></div>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

