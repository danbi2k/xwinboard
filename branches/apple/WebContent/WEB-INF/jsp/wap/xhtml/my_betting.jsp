<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.w3.org/TR/XHTML-basic/XHTML-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>?���ó���?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?���ó���?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
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
                    <div>�����Ͻ�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>�����</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getRateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>���ñݾ�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>�������߾�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getExpect())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>���߾�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div><a title="���û�" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&token=<%=token%>">���ó�����</a></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
} else {
	out.println("���� ������ �����ϴ�");
}
%>
        <do type="vnd.up" label="����"><go href="main.wap?token=<%=token%>"/></do>
    </body>
</html>

