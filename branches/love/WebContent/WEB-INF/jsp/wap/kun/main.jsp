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
    <title>?<%=SiteConfig.SITE_NICKNAME%>?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">?<%=SiteConfig.SITE_NICKNAME%>?</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <hr width="100%" color="#000000"/>
        <div>
        <table width="100%">
            <tr>
                <td width="50%" bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_1.sis"><a href="play.wap?mode=viewGameListByLeague&type=wdl&token=<%=token%>" accesskey="1"><marquee type="auto">�¹���</marquee></a></div>
                </td>
                <td width="50%" bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_2.sis"><a href="play.wap?mode=viewGameListByLeague&type=handy&token=<%=token%>" accesskey="2"><marquee type="auto">�ڵ�ĸ</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_3.sis"><a href="betlog.wap?mode=viewMyBettingList&token=<%=token%>" accesskey="3"><marquee type="auto">���ó���</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_4.sis"><a href="play.wap?mode=viewGameResultList&token=<%=token%>" accesskey="4"><marquee type="auto">�����</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_5.sis"><a href="sendcache.wap?mode=viewMoneyOutRequest&token=<%=token%>" accesskey="5"><marquee type="auto">ȯ����û</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_6.sis"><a href="sendcache.wap?mode=viewMoneyOutRequestList&token=<%=token%>" accesskey="6"><marquee type="auto">ȯ������</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_7.sis"><a href="earncache.wap?mode=viewMoneyInRequest&token=<%=token%>" accesskey="7"><marquee type="auto">������û</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_8.sis"><a href="earncache.wap?mode=viewMoneyInRequestList&token=<%=token%>" accesskey="8"><marquee type="auto">��������</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div><img src="file:////images/magicn/number_square_9.sis"><a href="play.wap?mode=viewGameList&type=wdl&token=<%=token%>" accesskey="9"><marquee type="auto">�¹���(�ֽ���)</marquee></a></div>
                </td>
                <td>
                    <div><img src="file:////images/magicn/number_square_0.sis"><a href="play.wap?mode=viewGameList&type=handy&token=<%=token%>" accesskey="0"><marquee type="auto">�ڵ�ĸ(�ֽ���)</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div><a href="play.wap?mode=viewGameListByLeague&type=mix&grade=10&token=<%=token%>" accesskey=""><marquee type="auto">�����</marquee></a></div>
                </td>
                <td>
                    <div><a href="play.wap?mode=viewGameList&type=mix&grade=10&token=<%=token%>" accesskey=""><marquee type="auto">�����(�ֽ���)</marquee></a></div>
                </td>
            </tr>
        </table>
        </div>
        <div><br/>
        �� �ֽ����� �̿��Ͻô� ȸ������ �¹���/�ڵ�ĸ �ֽ��� �޴��� Ȱ���Ͻø� ���� ������ �����ϽǼ� �ֽ��ϴ�.</div>
    </body>
</html>
