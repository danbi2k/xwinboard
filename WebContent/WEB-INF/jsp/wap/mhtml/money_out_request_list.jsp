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
    <title>��ȯ��������</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>��ȯ��������</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
        <div>��û��¥</div>
        <div><%=moneyOut.getReqDateStr()%></div>
        <div>���¹�ȣ</div>
        <div>[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></div>
        <div>ȯ���ݾ�</div>
        <div><%=XwinUtil.comma3(moneyOut.getMoney())%></div>
        <div>����</div>
        <div><%=Code.getValue(moneyOut.getStatus())%></div>
        <div>ȯ����¥</div>
        <div><%=moneyOut.getProcDateStr()%></div>
<%
	}
}
%>
        <btn name="����" href="main.wap?token=<%=token%>">
    </body>
</html>

