<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	request.setAttribute("isIndex", Boolean.TRUE);
%>

<%@ page import="java.util.*"%>

<%@include file="header.jsp"%>


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