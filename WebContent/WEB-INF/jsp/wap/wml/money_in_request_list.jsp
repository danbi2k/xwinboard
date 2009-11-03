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
    <card id ="card1" title="충전내역">
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>	
        <p mode="wrap">신청날짜</p>
        <p mode="wrap"><%=moneyIn.getReqDateStr()%></p>
        <p mode="wrap">입금계좌</p>
        <p mode="wrap">[<%=moneyIn.getBankBook().getBankName()%>]&nbsp;<%=moneyIn.getBankBook().getNumber()%></p>
        <p mode="wrap">입금자</p>
        <p mode="wrap"><%=moneyIn.getName()%></p>
        <p mode="wrap">입금액</p>
        <p mode="wrap"><%=XwinUtil.comma3(moneyIn.getMoney())%></p>
        <p mode="wrap">상태</p>
        <p mode="wrap"><%=Code.getValue(moneyIn.getStatus())%></p>
        <p mode="wrap">처리일시</p>
<%
if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
%>
        <p mode="wrap"><a title="확인" href="earncache.wap?mode=cancelMoneyInRequest&id=<%=moneyIn.getId()%>&amp;token=<%=token%>">신청취소</a></p>
<%
} else {
	out.print(moneyIn.getProcDateStr());
}
%>
<%
	}
}
%>
        <do type="vnd.up" label="상위"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

