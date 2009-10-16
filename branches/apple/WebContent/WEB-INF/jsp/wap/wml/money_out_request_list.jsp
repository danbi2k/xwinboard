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
    <card id ="card1" title="환전내역">
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
        <p mode="wrap">신청날짜</p>
        <p mode="wrap"><%=moneyOut.getReqDateStr()%></p>
        <p mode="wrap">계좌번호</p>
        <p mode="wrap">[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></p>
        <p mode="wrap">환전금액</p>
        <p mode="wrap"><%=XwinUtil.comma3(moneyOut.getMoney())%></p>
        <p mode="wrap">상태</p>
        <p mode="wrap"><%=Code.getValue(moneyOut.getStatus())%></p>
        <p mode="wrap">환전날짜</p>
        <p mode="wrap"><%=moneyOut.getProcDateStr()%></p>
<%
	}
}
%>
        <do type="vnd.up" label="상위"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

