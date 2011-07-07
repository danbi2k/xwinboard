<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member admin = (Member)session.getAttribute("Admin");
	String EX_PLAY = (String)session.getAttribute("EX_PLAY");
	
	if (EX_PLAY == null)
		EX_PLAY = "on";
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><%=SiteConfig.SITE_NICKNAME%> Admin</title>
<meta name="keywords" content="" />
<meta name="description" content=""/>
<link href="style/lasvegastoo.css" rel="stylesheet" type="text/css" />
<script LANGUAGE="javascript" src="script/jkl-parsexml.js"></script>	
<script LANGUAGE="javascript" src="script/calendar.js"></script>
<script LANGUAGE="javascript" src="script/main.js"></script>
<script LANGUAGE="javascript" src="script/xwin.js"></script>
<script LANGUAGE="javascript" src="script/default.js"></script>
<script LANGUAGE="javascript" src="script/admin.js"></script>
<script LANGUAGE="javascript" src="script/code.js"></script>
</head>
<body>
<%@ include file="playSound.jsp"%>
<script>
<%
if (admin == null) {
	out.print("alert('로그인이 필요합니다');");
	out.print("location.href='admin';");	
}
%>

var chargingVal, exchangeVal, dealChargingVal, dealExchangeVal, centerVal, vipVal, hackVal, wdlVal, handyVal, overUnderWarnVal;
var exchangePlay = <%=EX_PLAY.equals("on")?"true":"false"%>;

function checkIndiCallBack(result)
{
	if (result == undefined) {
		//location.href = 'admin';
		return;
	}
	if (result.resultXml.object) {
		var data = result.resultXml.object;
	
		chargingVal = chargingIndi.innerHTML = (data.chargingIndi);
		exchangeVal = exchangeIndi.innerHTML = (data.exchangeIndi);
		
		dealChargingVal = dealChargingIndi.innerHTML = (data.dealerChargingIndi);
		dealExchangeVal = dealExchangeIndi.innerHTML = (data.dealerExchangeIndi);
		
		<%if (SiteConfig.SITE_GRADE.equals(Code.USER_GRADE_NORMAL)) {%>
		centerVal = centerIndi.innerHTML = (data.centerIndi);
		<%} else {%>
		vipVal = vipIndi.innerHTML = (data.vipIndi);
		<%}%>
		hackVal = hackingIndi.innerHTML = (data.hackingIndi);
		overUnderWarnVal = overUnderWarnIndi.innerHTML = (data.overUnderWarn);
		//wdlVal = wdlIndi.innerHTML = (data.wdlIndi);
		//handyVal = handyIndi.innerHTML = (data.handyIndi);
	}
}

function checkIndi()
{
	var query = "mode=getIndicator";
	var http = new JKL.ParseXML("admin.aspx", query);
	http.async(checkIndiCallBack);
	http.parse();
}

function playSound()
{
	//if (chargingVal > 0)
	//	playIt(player1);
	if (exchangePlay && (exchangeVal > 0 || dealExchangeVal > 0))
		playIt(player2);
	<%if (SiteConfig.SITE_GRADE.equals(Code.USER_GRADE_NORMAL)) {%>
	if (centerVal > 0)
		playIt(player3);
	<%} else {%> 
	if (vipVal > 0)
		playIt(player3);
	<%}%>
	//if (hackVal > 30)
	//	playIt(player4);
	//if (wdlVal+handyVal > 0)
	//	playIt(player5);
}

function changeExPlay()
{ 
	exchangePlay = !exchangePlay;
	var exPlay = document.getElementById("exPlay");
	if (exchangePlay) {
		exPlay.innerHTML = "on";
	} else {
		exPlay.innerHTML = "off";
	}

	var query = "mode=changeExPlay";
	query += "&exPlay=" + exPlay.innerHTML;
	var http = new JKL.ParseXML("admin.aspx", query);
	http.parse();
}

function gameSync()
{ 
	var query = "mode=gameSync";
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
}

setInterval("playSound()", 3000);
</script>
<div id="wrapper">
	<div id="header">
		<h1><a href="adminQna.aspx?mode=viewQnaList&grade=<%=SiteConfig.SITE_GRADE%>"><%=SiteConfig.SITE_NICKNAME%></a></h1>
	</div>
	<div id="pages">
		<h2>Pages</h2>
		<ul>
			<li class="active">충전 <a id="chargingIndi" href="adminAccount.aspx?mode=viewMoneyInList&status=MC001&grade=10">0</a></li>
			<li>환전 <a id="exchangeIndi" href="adminAccount.aspx?mode=viewMoneyOutList&status=ME001&grade=10">0</a><span style='font-size:12;' id='exPlay' onclick='changeExPlay()'><%=EX_PLAY%></span></li>
			<li>총판충전 <a id="dealChargingIndi" href="adminAccount.aspx?mode=viewMoneyInList&status=MC001&grade=20">0</a></li>
			<li>총판환전 <a id="dealExchangeIndi" href="adminAccount.aspx?mode=viewMoneyOutList&status=ME001&grade=20">0</a></li>
			<li>고객센터  <a id="vipIndi" href="adminQna.aspx?mode=viewQnaList&grade=10">0</a></li>
			<li>해킹  <a id="hackingIndi" href="adminLog.aspx?mode=viewHackingLog">0</a></li>
			<li>오버언더  <a id="overUnderWarnIndi" href="adminBetting.aspx?mode=viewBettingMoneyList">0</a></li>
			<!--li>승무패  <a id="wdlIndi" href="adminGame.aspx?mode=viewGameList&type=wdl&grade=<%=Code.USER_GRADE_NORMAL%>">0</a></li-->
			<!--li>핸디캡  <a id="handyIndi" href="adminGame.aspx?mode=viewGameList&type=handy&grade=<%=Code.USER_GRADE_NORMAL%>">0</a></li-->
		</ul>
	</div>
	<div id="content">
		<div id="posts">
			<div class="post">
				<div class="story">