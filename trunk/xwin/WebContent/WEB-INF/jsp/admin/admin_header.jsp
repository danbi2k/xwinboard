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
</script>
<div id="wrapper">
	<div id="header">
		<h1><a href="#">Bwin-Kor</a></h1>
	</div>
	<div id="pages">
		<h2>Pages</h2>
		<ul>
			<li class="active"><a id="page1" href="#">충전 ( 0 )</a></li>
			<li><a id="page2" href="#">환전 ( 0 )</a></li>
			<li><a id="page3" href="#">고객센터 ( 0 )</a></li>
		</ul>
	</div>
	<div id="content">
		<div id="posts">
			<div class="post">
				<div class="story">