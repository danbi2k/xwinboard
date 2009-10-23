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
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
        <div>
        <table width="100%">
            <tr>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/1"/><a title="확인" href="play.wap?mode=viewGameList&type=wdl&token=<%=token%>" accesskey="1" style="marquee-style:sktscroll;">승무패</a></div>
                </td>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/2"/><a title="확인" href="play.wap?mode=viewGameList&type=handy&token=<%=token%>" accesskey="2" style="marquee-style:sktscroll;">핸디캡</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/3"/><a title="확인" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>" accesskey="3" style="marquee-style:sktscroll;">배팅내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/4"/><a title="확인" href="play.wap?mode=viewGameResultList&token=<%=token%>" accesskey="4" style="marquee-style:sktscroll;">경기결과</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/5"/><a title="확인" href="sendcache.wap?mode=viewMoneyOutRequest&token=<%=token%>" accesskey="5" style="marquee-style:sktscroll;">환전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/6"/><a title="확인" href="sendcache.wap?mode=viewMoneyOutRequestList&token=<%=token%>" accesskey="6" style="marquee-style:sktscroll;">환전내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/7"/><a title="확인" href="earncache.wap?mode=viewMoneyInRequest&token=<%=token%>" accesskey="7" style="marquee-style:sktscroll;">충전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/8"/><a title="확인" href="earncache.wap?mode=viewMoneyInRequestList&token=<%=token%>" accesskey="8" style="marquee-style:sktscroll;">충전내역</a></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div><img localsrc="pict:///core/button/9"/><a title="확인" href="play.wap?mode=viewGameListByLeague&type=wdl&token=<%=token%>" accesskey="9" style="marquee-style:sktscroll;">승무패(저사양)</a></div>
                </td>
                <td>
                    <div><img localsrc="pict:///core/button/0"/><a title="확인" href="play.wap?mode=viewGameListByLeague&type=handy&token=<%=token%>" accesskey="0" style="marquee-style:sktscroll;">핸디캡(저사양)</a></div>
                </td>
            </tr>
        </table>
        </div>
        <div><br/>
        ※ 승무패/핸디캡에서 오류가 나시는 회원님은 저사양 메뉴를 이용 부탁드립니다.</div>
    </body>
</html>

