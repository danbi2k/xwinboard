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
    <title>?Apple?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?Apple?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
<%
	Member adhocMember = (Member) request.getAttribute("adhocMember");
%>
        <div><%=adhocMember.getNickName()%>�� ȯ���մϴ�!</div>
<%
String pin = adhocMember.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
        <div><form name="pin_login" method="post" action="./login.wap">
            <div><input type="hidden" name="mode" value="processPinLogin" /></div>
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" style="background-color:#FFFFFF;">
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>�� PIN ��ȣ�� �Է��� �ּ���<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_2" alt=""/>PIN��ȣ</div>
                        <div><input type="password" name="pin" maxlength="6" value="" format="N*N" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="name" value="$(name)" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="����"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
<%}  else {%>
        <div><form name="user_login" method="post" action="./login.wap">
            <div><input type="hidden" name="mode" value="processUserLogin" /></div>
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" style="background-color:#FFFFFF;">
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>�� ���̵�� �н����带 �Է��� �ּ���<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_2" alt=""/>���̵�</div>
                        <div><input type="text" name="userId" value="" format="x*x" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><img localsrc="pict:///core/arrow/right_2" alt=""/>�н�����</div>
                        <div><input type="text" name="password" value="" format="x*x" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="name" value="$(name)" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="����"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <div>Ȩ������ '��������' ���� '�����PIN��ȣ' 6�ڸ��� ����Ͻø� ���� ���� �α����� ���� �մϴ�.</div>
<%} %>
    </body>
</html>
