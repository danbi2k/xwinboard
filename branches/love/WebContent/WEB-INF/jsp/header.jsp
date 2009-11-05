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
<title>DRAGON-BET 환영합니다</title>
	<Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=UTF-8">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Refresh" Content="900; URL=login.php?mode=processLogout">
    <script language="JavaScript" src="script/embed_patch.js"></script>
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
	<script language="javascript" src="script/mEmbed.js"></script>
	<link rel="stylesheet" type="text/css" href="style/style.css">
    <style type="text/css">
<!--
.top_login {color: #ffff00;font-weight: bold;}

-->
    </style>
</head>


<div id="memoDiv" style="padding:10 10 10 10;position:absolute;left:50%;top:50%;width:350px;height:350px;z-index:2;margin-left:-175px;margin-top:-175px;visibility:hidden;background-color:#CCCCCC;color:#000000">
<form>
<table border=0 style='width:100%;color:#000000'>
<tr>
<td align='center' style='color:#000000'><font size=3><B>긴급알림</B></font></td>
</tr>
<tr height=100%>
<td height=280px>
<span id="memoContents" style='width:100%;height:100%;color:#000000' valign='top'></span></td>
</tr>
<tr>
<td align='right' style='color:#000000'>
	다시보지않음<input type="checkbox" id="isReaded"/>
	닫기 <img src="img/x.gif" onClick="memoClose()"/></td>
</tr>
</table>
</form>
</div>
<script>
var memoId;

function receiveMemo()
{
	var query = "mode=receiveMemo";
	var http = new JKL.ParseXML("user.php", query);
	var result = http.parse();
	if (result.resultXml.code == 0 && result.resultXml.object) {
		var span = document.getElementById("memoContents");
		var memo = result.resultXml.object.memo;
		if (memo == undefined) {
			return;
		}
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
		var http = new JKL.ParseXML("user.php", query);
		var result = http.parse();
	}
	
	var memoDiv = document.getElementById("memoDiv");
	memoDiv.style.visibility = "hidden";

	receiveMemo();
}
<%if (login) {%>
receiveMemo();
<%}%>
</script>
<body topmargin="0" leftmargin="0" marginwidth='0' marginheight='0' style="background:url(images/main/bg_top2.gif) no-repeat center top;">
<div style="position: absolute; left:expression((document.body.clientWidth) / 2 -493); top:expression((document.body.clienthheight) / 2 -170); z-index: 3; width: 968px; top: 25px; left:0px;"> 
  <div align="right" class="style1">
  <%if (login) { %>
  <a href="home.php"><img src="images/main/top_1.gif" border="0" ></a>&nbsp;
  <img src="images/main/top_line.gif">&nbsp;
  <a href="earncache.php?mode=viewMoneyInRequest"><img src="images/main/top_2.gif" border="0"></a>&nbsp;
    <img src="images/main/top_line.gif">&nbsp;
    <a href="sendcache.php?mode=viewMoneyOutRequest"><img src="images/main/top_3.gif" border="0" ></a>&nbsp;
    <img src="images/main/top_line.gif">&nbsp;
    <a href="betlog.php?mode=viewMyBettingList"><img src="images/main/top_4.gif" border="0"></a>&nbsp;
    <img src="images/main/top_line.gif">&nbsp;
    <a href="account.php?mode=viewMyMoneyList"><img src="images/main/top_5.gif" border="0"></a>&nbsp;
    <img src="images/main/top_line.gif">&nbsp;
    <a href="account.php?mode=viewMyPointList"><img src="images/main/top_6.gif" border="0" ></a>&nbsp;
    <img src="images/main/top_line.gif">&nbsp;
    <a href="login.php?mode=processLogout"><img src="images/main/top_7.gif" border="0"></a> </div>
   <%} %>
</div>
<!-------------------------------------------------로그인&로그아웃 레이어 시작-------------------------------------------------------->
<!-------------------------------------------------로그인&로그아웃 레이어 끝-------------------------------------------------------->
<!-------------------------------------------------플래쉬시작-------------------------------------------------------->
<center>		<textarea id="emb_01" style="display:none;" cols="0" rows="0">


<object

classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"

codebase=" http://fpdownload.adobe.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="968" height="100" align="middle">
<param name="movie" value="swf/main2.swf">
<param name="wmode" value="transparent">
<param name="allowScriptAccess" value="always">
<embed type="application/x-shockwave-flash"
pluginspage="http://www.adobe.com/go/getflashplayer"

width="968" height="100" align="middle"
src="swf/main2.swf"

allowScriptAccess="always"></embed>
</object>
</textarea>
<script language="javascript">WriteEmbed('emb_01')</script>
</center>
<!-------------------------------------------------플래쉬끝-------------------------------------------------------->
<%if (login) {%>
<table width="968" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
  <tr>
    <td height="97" valign="middle" background="images/main/notice_top_bg.gif"><table width="100%" height="97" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="51" valign="top" style="padding-top:22px;padding-left:90px;"><table width="877" height="17" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="49">&nbsp;</td>
            <td width="82"><div align="center"><span class="top_login"><%=member.getNickName()%></span></div></td>
            <td width="74">&nbsp;</td>
            <td width="98"><div align="center"><span class="top_login"><%=XwinUtil.comma3(member.getBalance())%></span></div></td>
            <td width="79">&nbsp;</td>
            <td width="99"><div align="center"><a href='javascript:exchangePoint(<%=member.getPoint()%>)'><span class="top_login"><%=XwinUtil.comma3(member.getPoint())%></span></a></div></td>
            <td width="72">&nbsp;</td>
            <td width="56" padding-top:2px;"><div align="center"><span class="top_login"><%=Code.getValue(member.getGrade())%></span></div></td>
            <td width="30">&nbsp;</td>
            <td width="125"><a href="login.php?mode=processLogout"><img src="images/main/notice_top_bt.gif" border="0"></a></td>
            <td width="113" valign="top" style="padding-top:10px;">
			<a href="user.php?mode=viewModifyForm"><img src="images/main/notice_top_1.gif" border="0"></a>
            <a href="betlog.php?mode=viewMyBettingList"><img src="images/main/notice_top_2.gif" border="0" style="margin-left:10px;"></a></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="98%" border="0" cellpadding="0" cellspacing="0" style="margin-left:90px;margin-top:8px;">
          <tr>
            <td><marquee onmouseover='this.stop()' onmouseout='this.start()'>
              <%=Admin.NOTICE%>
              </marquee>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<%}%>
<center>




<table align="center" cellpadding="0" cellspacing="0" width="965" height="40" style="margin-top:15px;">	