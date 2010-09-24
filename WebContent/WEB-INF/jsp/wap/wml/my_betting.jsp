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
    <card id ="card1" title="배팅내역">
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
        <p mode="wrap">배팅일시</p>
        <p mode="wrap"><%=betting.getDateStr()%></p>
        <p mode="wrap">배당율</p>
        <p mode="wrap"><%=betting.getRateStr()%></p>
        <p mode="wrap">배팅금액</p>
        <p mode="wrap"><%=XwinUtil.comma3(betting.getMoney())%></p>
        <p mode="wrap">예상적중액</p>
        <p mode="wrap"><%=XwinUtil.comma3(betting.getExpect())%></p>
        <p mode="wrap">적중액</p>
        <p mode="wrap"><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></p>
        <p mode="wrap"><a title="배팅상세" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&amp;token=<%=token%>">배팅내역상세</a></p>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
        <do type="vnd.up" label="상위"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

