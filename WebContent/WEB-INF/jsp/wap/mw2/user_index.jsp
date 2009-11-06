<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>&nbsp; </title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0" />
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
    <div style="width:<%=lcdlx%>px">
        <div><table width="100%" cellspacing="0" cellpadding="0">
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?<%=SiteConfig.SITE_NICKNAME%>?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
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
            <div style="text-align:center;">
            <table width="100%" cellspacing="0" cellpadding="0" style="height:100%;background-color:#FFFFFF;">
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>※ PIN 번호를 입력해 주세요<br/>
                        &nbsp;</div>
                        <div><img src="../picto_img/gif/core-arrow-right_2.gif" alt=""/>PIN번호</div>
                        <div><input type="password" name="pin" maxlength="6" value="" style="width:98%;text-align:center;" /></div>
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
            <div style="text-align:center;">
            <table width="100%" cellspacing="0" cellpadding="0" style="height:100%;background-color:#FFFFFF;">
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>※ 아이디와 패스워드를 입력해 주세요<br/>
                        &nbsp;</div>
                        <div><img src="../picto_img/gif/core-arrow-right_2.gif" alt=""/>아이디</div>
                        <div><input type="text" name="userId" value="" style="width:98%;text-align:center;" /></div>
                        <div><img src="../picto_img/gif/core-arrow-right_2.gif" alt=""/>패스워드</div>
                        <div><input type="text" name="password" value="" style="width:98%;text-align:center;" /></div>
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
    </div>
    </body>
</html>
