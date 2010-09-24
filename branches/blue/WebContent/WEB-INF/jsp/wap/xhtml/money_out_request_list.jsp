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
    <title>?환전내역?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?환전내역?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>신청날짜</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyOut.getReqDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>계좌번호</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div>[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>환전금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(moneyOut.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>상태</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(moneyOut.getStatus())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>환전날짜</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyOut.getProcDateStr()%></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
}
%>
        <do type="vnd.up" label="상위"><go href="main.wap?token=<%=token%>"/></do>
    </body>
</html>

