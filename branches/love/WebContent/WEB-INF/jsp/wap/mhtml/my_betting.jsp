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
    <title>�����ó�����</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>�����ó�����</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
        <div>�����Ͻ�</div>
        <div><%=betting.getDateStr()%></div>
        <div>�����</div>
        <div><%=betting.getRateStr()%></div>
        <div>���ñݾ�</div>
        <div><%=XwinUtil.comma3(betting.getMoney())%></div>
        <div>�������߾�</div>
        <div><%=XwinUtil.comma3(betting.getExpect())%></div>
        <div>���߾�</div>
        <div><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
        <div><a btn="���û�" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&token=<%=token%>">���ó�����</a></div>
<%
	}
} else {
	out.println("���� ������ �����ϴ�");
}
%>
        <btn name="����" href="main.wap?token=<%=token%>">
    </body>
</html>

