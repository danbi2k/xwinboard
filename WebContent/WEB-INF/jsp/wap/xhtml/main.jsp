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
    <title>?Apple?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?Apple?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
        <div>
        <table width="100%">
            <tr>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/1"/><a title="Ȯ��" href="play.wap?mode=viewGameList&type=wdl&token=<%=token%>" accesskey="1" style="marquee-style:sktscroll;">�¹���</a></div>
                </td>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/2"/><a title="Ȯ��" href="play.wap?mode=viewGameList&type=handy&token=<%=token%>" accesskey="2" style="marquee-style:sktscroll;">�ڵ�ĸ</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/3"/><a title="Ȯ��" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>" accesskey="3" style="marquee-style:sktscroll;">���ó���</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/4"/><a title="Ȯ��" href="play.wap?mode=viewGameResultList&token=<%=token%>" accesskey="4" style="marquee-style:sktscroll;">�����</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/5"/><a title="Ȯ��" href="sendcache.wap?mode=viewMoneyOutRequest&token=<%=token%>" accesskey="5" style="marquee-style:sktscroll;">ȯ����û</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/6"/><a title="Ȯ��" href="sendcache.wap?mode=viewMoneyOutRequestList&token=<%=token%>" accesskey="6" style="marquee-style:sktscroll;">ȯ������</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/7"/><a title="Ȯ��" href="earncache.wap?mode=viewMoneyInRequest&token=<%=token%>" accesskey="7" style="marquee-style:sktscroll;">������û</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/8"/><a title="Ȯ��" href="earncache.wap?mode=viewMoneyInRequestList&token=<%=token%>" accesskey="8" style="marquee-style:sktscroll;">��������</a></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div><img localsrc="pict:///core/button/9"/><a title="Ȯ��" href="play.wap?mode=viewGameListByLeague&type=wdl&token=<%=token%>" accesskey="9" style="marquee-style:sktscroll;">�¹���(�����)</a></div>
                </td>
                <td>
                    <div><img localsrc="pict:///core/button/0"/><a title="Ȯ��" href="play.wap?mode=viewGameListByLeague&type=handy&token=<%=token%>" accesskey="0" style="marquee-style:sktscroll;">�ڵ�ĸ(�����)</a></div>
                </td>
            </tr>
        </table>
        </div>
        <div><br/>
        �� �¹���/�ڵ�ĸ���� ������ ���ô� ȸ������ ����� �޴��� �̿� ��Ź�帳�ϴ�.</div>
    </body>
</html>

