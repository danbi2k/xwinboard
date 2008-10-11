<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	request.setAttribute("isIndex", Boolean.TRUE);
%>

<%@ page import="java.util.*"%>

<%@include file="header.jsp"%>

<div id="popup" style="position:absolute;left:150px;top:150px;width:950;z-index:1;visibility:hidden;background-color:#111111">
<table align="center" width="95%" cellpadding="0" cellspacing="0" style="margin-top:7px;">
<tr align="center">
<td width="10"><img src="images/title_left.gif"></td>
<td width="*" background="images/title_bg.gif"><b style="color:white">긴급공지</td>
<td width="10"><img src="images/title_right.gif"></td>
</tr>
</table>

<table width="95%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #4a4a4a;">
<tr height="100%" valign="top"><td style="padding:13px;" bgcolor="#555555" style="color:black;">

    <%
    String context = Admin.POPUP;
    context = StringEscapeUtils.escapeHtml(context);
    context = context.replaceAll("\n", "<br>");
    out.print(context);
    %>

</td></tr>
<tr><td bgcolor="#525252">
    <table width="100%" style="color:#8b8b8b;">
    <tr>
        <td width="50%"><b style="color:black">작성자 : <b>관리자</b></td>
        <td width="50%" align="right"><b style="color:black">
			오늘하루이창을열지않음 <input type="checkbox" id="popupcheck">
			닫기 <img src="images/btn_coment_del.gif" onclick="popupclose()">	
		</td>
    </tr></table>
</td></tr>
</table>
&nbsp;
</div>
<script>
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

if (POPUPFLAG == "Y" && COOKIEFLAG == "")
{
	popupopen();
}

</script>
<table width="960" cellpadding="5">
<tr><td valign="top">

<!--############################################################//-->
<table width="500" height="350" cellpadding="5" style="border:1 solid #909090" bgcolor="#0a0a0a">
<tr><td valign="top" align="center">

<table width="100%" style="border-bottom:1 solid #909090;margin-bottom:5px;">
<tr><td><img src="images/main_list_title.gif"></td>
	<td align="right"><a href="game.aspx?mode=viewGameList&type=wdl">전체목록</a></td>
</tr>
</table>

<table width="100%">

<%
	if (gameList != null) {
		for (Game game : gameList) {
			
%>
	<tr><td width="70" align="center"><%=game.getGameDateStr().substring(3)%></td>
		<td align="left">
			<table cellpadding="0" cellspacing="2">
			<tr><td><img src="images/league/<%=game.getLeagueImage()%>" style="display:none" onload="this.style.display='';">&nbsp;&nbsp;</td>
				<td><%=game.getLeagueName()%></td></tr>
			</table>
		</td>
		<td align="right"><%=game.getHomeTeam()%></td>
		<td align="center"><font color="#ffb239">VS</font></td>
		<td align="left"><%=game.getAwayTeam()%></td>
		</td>
	</tr>
<%
		}
	}
%>
</table>

</td></tr>
</table>
<!--############################################################//-->
</td><td valign="top">
<!--############################################################//-->

<!--
<table width="440" height="150" cellpadding="5" style="border:1 solid #909090" bgcolor="#0a0a0a">
<tr><td valign="top" align="center">

<table width="100%" style="border-bottom:1 solid #909090;margin-bottom:5px;">
<tr><td><img src="images/main_notice_title.gif"></td>
	<td align="right"><a href="board/notice.asp?idx=notice">전체목록</a></td>
</tr>
</table>

<table width="100%">

	<tr><td width="*" align="left"><a href="board/notice.asp?idx=notice&no="></a></td></tr>

</table>

//-->


	<img src="images/main_banner.gif">

<table cellpadding="0" cellspacing="0" style="margin-top:5;">
<tr><td><img src="images/main_banner_07.gif"></td>
	<td><img src="images/main_banner_08.gif"></td></tr>
<tr><td><img src="images/main_banner_09.gif"></td>
	<td><img src="images/main_banner_10.gif"></td></tr>
<tr>
	<td><img src="images/livescore.jpg" onclick="location.href='livescore.aspx'"></td>
	<td></td>
</tr>
</table>

<!--############################################################//-->


</td></tr>
</table>

<%@include file="footer.jsp"%>