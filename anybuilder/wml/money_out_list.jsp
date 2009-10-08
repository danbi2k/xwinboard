<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1" title="환전내역">
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
<%%>
        <do type="vnd.up" label="상위"><go href="index.jsp"/></do>
    </card>
</wml>

