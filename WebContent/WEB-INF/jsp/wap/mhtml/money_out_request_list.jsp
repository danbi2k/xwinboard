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
    <title>【환전내역】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【환전내역】</center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
        <div>신청날짜</div>
        <div><%=moneyOut.getReqDateStr()%></div>
        <div>계좌번호</div>
        <div>[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></div>
        <div>환전금액</div>
        <div><%=XwinUtil.comma3(moneyOut.getMoney())%></div>
        <div>상태</div>
        <div><%=Code.getValue(moneyOut.getStatus())%></div>
        <div>환전날짜</div>
        <div><%=moneyOut.getProcDateStr()%></div>
<%
	}
}
%>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

