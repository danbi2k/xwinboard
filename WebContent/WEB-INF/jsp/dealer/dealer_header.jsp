<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Dealer dealer = (Dealer)session.getAttribute("Dealer");
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><%=SiteConfig.SITE_NICKNAME%> <%=dealer.getDealerId()%></title>
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
<div id="wrapper">
	<div id="header">
		<h1><a href="dealer.aspx?mode=viewDealerSummary"><%=dealer.getDealerId()%></a></h1>
	</div>
	<div id="pages">
		<h2>Pages</h2>
		<ul>
			<li class="active"></li>
		</ul>
	</div>
	<div id="content">
		<div id="posts">
			<div class="post">
				<div class="story">