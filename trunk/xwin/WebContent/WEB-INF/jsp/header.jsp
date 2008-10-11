<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.dao.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	Boolean isIndex = (Boolean) request.getAttribute("isIndex");
	if (isIndex == null)
		isIndex = false;
	
	if (member != null) {
		MemberDao memberDao = (MemberDao) session.getAttribute("MemberDao");
		member = memberDao.selectMember(member.getUserId(), null);
		session.setAttribute("Member", member);
	}
	boolean login = member == null ? false : true;
%>
<html>
<head>
<title>bwin-Kor</title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=Euc-Kr">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<!--META HTTP-EQUIV="Refresh" Content="1800; URL=login.aspx?mode=processLogout"-->

    <link rel="stylesheet" href="style/default.css">
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
	<script language="JavaScript">
	<%
	if (login == false && isIndex == false) {
	%>
	alert("로그인이 필요합니다");
	location.href = "index.aspx";
	<%
	}
	%>
	</script>
</head>
<body style="margin:0">

<a name="top"></a>


<table width="960" height="76" cellpadding="0" cellspacing="0" background="images/top_bg.jpg">
<tr><td width="366" align="center"><a href="index.aspx"><img src="images/newtop.jpg" border="0"></a></td>
<td width="*" valign="bottom" style="padding:0 0 10 0;">
<ul class="topmenu">
<li><a href="game.aspx?mode=viewGameList&type=wdl">승무패</a></li>
<li><a href="game.aspx?mode=viewGameList&type=handy">핸디캡</a></li>
<li><a href="game.aspx?mode=viewGameResultList">경기결과</a></li>
<li><a href="aboutHandy.aspx">핸디캡이해</a></li>
<li><a href="board.aspx?mode=viewUserBoard&boardName=user">게시판</a></li>
<li><a href="board.aspx?mode=viewQnaBoard&boardName=qna">고객센터</a></li>
</ul>
</td>
</tr>
</table>

<MAP NAME="map_top_menu">
	<AREA SHAPE=RECT COORDS="  0,0,100,33" href="game.aspx?mode=viewGameList&type=wdl" onMouseOver="clipthis('top1','top2',  0,0,100,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="102,0,197,33" href="game.aspx?mode=viewGameList&type=handy" onMouseOver="clipthis('top1','top2',102,0,197,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	
	<AREA SHAPE=RECT COORDS="283,0,387,33" href="game.aspx?mode=viewGameResultList"	 onMouseOver="clipthis('top1','top2',283,0,387,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="389,0,507,33" href="guide.aspx"   onMouseOver="clipthis('top1','top2',389,0,507,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="509,0,613,33" href="rules.aspx"	 onMouseOver="clipthis('top1','top2',509,0,613,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="615,0,712,33" href="board.aspx?mode=viewUserBoard&boardName=user" onMouseOver="clipthis('top1','top2',615,0,712,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
</MAP>

<iframe name='hidden_iframe' style='display:none' src='About:Blank'></iframe>
<table width="960" height="42" background="images/login_bg.jpg" cellpadding="0" cellspacing="0" >

<%
if (login) {
%>
<tr><td>

	<table>
	<tr>
	<td><img src="images/login_img2.gif" hspace="10"></td>
	<td align="center"><b><%=member.getNickName()%></b></td>

	<td style="padding-right:10;padding-left:10;">
		<table cellpadding="0" cellspacing="0">
		<tr><td><img src="images/money_1.gif"></td>
			<td background="images/money_2.gif" width="40" align="right" style="padding-left:5;color:orange;padding-top:3;"><%=XwinUtil.comma3(member.getBalance())%></td>
			<td><img src="images/money_3.gif"></td>	
		</tr>
		</table>
	</td>	
	<td><img src="images/btn_logout.gif" onclick="FnLogout();" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>

	<td><img src="images/btn_meminfo.gif" onclick="location.href='member.aspx?mode=viewModifyForm'" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>
	<td><img src="images/btn_mybet.gif" onclick="location.href='myBet.aspx?mode=viewMyBettingList'" style="cursor:hand;"></td>
	</tr>
	</table>

</td><td align="right">

	<table cellpadding="0" cellspacing="0">
	<tr>

	<td><img src="images/smenu_1.gif" onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequest';" style="cursor:hand"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_2.gif" onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequest';" style="cursor:hand"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_3.gif" onclick="location.href='myMoney.aspx?mode=viewMyMoneyList';" style="cursor:hand"></td>
<!--
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_5.gif"></td>
//-->
	</tr>
	</table>

</td></tr>

<% } else { %>
	<form name="login_frm" onsubmit="FnLogin_Submit(login_frm);return false;">
	<tr><td align="left">
	<table cellpadding="0" cellspacing="0"><tr>
	<td><img src="images/login_img.gif" hspace="10"></td>
	<td><img src="images/login_id.gif"></td>
	<td><input class="member" type="text" name="userId" style="margin:0 0 0 5;"></td>
	<td><img src="images/login_pw.gif" hspace="3"></td>
	<td><input class="member" type="password" name="password"></td>

	<td><input type="image" src="images/btn_login.gif" style="cursor:hand;" style="margin:0 0 0 5;"></td>
	<td><img src="images/btn_join.gif" hspace="5" onclick="location.href='member.aspx?mode=viewJoinForm';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>
	</tr></table>

	</td>
	<td width="*" align="right">

	<table cellpadding="0" cellspacing="0">
	<tr>
	<td><img src="images/smenu_1.gif"></td>

	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_2.gif"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_3.gif"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_4.gif"></td>
	</tr>
	</table>

</td></tr>
</form>

<%} %>
</table>
<img id="mainImage" src="images/bwin.jpg" style="display:none">
<script>
//FnFlash("main","960","280","images/main.swf","");
if (document.URL.indexOf("index.aspx") > 0) {
	var mainImage = document.getElementById("mainImage");
	mainImage.style.display = "block";
}
</script>
<table width="960" height="25" style="border:1 solid #909090;margin-bottom:5px;" background="images/dot_02.gif">
<tr><td width="80" align="center"><b style="color:white">Notice</b></td>
	<td width="880">&nbsp;
	<marquee>
	<%=Admin.NOTICE%>
	</marquee>
	</td>
</tr>
</table>