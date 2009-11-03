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
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
        <div>
        <table width="100%">
            <tr>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/1"/><a title="확인" href="play.wap?mode=viewGameListByLeague&type=wdl&amp;token=<%=token%>" accesskey="1" style="marquee-style:sktscroll;">승무패</a></div>
                </td>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/2"/><a title="확인" href="play.wap?mode=viewGameListByLeague&type=handy&amp;token=<%=token%>" accesskey="2" style="marquee-style:sktscroll;">핸디캡</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/3"/><a title="확인" href="betlog.wap?mode=viewMyBettingList&amp;token=<%=token%>" accesskey="3" style="marquee-style:sktscroll;">배팅내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/4"/><a title="확인" href="play.wap?mode=viewGameResultList&amp;token=<%=token%>" accesskey="4" style="marquee-style:sktscroll;">경기결과</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/5"/><a title="확인" href="sendcache.wap?mode=viewMoneyOutRequest&amp;token=<%=token%>" accesskey="5" style="marquee-style:sktscroll;">환전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/6"/><a title="확인" href="sendcache.wap?mode=viewMoneyOutRequestList&amp;token=<%=token%>" accesskey="6" style="marquee-style:sktscroll;">환전내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/7"/><a title="확인" href="earncache.wap?mode=viewMoneyInRequest&amp;token=<%=token%>" accesskey="7" style="marquee-style:sktscroll;">충전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/8"/><a title="확인" href="earncache.wap?mode=viewMoneyInRequestList&amp;token=<%=token%>" accesskey="8" style="marquee-style:sktscroll;">충전내역</a></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div><img localsrc="pict:///core/button/9"/><a title="확인" href="play.wap?mode=viewGameList&type=wdl&amp;token=<%=token%>" accesskey="9" style="marquee-style:sktscroll;">승무패(최신폰)</a></div>
                </td>
                <td>
                    <div><img localsrc="pict:///core/button/0"/><a title="확인" href="play.wap?mode=viewGameList&type=handy&amp;token=<%=token%>" accesskey="0" style="marquee-style:sktscroll;">핸디캡(최신폰)</a></div>
                </td>
            </tr>
        </table>
        </div>
        <div><br/>
        ※ 최신폰을 이용하시는 회원님은 승무패/핸디캡 최신폰 메뉴를 활용하시면 좀더 빠르게 배팅하실수 있습니다.</div>
    </body>
</html>

