<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.w3.org/TR/XHTML-basic/XHTML-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>ȯ����û</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">ȯ����û</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
�г��� : <%=member.getNickName()%>��<br>
�ܰ� : <%=XwinUtil.comma3(member.getBalance())%>
        <div><form name="money_out_request" method="get" action="./sendcache.wap">
            <div><input type="hidden" name="mode" value="moneyOutRequest" /></div>
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" style="background-color:#FF6600;">
                <tr>
                    <td align="left" valign="middle" width="5px">
                    </td>
                    <td align="left" valign="top" style="background-color:#FFFFFF;padding : 5 0 0 5;">
                        <div>&nbsp;<br/>
                        �� ��û�װ� PIN��ȣ�� �Է����ּ���.<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_4" alt=""/>��û��</div>
                        <div><input type="text" name="money" value="" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><img localsrc="pict:///core/arrow/right_4" alt=""/>PIN��ȣ</div>
                        <div><input type="password" name="pin" value="" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="����"/></div>
                    </td>
                    <td align="left" valign="middle" width="5px">
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <do type="vnd.up" label="����"><go href="index.jsp"/></do>
    </body>
</html>

