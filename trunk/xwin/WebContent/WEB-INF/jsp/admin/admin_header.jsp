<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*" %>
<%
	Member admin = (Member)session.getAttribute("Admin");
%>
<html>
<head>
<title>관리자페이지</title>
<meta>
	<link rel="stylesheet" href="common/style.css">
	<script LANGUAGE="JavaScript" src="common/jkl-parsexml.js"></script>	
	<SCRIPT LANGUAGE="JavaScript" src="common/calendar.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript" src="common/main.js"></SCRIPT>
</head>	
<body>

<!-- 로고 및 상단 메뉴 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
 <tr>
  <td>
  <table width="950"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="60"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="7%"><a href="adminMain.aspx?mode=viewAdminMain"><img src="image/logo.gif" width="170" height="60" border="0"></a></td>
          <td width="42%"><table width="360"  border="0" cellspacing="0" cellpadding="0">
              <tr>
				<!--td width="72" height="60" align="center" style="padding-top:35px" background="image/topm41.gif"><a href="members/" class="menu" >회원관리</a>
			
				</td-->

                <td width="72" height="60" background="image/topm11.gif" align="center" style="padding-top:35px"><a href="adminInfo.aspx?mode=viewAdminInfo" class="menu" >관리자정보</a></td>
                <td width="72" height="60" background="image/topm21.gif" align="center" style="padding-top:35px"><a href="adminMember.aspx?mode=viewAdminMember" class="menu" >회원관리</a></td>
                <td width="72" height="60" background="image/topm31.gif" align="center" style="padding-top:35px"><a href="adminAccount.aspx?mode=viewMoneyIn" class="menu" >입출금관리</a></td>
                <td width="72" height="60" background="image/topm41.gif" align="center" style="padding-top:35px"><a href="game/" class="menu" >경기관리</a></td>
                <td width="72" height="60" background="image/topm51.gif" align="center" style="padding-top:35px"><a href="board/?db_name=일반게시판" class="menu" >게시판관리</a></td>
			
                <!--td width="72" height="60"  align="center" style="padding-top:35px" background="image/topm31.gif"><a href="school" class="menu" >학교관리</a></td-->                
				</tr>
          </table></td>
		  <td width="34%" valign="bottom" align="center">
		  </td>
		  <td width="17%" valign="bottom" style="padding-bottom:5px"> <a href="/" target="_blank">  바로가기</a> | <a href="logout.php">로그아웃</a> &nbsp;</td>
        </tr>
    </table></td>
  </tr>
  </table>
  </td>
 </tr>
</table>
<!-- 로고 및 상단 메뉴 -->
<!-- 상단 이미지 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="000000">
 <tr>
  <td>
  <table width="950" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="000000"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="175">&nbsp;</td>
          <td class="fcolorWhite"></td>
        </tr>
    </table></td>
  </tr>

  </table>
  </td>
 </tr>
</table><!-- 상단 이미지 -->
<!-- 페이지 내용 -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0" >
 <tr>
  <td>
<table width="950" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="100%" valign="top"><table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="170" height="500" background="image/left_bg.gif" valign="top">