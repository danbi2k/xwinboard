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
    <title>【충전내역】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【충전내역】</center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>	
        <div>신청날짜</div>
        <div><%=moneyIn.getReqDateStr()%></div>
        <div>입금계좌</div>
        <div>[<%=moneyIn.getBankBook().getBankName()%>]&nbsp;<%=moneyIn.getBankBook().getNumber()%></div>
        <div>입금자</div>
        <div><%=moneyIn.getName()%></div>
        <div>입금액</div>
        <div><%=XwinUtil.comma3(moneyIn.getMoney())%></div>
        <div>상태</div>
        <div><%=Code.getValue(moneyIn.getStatus())%></div>
        <div>처리일시</div>
<%
if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
%>
        <div><a btn="확인" href="earncache.wap?mode=cancelMoneyInRequest&id=<%=moneyIn.getId()%>&token=<%=token%>">신청취소</a></div>
<%
} else {
	out.print(moneyIn.getProcDateStr());
}
%>
<%
	}
}
%>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

