<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
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

	List<Game> wdlList = (List<Game>) request.getAttribute("wdlList");
	List<Game> handyList = (List<Game>) request.getAttribute("handyList");
%>

<html>
<head>
<title>DRAGON-BET 환영합니다</title>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
.style1 {font-size: 11px}
.top_login {color: #ffff00;font-weight: bold;}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
    </style>
</head>
<body topmargin="0" leftmargin="0" marginwidth='0' marginheight='0' style="background:url(images/main/bg_top1.gif) no-repeat center top;">
<div style="position: absolute; left:expression((document.body.clientWidth) / 2 -493); top:expression((document.body.clienthheight) / 2 -170); z-index: 3; width: 968px; top: 25px; left:0px;"> 
 <div align="right" class="style1">
  <a href="#"><img src="images/main/top_1.gif" border="0" ></a>&nbsp;
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
</div>
<!-------------------------------------------------로그인&로그아웃 레이어 시작-------------------------------------------------------->
<div style="position: absolute; left:expression((document.body.clientWidth) / 2 -493); top:expression((document.body.clienthheight) / 2 -170); z-index: 3; width: 200px; top: 190px; left:0px;">
 	<%if (login) { %>
 	<table width="246" height="166" border="0" cellpadding="0" cellspacing="0" background="images/main/logout_bg.gif"  >
      <tr>
        <td valign="top"><table width="85%" border="0"cellpadding="0" cellspacing="0" style="margin-left:20px;margin-top:20px;">
          <tr>
            <td><span class="top_login"><%=member.getNickName()%></span><span class="style2">&nbsp;님 반갑습니다</span></td>
          </tr>
        </table>
          <table width="100%" height="129" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="71%" valign="top" style="padding-top:18px;padding-left:15px;"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="35%" height="22">&nbsp;</td>
                  <td width="65%" valign="middle"><span class="top_login"><%=XwinUtil.comma3(member.getBalance())%></span></td>
                </tr>
                <tr>
                  <td height="24">&nbsp;</td>
                  <td valign="middle"><a href='javascript:exchangePoint(<%=member.getPoint()%>)'><span class="top_login"><%=XwinUtil.comma3(member.getPoint())%></a>&nbsp;PT</span></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td valign="bottom" style="padding-top:4px;"><span class="top_login"><%=Code.getValue(member.getGrade())%></span></td>
                </tr>
              </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
                  <tr>
                    <td>
					<a href="user.php?mode=viewModifyForm"><img src="images/main/logout_title01.gif" border="0"></a>&nbsp;
					<a href="betlog.php?mode=viewMyBettingList"><img src="images/main/logout_title02.gif" border="0"></a></td>
                  </tr>
                </table></td>
              <td width="29%" valign="bottom"><div align="right"><a href="login.php?mode=processLogout"><img src="images/main/logout_bt.gif" width="70" height="66" border="0"></a></div></td>
            </tr>
          </table></td>
      </tr>
  </table>
 	<%} else { %>
		<form name="login">
      <table width="246" height="166" border="0" cellpadding="0" cellspacing="0" background="images/main/1_sub1.gif"  >
        <tr>
          <td valign="top" style="padding-top:50px;"><table width="93%" border="0" align="left" cellpadding="0" cellspacing="0" style="margin-left:9px;">
              <tr>
                <td colspan="2"><img src="images/main/login_title_1.gif"></td>
              </tr>
              <tr>
                <td width="69%" style="padding-top:10px;"><table width="159" height="25" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td background="images/main/login_id.gif" style="padding-left:50px;">
                      <div align="left">
                        <input name='userId' onKeyDown="enter(document.login)" type="text" class="input1" id="m_id" >
                          </div></td></tr>
                </table></td>
                <td width="31%" style="padding-top:13px;">&nbsp;</td>
              </tr>
              <tr>
                <td style="padding-top:6px;"><table width="159" height="24" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td background="images/main/login_pw.gif" style="padding-left:50px;">
                        <div align="left">
                          <input name='password' onkeydown='enter(document.login)' type="password" class="input1" id="m_passwd">
                          </div></td></tr>
                </table></td>
                <td rowspan="2" valign="bottom" style="padding-top:24px;padding-left:15px;"><div align="left"><img src="images/main/login_go_bt.gif" onClick="FnLogin_Submit(document.login)"></div></td>
              </tr>
              <tr>
                <td style="padding-top:11px;"><img src="images/main/login_title01.gif" border="0"onClick="location.href='userform.php?mode=viewJoinForm'"></td>
              </tr>
          </table></td>
        </tr>
      </table>
	  </form>
	  	<%} %>
</div>
<!-------------------------------------------------로그인&로그아웃 레이어 끝-------------------------------------------------------->

<!-------------------------------------------------플래쉬시작-------------------------------------------------------->	
<center>		<textarea id="emb_01" style="display:none;" cols="0" rows="0">


<object

classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"

codebase=" http://fpdownload.adobe.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="968" height="396" align="middle">
<param name="movie" value="swf/main1.swf">
<param name="wmode" value="transparent">
<param name="allowScriptAccess" value="always">
<embed type="application/x-shockwave-flash"
pluginspage="http://www.adobe.com/go/getflashplayer"

width="968" height="396" align="middle"
src="swf/main1.swf"

allowScriptAccess="always"></embed>
</object>
</textarea>
<script language="javascript">WriteEmbed('emb_01')</script>
</center>
<!-------------------------------------------------플래쉬끝-------------------------------------------------------->

<!-------------------------------------------------긴급공지사항시작-------------------------------------------------------->
<div id="popup" style="position:absolute;left:50%;top:150px;width:950px;z-index:5;margin-left:-470px;visibility:hidden;background-color:darkred">
<table align="center" width="95%" cellpadding="0" cellspacing="0" style="margin-top:7px;">
<tr align="center">
<td width="10"></td>
<td width="*"><b style="color:white">공지사항</td>
<td width="10"></td>
</tr>
</table>

<table width="95%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #a8a8a8;">
<tr height="100%" valign="top"><td bgcolor="e0e0e0" style="padding:13px;">

    <%
    String context = Admin.POPUP;
    context = StringEscapeUtils.escapeHtml(context);
    context = context.replaceAll("\n", "<br>");
    out.print(context);
    %>

</td>
</tr>
<tr><td bgcolor="#a1a1a1">
    <table width="100%" style="color:#a1a1a1;">
    <tr>
        <td width="50%"><b style="color:black"></td>
        <td width="50%" align="right"><b style="color:black">
			오늘하루이창을열지않음 <input type="checkbox" id="popupcheck">
			닫기 <img src="img/x.gif" onClick="popupclose()">	
		</td>
    </tr></table>
</td></tr>
</table>
<br>
</div>
<!-------------------------------------------------긴급공지사항끝-------------------------------------------------------->

<!-------------------------------------------------긴급알림시작-------------------------------------------------------->
<!---<div id="memoDiv" style="padding:10 10 10 10;position:absolute;left:50%;top:50%;width:350px;height:350px;z-index:2;margin-left:-175px;margin-top:-175px;visibility:hidden;background-color:#CCCCCC;color:#000000">
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
	닫기 <img src="img/x.gif" onClick="memoClose()"/>
</td>
</tr>
</table>
</form>
</div>-->
<!-------------------------------------------------긴급알림끝-------------------------------------------------------->

<!-------------------------------------------------공지사항시작-------------------------------------------------------->
<table width="968" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="49" valign="middle" background="images/main/notice_top.gif">
	<table width="98%" border="0" cellpadding="0" cellspacing="0" style="margin-left:90px;margin-top:10px;">
      <tr>
        <td> <marquee onmouseover='this.stop()' onmouseout='this.start()'>
	             <%=Admin.NOTICE%>
				 </marquee>		</td>
      </tr>
    </table></td>
  </tr>
</table>
<!-------------------------------------------------공지사항끝--------------------------------------------------------->

<table width="968" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:13px;">
  <tr>
    <td width="235" valign="top">
	<img src="images/main/baner_title.jpg">
	<a href="http://www.premierleague.com" target="_blank">
	<img src="images/main/baner1.jpg" border="0"  style="margin-top:5px;"></a>
	
	<a href="http://mlb.mlb.com/index.jsp" target="_blank">
	<img src="images/main/baner2.jpg" border="0"  style="margin-top:5px;"></a>
	
	<a href="http://www.nba.com" target="_blank">
	<img src="images/main/baner3.jpg" border="0"  style="margin-top:5px;"></a>
	
	<a href="http://www.kleaguei.com" target="_blank">
	<img src="images/main/baner4.jpg"  style="margin-top:5px;"border="0" ></a>
	
	<a href="http://www.koreabaseball.com" target="_blank">
	<img src="images/main/baner5.jpg" border="0"  style="margin-top:5px;"></a>
	
	<a href="http://www.kbl.or.kr/" target="_blank">
	<img src="images/main/baner6.jpg" border="0"  style="margin-top:5px;"></a></td>
    <td width="33">&nbsp;</td>
	<!----------------------------승무패--------------------------->
    <td valign="top"><img src="images/main/title1.gif">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:4px;">
        <tr>
          <td><img src="images/main/title1_top.gif"></td>
        </tr>
        <tr>
          <td background="images/main/title1_center.gif">
          <table width="700" border="0" align="center" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
          <%
          for (Game game : wdlList) {
          %>
              <tr>
                <td class="mainlist" width="90" style="text-align:center"><%=XwinUtil.getBoardItemDate(game.getGameDate())%></td>
                <td class="mainlist" width="130" style="text-align:center"><%=game.getLeagueName()%></td>
                <td class="mainlist" width="180" style="text-align:right"><%=game.getHomeTeam()%></td>
                <td class="mainlist" width="70" style="text-align:center">
                <%
				if (game.getType().equals("wdl")) {
					if (game.getDrawRate()==0||game.getDrawDeny().equals("N"))
						out.print("x");
					else
						out.print(game.getDrawRateStr());
				} else {
					if (game.getDrawRate() > 0)
						out.print("+");
					out.print(game.getDrawRate());
				}
					
				%>                </td>
                <td class="mainlist" width="180" style="text-align:left"><%=game.getAwayTeam()%></td>
                <td class="mainlist" width="50" style="text-align:center"><%=Code.getValue(game.getStatus())%></td>
              </tr>
          <%
          }
          %>
          </table></td>
        </tr>
        <tr>
          <td><img src="images/main/title1_bottm.gif"></td>
        </tr>
      </table>
	  	<!----------------------------핸디캡--------------------------->
	  <img src="images/main/title2.gif" style="margin-top:16px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:4px;">
        <tr>
          <td><img src="images/main/title1_top.gif"></td>
        </tr>
        <tr>
          <td background="images/main/title1_center.gif"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
         <%
          for (Game game : handyList) {
          %>
              <tr>
                <td class="mainlist" width="90" style="text-align:center"><%=XwinUtil.getBoardItemDate(game.getGameDate())%></td>
                <td class="mainlist" width="130" style="text-align:center"><%=game.getLeagueName()%></td>
                <td class="mainlist" width="180" style="text-align:right"><%=game.getHomeTeam()%></td>
                <td class="mainlist" width="70" style="text-align:center">
                <%
				if (game.getType().equals("wdl")) {
					if (game.getDrawRate()==0||game.getDrawDeny().equals("N"))
						out.print("x");
					else
						out.print(game.getDrawRateStr());
				} else {
					if (game.getDrawRate() > 0)
						out.print("+");
					out.print(game.getDrawRate());
				}
					
				%>                </td>
                <td class="mainlist" width="180" style="text-align:left"><%=game.getAwayTeam()%></td>
                <td class="mainlist" width="50" style="text-align:center"><%=Code.getValue(game.getStatus())%></td>
              </tr>
          <%
          }
          %>
          </table></td>
        </tr>
        <tr>
          <td><img src="images/main/title1_bottm.gif"></td>
        </tr>
      </table>
    <DIV align=right></DIV></td>
  </tr>
</table>
<!-------------------------------------------------카피라이터--------------------------------------------------------->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="f4f4f4" style="margin-top:30px;">
   <tr>
    <td valign="middle"><table width="968" height="23" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="553">
        <a href="yakwan.php"><img src="images/main/copy_1.gif" border="0" /></a>
        <img src="images/main/copy_line.gif" />
        <a href="kyujung.php"><img src="images/main/copy_2.gif" border="0" /></a>
        </td>
        <td width="415"><div align="right"><img src="images/main/copy.gif" width="209" height="12" /></div></td>
      </tr>
    </table></td>
  </tr>
</table>
<script>
function enter(frm)
{
	if (event.keyCode == 13) {
		FnLogin_Submit(frm);
	}
}

function popupopen()
{
	var popup = document.getElementById("popup");
	popup.style.visibility = "visible"
}

function popupclose()
{
	var popup = document.getElementById("popup");
	var popupcheck = document.getElementById("popupcheck");
	popup.style.visibility = "hidden";

	if (popupcheck.checked) {
		setCookie("COOKIEFLAG", "N", 1);
	}		
}

function setCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie( name )
{
	var seoroopCookie = name + "=";
	var i = 0;
	while ( i <= document.cookie.length )
	{
 		var e = (i+seoroopCookie.length);
 		if ( document.cookie.substring( i, e ) == seoroopCookie ) {
 			if ( (popendCookie=document.cookie.indexOf( ";", e )) == -1 )
 				popendCookie = document.cookie.length;
				return unescape( document.cookie.substring( e, popendCookie ) );
 			}
 			i = document.cookie.indexOf( " ", i ) + 1;
		if ( i == 0 )
			break;
	}
	return "";
}


var POPUPFLAG = "<%=Admin.POPUPFLAG%>";
var COOKIEFLAG = getCookie("COOKIEFLAG");

if (POPUPFLAG == "Y" && COOKIEFLAG == "" && <%=login%> == true)
{
	popupopen();
}

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
</center>

</body>

</html>