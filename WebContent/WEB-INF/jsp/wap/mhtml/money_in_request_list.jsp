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
    <title>������������</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>������������</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>	
        <div>��û��¥</div>
        <div><%=moneyIn.getReqDateStr()%></div>
        <div>�Աݰ���</div>
        <div>[<%=moneyIn.getBankBook().getBankName()%>]&nbsp;<%=moneyIn.getBankBook().getNumber()%></div>
        <div>�Ա���</div>
        <div><%=moneyIn.getName()%></div>
        <div>�Աݾ�</div>
        <div><%=XwinUtil.comma3(moneyIn.getMoney())%></div>
        <div>����</div>
        <div><%=Code.getValue(moneyIn.getStatus())%></div>
        <div>ó���Ͻ�</div>
<%
if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
%>
        <div><a btn="Ȯ��" href="earncache.wap?mode=cancelMoneyInRequest&id=<%=moneyIn.getId()%>&token=<%=token%>">��û���</a></div>
<%
} else {
	out.print(moneyIn.getProcDateStr());
}
%>
<%
	}
}
%>
        <btn name="����" href="main.wap?token=<%=token%>">
    </body>
</html>

