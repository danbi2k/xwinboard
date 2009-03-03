<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.domain.*" %>
<%
	Member admin = (Member)session.getAttribute("Admin");
	String EX_PLAY = (String)session.getAttribute("EX_PLAY");
	
	if (EX_PLAY == null)
		EX_PLAY = "on";
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><%=SiteConfig.SITE_NAME%> Admin</title>
<meta name="keywords" content="" />
<meta name="description" content=""/>
<link href="style/lasvegastoo.css" rel="stylesheet" type="text/css" />
<script LANGUAGE="javascript" src="script/jkl-parsexml.js"></script>	
<script LANGUAGE="javascript" src="script/calendar.js"></script>
<script LANGUAGE="javascript" src="script/main.js"></script>
<script LANGUAGE="javascript" src="script/xwin.js"></script>
<script LANGUAGE="javascript" src="script/default.js"></script>
<script LANGUAGE="javascript" src="script/admin.js"></script>
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

var chargingVal, exchangeVal, centerVal, vipVal, hackVal;
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
		centerVal = centerIndi.innerHTML = (data.centerIndi);
		//vipVal = vipIndi.innerHTML = (data.vipIndi);
		hackVal = hackingIndi.innerHTML = (data.hackingIndi);
	}
}

function checkIndi()
{
	var chargingIndi = document.getElementById("chargingIndi");
	var exchangeIndi = document.getElementById("exchangeIndi");
	var centerIndi = document.getElementById("centerIndi");
	//var vipIndi = document.getElementById("vipIndi");
	var hackingIndi = document.getElementById("hackingIndi");

	var query = "mode=getIndicator";
	var http = new JKL.ParseXML("admin.aspx", query);
	http.async(checkIndiCallBack);
	http.parse();
}

function playSound()
{
	//if (chargingVal > 0)
	//	playIt(player1);
	if (exchangePlay && exchangeVal > 0)
		playIt(player2);
	if (centerVal > 0)
		playIt(player3);
	//if (vipVal > 0)
	//	playIt(player3);
	if (hackVal > 0)
		playIt(player4);
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

setInterval("playSound()", 3000);
</script>
<div id="wrapper">
	<div id="header">
		<h1><a href="adminQna.aspx?mode=viewQnaList&grade=10">Love</a></h1>
	</div>
	<div id="pages">
		<h2>Pages</h2>
		<ul>
			<li class="active">충전 <a id="chargingIndi" href="adminAccount.aspx?mode=viewMoneyInList&status=MC001">0</a></li>
			<li>환전 <a id="exchangeIndi" href="adminAccount.aspx?mode=viewMoneyOutList&status=ME001">0</a><span style='font-size:12;' id='exPlay' onclick='changeExPlay()'><%=EX_PLAY%></span></li>
			<li>고객센터  <a id="centerIndi" href="adminQna.aspx?mode=viewQnaList&grade=1">0</a></li>
			<!-- li>VIP센터  <a id="vipIndi" href="adminQna.aspx?mode=viewQnaList&grade=10">0</a></li -->
			<li>해킹  <a id="hackingIndi" href="adminLog.aspx?mode=viewHackingLog">0</a></li>
		</ul>
	</div>
	<div id="content">
		<div id="posts">
			<div class="post">
				<div class="story">