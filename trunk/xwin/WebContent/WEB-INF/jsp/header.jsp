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
<tr><td width="270" align="center"><a href="index.aspx"><img src="images/newtop.jpg" border="0"></a></td>
<td width="*" valign="bottom" style="padding:0 0 10 0;">
<ul class="topmenu">
<li><a href="game.aspx?mode=viewGameList&type=wdl"><img src='images/menu_wdl.jpg' border='0'></a></li>
<li><a href="game.aspx?mode=viewGameList&type=handy"><img src='images/menu_handy.jpg' border='0'></a></li>
<li><a href="game.aspx?mode=viewGameResultList"><img src='images/menu_result.jpg' border='0'></a></li>
<li><a href="aboutHandy.aspx"><img src='images/menu_abouthandy.jpg' border='0'></a></li>
<li><a href="board.aspx?mode=viewUserBoard&boardName=user"><img src='images/menu_board.jpg' border='0'></a></li>
<li><a href="board.aspx?mode=viewQnaBoard&boardName=qna"><img src='images/menu_qna.jpg' border='0'></a></li>
</ul>
</td>
</tr>
</table>

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
			<td>&nbsp;<img src="images/point.jpg"></td>
			<td background="images/money_2.gif" width="40" align="right" style="padding-left:5;color:orange;padding-top:3;" onclick="exchangePoint(<%=member.getPoint()%>)"><%=XwinUtil.comma3(member.getPoint())%></td>
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
<img id="mainImage" src="images/wall04.jpg" style="display:none">
<script>
//FnFlash("main","960","280","images/main.swf","");
if (document.URL.indexOf("index.aspx") > 0) {
	var mainImage = document.getElementById("mainImage");
	mainImage.style.display = "block";
}

function exchangePoint(point)
{
	var balance = point - (point % 10000);
	if (balance < 10000) {
		alert("포인트는 10,000원 단위로 충전이 가능합니다");
		return;
	}

	if (confirm("포인트 " + comma3(balance) + "원 을 머니로 충전하시겠습니까?")) {
		var query = "mode=exchangePoint";
		var http = new JKL.ParseXML("member.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}
</script>
<table width="960" height="25" style="border:1 solid #909090;margin-bottom:5px;" background="images/dot_02.gif">
<tr><td width="80" align="center"><b style="color:white">Notice</b></td>
	<td width="880" height="30"><font size=4"><b>&nbsp;
	<marquee>
	<%=Admin.NOTICE%>
	</marquee></b></font>
	</td>
</tr>
</table>