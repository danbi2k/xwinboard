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
    <card id ="card1" title="ȯ������">
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
        <p mode="wrap">��û��¥</p>
        <p mode="wrap"><%=moneyOut.getReqDateStr()%></p>
        <p mode="wrap">���¹�ȣ</p>
        <p mode="wrap">[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></p>
        <p mode="wrap">ȯ���ݾ�</p>
        <p mode="wrap"><%=XwinUtil.comma3(moneyOut.getMoney())%></p>
        <p mode="wrap">����</p>
        <p mode="wrap"><%=Code.getValue(moneyOut.getStatus())%></p>
        <p mode="wrap">ȯ����¥</p>
        <p mode="wrap"><%=moneyOut.getProcDateStr()%></p>
<%
	}
}
%>
        <do type="vnd.up" label="����"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

