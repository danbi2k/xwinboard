<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/wml20.dtd">
<html>
    <head>
    <title>?배팅내역?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?배팅내역?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배팅일시</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배당율</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getRateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배팅금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>예상적중액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getExpect())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>적중액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div><a title="배팅상세" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&amp;token=<%=token%>">배팅내역상세</a></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
        <wml:do type="vnd.up" label="상위"><wml:go href="main.wap?token=<%=token%>"/></wml:do>
    </body>
</html>

