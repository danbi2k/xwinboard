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
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?Apple?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr style="color:#000000;width:100%;"/>
        <div>
        <table width="100%">
            <tr>
                <td style="width:50%;background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-1.gif" alt=""/><a title="확인" href="play.wap?mode=viewGameList&type=wdl&token=<%=token%>" accesskey="1">승무패</a></div>
                </td>
                <td style="width:50%;background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-2.gif" alt=""/><a title="확인" href="play.wap?mode=viewGameList&type=handy&token=<%=token%>" accesskey="2">핸디캡</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-3.gif" alt=""/><a title="확인" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>" accesskey="3">배팅내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-4.gif" alt=""/><a title="확인" href="play.wap?mode=viewGameResultList&token=<%=token%>" accesskey="4">경기결과</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-5.gif" alt=""/><a title="확인" href="sendcache.wap?mode=viewMoneyOutRequest&token=<%=token%>" accesskey="5">환전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-6.gif" alt=""/><a title="확인" href="sendcache.wap?mode=viewMoneyOutRequestList&token=<%=token%>" accesskey="6">환전내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-7.gif" alt=""/><a title="확인" href="earncache.wap?mode=viewMoneyInRequest&token=<%=token%>" accesskey="7">충전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-8.gif" alt=""/><a title="확인" href="earncache.wap?mode=viewMoneyInRequestList&token=<%=token%>" accesskey="8">충전내역</a></div>
                </td>
            </tr>
        </table>
        </div>
    </div>
    </body>
</html>
