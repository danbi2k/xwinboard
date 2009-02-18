<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.dao.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="java.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	Boolean isIndex = (Boolean) request.getAttribute("isIndex");
	Boolean isModify = (Boolean) request.getAttribute("isModify");
	if (isIndex == null)
		isIndex = false;
	if (isModify == null)
		isModify = false;
	
	if (member != null) {
		Member dbMember = Admin.memberDao.selectMember(member.getUserId(), null);
		dbMember.setBettingDate(member.getBettingDate());
		dbMember.setLoginDate(member.getLoginDate());
		session.setAttribute("Member", dbMember);
		
		member = dbMember;
	}
	boolean login = member == null ? false : true;
%>
<html>
<head>
<title>APPLE-BET</title>
	<Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=UTF-8">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Refresh" Content="1800; URL=login.aspx?mode=processLogout">

	<link rel='stylesheet' href='style/default.css' type='text/css'>
	<script language="JavaScript" src="script/code.js"></script>
    <script language="JavaScript" src="script/default.js"></script>
	<script language="JavaScript" src="script/game.js"></script>
	<script language="JavaScript" src="script/betting.js"></script>
	<script language="JavaScript" src="script/member.js"></script>
	<script language="JavaScript" src="script/mybet.js"></script>
	<script language="JavaScript" src="script/board.js"></script>
	<script language="JavaScript" src="script/jkl-parsexml.js"></script>
	<script language="JavaScript" src="script/xwin.js"></script>
	<script language="JavaScript" src="script/utf8.js"></script>
	<script language="JavaScript" src="script/xwin_user.js"></script>
	<script language="JavaScript">
	<%
	if (login == false && isIndex == false) {
	%>
	alert("로그인이 필요합니다");
	location.href = "login.aspx?mode=processLogout";
	<%
	}
	%>

	<%
	if (login && (member.getBankName() == null || member.getBankName().length() == 0) && isModify == false) {
	%>
	location.href = "member.aspx?mode=viewModifyForm";
	<%
	}
	%>

	<%
	if (login && (member.getPasswordExpire().equals("Y")) && isModify == false) {
	%>
	location.href = "member.aspx?mode=viewModifyForm";
	<%
	}
	%>	
	</script>
</head>
<body>
<div id='top_bg'></div>
<div id='wrap'>
	<div id='header'>
		<div class='glogo'><a href="home.aspx"><img src='img/glogo.jpg' alt='www.apbet.net'></a></div>
		<div class='gnb'>
		<ul>
		<li><a href='home.aspx' target='_self'>HOME</a> |</li>
		<li><a href='moneyIn.aspx?mode=viewMoneyInRequest' target='_self'>캐쉬충전</a> |</li>
		<li><a href='moneyOut.aspx?mode=viewMoneyOutRequest' target='_self'>환전요청</a> |</li>
		<li><a href='myBet.aspx?mode=viewMyBettingList' target='_self'>배팅이력</a> |</li>
		<li><a href='myMoney.aspx?mode=viewMyMoneyList' target='_self'>거래이력</a> |</li>
		<li><a href='login.aspx?mode=processLogout' target='_self'>로그아웃</a></li>
		</ul>
		</div>
		<div class='nav'>
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="900" height="57" id="menu" align="middle">
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="allowFullScreen" value="false" />
			<param name="movie" value="swf/menu.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />	<embed src="./swf/menu.swf" quality="high" bgcolor="#ffffff" width="900" height="57" name="menu" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
			</object>
		</div>
	</div>
	<!-- end header -->
	
	<div id='container'>