<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//PHONE.COM//DTD WML 1.1//EN" "http://www.phone.com/dtd/wml11.dtd">
<!--Web Logic ���������� �ѱ��� �����ٸ� DOCTYPE ������ ������ ������.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="wrap">&lt;��������&gt;</p>
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>	
        <p mode="wrap">��û��¥</p>
        <p mode="wrap"><%=moneyIn.getReqDateStr()%></p>
        <p mode="wrap">�Աݰ���</p>
        <p mode="wrap">[<%=moneyIn.getBankBook().getBankName()%>]&nbsp;<%=moneyIn.getBankBook().getNumber()%></p>
        <p mode="wrap">�Ա���</p>
        <p mode="wrap"><%=moneyIn.getName()%></p>
        <p mode="wrap">�Աݾ�</p>
        <p mode="wrap"><%=XwinUtil.comma3(moneyIn.getMoney())%></p>
        <p mode="wrap">����</p>
        <p mode="wrap"><%=Code.getValue(moneyIn.getStatus())%></p>
        <p mode="wrap">ó���Ͻ�</p>
<%
if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
%>
        <p mode="wrap"><a title="Ȯ��" href="earncache.wap?mode=cancelMoneyInRequest&id=<%=moneyIn.getId()%>&amp;token=<%=token%>">��û���</a></p>
<%
} else {
	out.print(moneyIn.getProcDateStr());
}
%>
<%
	}
}
%>
        <do type="options" label="����"><go href="main.wap?token=<%=token%>"/></do>
        <do type="accept" label="Ȯ��" name="VX"><go href=""/></do>
    </card>
</wml>

