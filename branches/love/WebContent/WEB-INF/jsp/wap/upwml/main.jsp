<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//PHONE.COM//DTD WML 1.1//EN" "http://www.phone.com/dtd/wml11.dtd">
<!--Web Logic 웹서버에서 한글이 깨진다면 DOCTYPE 라인을 삭제해 보세요.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="nowrap">&lt;<%=SiteConfig.SITE_NICKNAME%>&gt;</p>
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
        <p mode="wrap"><br/>
        ※ 최신폰을 이용하시는 회원님은 승무패/핸디캡 최신폰 메뉴를 활용하시면 좀더 빠르게 배팅하실수 있습니다.</p>
        <do type="accept" label="확인" name="VX"><go href=""/></do>
    </card>
</wml>

