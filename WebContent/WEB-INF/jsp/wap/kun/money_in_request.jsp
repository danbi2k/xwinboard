<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<% if (Integer.parseInt(lcdlx) >= 240) {
    response.setHeader("KTF-Page-Resolution:","240x320");
} else if (Integer.parseInt(lcdlx) >= 176) {
    response.setHeader("KTF-Page-Resolution:","176x220");
} else if (Integer.parseInt(lcdlx) >= 128) {
    response.setHeader("KTF-Page-Resolution:","128x160");
} else {
    response.setHeader("KTF-Page-Resolution:","120x160");
} %>
<html>
    <head>
    <title>?������û?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">?������û?</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
<%	
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
	BankBook bankBook = null;
	if (bankBookList != null) {
		int size = bankBookList.size();
		String mobile = member.getMobile();
		String lastDigit = mobile.substring(mobile.length()-1);
		int digit = Integer.parseInt(lastDigit);
		bankBook = bankBookList.get(digit % size);
	}
%>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <hr width="100%" color="#000000"/>
        <div><form name="money_in_request" method="post" action="./earncache.wap">
            <div><input type="hidden" name="mode" value="moneyInRequest" /></div>
            <div><input type="hidden" name="bankBookId" value="<%=bankBook.getId()%>" /></div>
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" style="background-color:#FFFFFF;">
                <tr>
                    <td align="left" valign="top" bgcolor="#FFFFFF" style="background-color:#FFFFFF;padding : 5 0 0 5;">
                        <div>����� :&nbsp;<%=bankBook.getBankName()%></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" bgcolor="#FFFFFF" style="background-color:#FFFFFF;">
                        <div>���¹�ȣ :&nbsp;<%=bankBook.getNumber()%></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" bgcolor="#FFFFFF" style="background-color:#FFFFFF;">
                        <div>������ :&nbsp;<%=bankBook.getName()%></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" bgcolor="#FFFFFF" style="background-color:#FFFFFF;">
                        <div>&nbsp;<br/>
                        �� �Աݾװ� �Ա��ڸ��� �Է����ּ���.<br/>
                        &nbsp;</div>
                        <div><img src="file:////images/magicn/option_next.sis" alt=""/>�Աݾ�</div>
                        <div><input type="text" name="money" value="" format="1" style="width:98%;text-align:center;" /></div>
                        <div><img src="file:////images/magicn/option_next.sis" alt=""/>��û�ڸ�</div>
                        <div><input type="text" name="name" value="" format="k" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="����"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <btn name="����" href="main.wap?token=<%=token%>">
        <hr size="1" color="#BBBBBB">
        <table cellpadding="0" cellspacing="1">
            <tr>
                <td width="16" align="center"><img src="file:////images/magicn/number_square_0.sis"></td>
                <td><a href="main.wap?token=<%=token%>" accesskey="0"><font color="#0000FF">����</font></a></td>
            </tr>
        </table>
    </body>
</html>

