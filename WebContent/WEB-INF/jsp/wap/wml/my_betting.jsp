<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1" title="���ó���">
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
        <p mode="wrap">�����Ͻ�</p>
        <p mode="wrap"><%=betting.getDateStr()%></p>
        <p mode="wrap">�����</p>
        <p mode="wrap"><%=betting.getRateStr()%></p>
        <p mode="wrap">���ñݾ�</p>
        <p mode="wrap"><%=XwinUtil.comma3(betting.getMoney())%></p>
        <p mode="wrap">�������߾�</p>
        <p mode="wrap"><%=XwinUtil.comma3(betting.getExpect())%></p>
        <p mode="wrap">���߾�</p>
        <p mode="wrap"><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></p>
        <p mode="wrap"><a title="���û�" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&amp;token=<%=token%>">���ó�����</a></p>
<%
	}
} else {
	out.println("���� ������ �����ϴ�");
}
%>
        <do type="vnd.up" label="����"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>
