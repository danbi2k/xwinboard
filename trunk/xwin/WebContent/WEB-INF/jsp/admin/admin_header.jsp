<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*" %>
<%
	Member admin = (Member)session.getAttribute("Admin");
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Bwin-Kor Admin</title>
<meta name="keywords" content="" />
<meta name="description" content=""/>
<link href="style/lasvegastoo.css" rel="stylesheet" type="text/css" />
<script LANGUAGE="javascript" src="script/jkl-parsexml.js"></script>	
<script LANGUAGE="javascript" src="script/calendar.js"></script>
<script LANGUAGE="javascript" src="script/main.js"></script>
</head>
<body>
<script>
<%
if (admin == null) {
	out.print("alert('로그인이 필요합니다');");
	out.print("location.href='admin';");	
}
%>
function checkIndi()
{
	var chargingIndi = document.getElementById("chargingIndi");
	var exchangeIndi = document.getElementById("exchangeIndi");
	var centerIndi = document.getElementById("centerIndi");

	var query = "mode=getIndicator";
	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();
	var data = result.resultXml.object;

	chargingIndi.innerHTML = (data.chargingIndi);
	exchangeIndi.innerHTML = (data.exchangeIndi);
	centerIndi.innerHTML = (data.centerIndi);	
}
</script>
<div id="wrapper">
	<div id="header">
		<h1><a href="adminMain.aspx?mode=viewAdminMain">Bwin-Kor</a></h1>
	</div>
	<div id="pages">
		<h2>Pages</h2>
		<ul>
			<li class="active">충전 (<a id="chargingIndi" href="adminAccount.aspx?mode=viewMoneyInList&status=MC001">0</a> )</li>
			<li>환전 ( <a id="exchangeIndi" href="adminAccount.aspx?mode=viewMoneyOutList&status=ME001">0</a> )</li>
			<li>고객센터 ( <a id="centerIndi" href="adminQna.aspx?mode=viewQnaList">0</a> )</li>
		</ul>
	</div>
	<div id="content">
		<div id="posts">
			<div class="post">
				<div class="story">