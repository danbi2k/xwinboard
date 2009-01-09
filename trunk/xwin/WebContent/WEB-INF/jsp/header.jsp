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
<title>Bravo</title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=UTF-8">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Refresh" Content="1800; URL=login.aspx?mode=processLogout">

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
<body style="margin:0">

<a name="top"></a>


<table width="960" height="76" cellpadding="0" cellspacing="0" background="images/top_bg.jpg">
<tr><td width="270" align="center"><a href="home.aspx"><img src="images/bravo.jpg" border="0"></a></td>
<td width="*" valign="bottom" style="padding:0 0 10 0;">
<ul class="topmenu" id="topmenu">
<li><a href="game.aspx?mode=viewGameList&type=wdl&grade=1"><img src='images/menu_wdl.jpg' border='0'></a></li>
<li><a href="game.aspx?mode=viewGameList&type=handy&grade=1"><img src='images/menu_handy.jpg' border='0'></a></li>
<li><a href="game.aspx?mode=viewGameResultList"><img src='images/menu_result.jpg' border='0'></a></li>
<!-- li><a href="aboutHandy.aspx"><img src='images/menu_abouthandy.jpg' border='0'></a></li -->
<li><a href="board.aspx?mode=viewBoard&boardName=user"><img src='images/menu_board.jpg' border='0'></a></li>
<li><a href="board.aspx?mode=viewBoard&boardName=qna"><img src='images/menu_qna.jpg' border='0'></a></li>
<li><a href="introduce.aspx?mode=viewIntroduceForm"><img src='images/menu_intro.jpg' border='0'></a></li>
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
	<td align="center" nowrap><b><%=member.getNickName()%></b></td>

	<td style="padding-right:10;padding-left:10;">
		<table cellpadding="0" cellspacing="0">
		<tr><td><img src="images/money_1.gif"></td>
			<td background="images/money_2.gif" width="40" align="right" style="padding-left:5;color:orange;padding-top:3;" nowrap><%=XwinUtil.comma3(member.getBalance())%></td>
			<td><img src="images/money_3.gif"></td>
			<td>&nbsp;<img src="images/point.jpg"></td>
			<td background="images/money_2.gif" width="40" align="right" style="padding-left:5;color:orange;padding-top:3;" onclick="exchangePoint(<%=member.getPoint()%>)" nowrap><%=XwinUtil.comma3(member.getPoint())%></td>
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
	<td>
		<%if (member.getGrade().equals(Code.USER_GRADE_VIP)) {%>
		
		<img src="images/smenu_event.gif" onclick="location.href='game.aspx?mode=viewGameList&type=wdl&grade=10';" style="cursor:hand">
	
	</td>
	<%} %>

	<td>
		<%if (Admin.DENY_CHARGE.equals("Y")) {%>
		<img src="images/smenu_1.gif" onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequest';" style="cursor:hand">
		
	</td>
	<td><img src="images/smenu_gap.gif">
	<%} %></td>
	<td>
		<%if (Admin.DENY_EXCHANGE.equals("Y")) {%>
		<img src="images/smenu_2.gif" onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequest';" style="cursor:hand">
	</td>
	<td><img src="images/smenu_gap.gif">
	<%} %></td>
	<td><img src="images/smenu_3.gif" onclick="location.href='myMoney.aspx?mode=viewMyMoneyList';" style="cursor:hand"></td>
<!--
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_5.gif"></td>
//-->
	</tr>
	</table>

</td></tr>

<% } else { %>
<%} %>
</table>
<img id="mainImage" src="images/wall05.jpg" style="display:none">
<script>
//FnFlash("main","960","280","images/main.swf","");
if (document.URL.indexOf("home.aspx") > 0) {
	var mainImage = document.getElementById("mainImage");
	mainImage.style.display = "block";
}

var memoId;

function receiveMemo()
{
	var query = "mode=receiveMemo";
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0 && result.resultXml.object) {
		var span = document.getElementById("memoContents");
		var memo = result.resultXml.object.memo;
		var regexp = new RegExp(/\n/ig);
		memo = memo.replace(regexp, "<BR>");
		span.innerHTML = memo;
		memoId = result.resultXml.object.id;
		var memoDiv = document.getElementById("memoDiv");
		memoDiv.style.visibility = "visible";
	}
}

function memoClose()
{
	var isReaded = document.getElementById("isReaded");
	if (isReaded.checked) {
		var query = "mode=readMemo";
		query += "&id=" + memoId;
		var http = new JKL.ParseXML("member.aspx", query);
		var result = http.parse();
	}
	
	var memoDiv = document.getElementById("memoDiv");
	memoDiv.style.visibility = "hidden";

	receiveMemo();
}
</script>

<table width="960" height="25" style="border:1 solid #909090;margin-bottom:5px;" background="images/dot_02.gif">
<tr><td width="80" align="center"><b style="color:white">Notice</b></td>
	<td width="880" height="30"><font size=4"><b>&nbsp;
	<marquee onmouseover='this.stop()' onmouseout='this.start()'>
	<%=Admin.NOTICE%>
	</marquee></b></font>
	</td>
</tr>
</table>
<div id="memoDiv" style="padding:10 10 10 10;position:absolute;left:50%;top:50%;width:350px;height:350px;z-index:2;margin-left:-175px;margin-top:-175px;visibility:hidden;background-color:#CCCCCC;color:#000000">
<form>
<table border=0 style='width:100%;color:#000000'>
<tr>
<td align='center' style='color:#000000'><font size=3><B>긴급알림</B></font></td>
</tr>
<tr height=100%>
<td height=280px>
<span id="memoContents" style='width:100%;height:100%;color:#000000' valign='top'></span>
</td>
</tr>
<tr>
<td align='right' style='color:#000000'>
	다시보지않음<input type="checkbox" id="isReaded"/>
	닫기 <img src="images/btn_coment_del.gif" onclick="memoClose()"/>
</td>
</tr>
</table>
</form>
</div>
<script>
<%if (login) {%>
receiveMemo();
<%}%>
</script>