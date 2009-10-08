<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
<html>
    <head>
    <title>【환전내역】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【환전내역】</center></div>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
닉네임 : <%=member.getNickName()%>님<br>
잔고 : <%=XwinUtil.comma3(member.getBalance())%>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%%>
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
<%%>
        <btn name="상위" href="index.jsp">
    </body>
</html>

