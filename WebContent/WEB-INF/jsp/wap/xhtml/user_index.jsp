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
    <title>?<%=SiteConfig.SITE_NICKNAME%>?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?<%=SiteConfig.SITE_NICKNAME%>?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
<%
	Member adhocMember = (Member) request.getAttribute("adhocMember");
%>
        <div><%=adhocMember.getNickName()%>님 환영합니다!</div>
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
                        <div>※ PIN 번호를 입력해 주세요<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_4" alt=""/>PIN번호</div>
                        <div><input type="password" name="pin" maxlength="6" value="" format="N*N" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="name" value="$(name)" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="전송"/></div>
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
                        <div>※ 아이디와 패스워드를 입력해 주세요<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_4" alt=""/>아이디</div>
                        <div><input type="text" name="userId" value="" format="x*x" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><img localsrc="pict:///core/arrow/right_4" alt=""/>패스워드</div>
                        <div><input type="text" name="password" value="" format="x*x" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="name" value="$(name)" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="전송"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <div>홈페이지 '정보수정' 에서 '모바일PIN번호' 6자리를 등록하시면 보다 쉽게 로그인이 가능 합니다.</div>
<%} %>
    </body>
</html>

