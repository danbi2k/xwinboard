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
    <title>【배팅내역】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【배팅내역】</center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
        <div>배팅일시</div>
        <div><%=betting.getDateStr()%></div>
        <div>배당율</div>
        <div><%=betting.getRateStr()%></div>
        <div>배팅금액</div>
        <div><%=XwinUtil.comma3(betting.getMoney())%></div>
        <div>예상적중액</div>
        <div><%=XwinUtil.comma3(betting.getExpect())%></div>
        <div>적중액</div>
        <div><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
        <div><a btn="배팅상세" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&token=<%=token%>">배팅내역상세</a></div>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

