<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String type = XwinUtil.nvl(request.getParameter("type"));
	String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
	if (gameDate == null)
		gameDate = XwinUtil.toDateStr(new Date(), 2);
	
	Calendar cal = Calendar.getInstance();
	String[] dateList = new String[7]; 
	
	for (int i = 0 ; i < dateList.length ; i++) {
		dateList[i] = XwinUtil.toDateStr(cal.getTime(), 2);
		cal.add(Calendar.DATE, -1);
	}
%>

<%@include file="../header.jsp"%>
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<form name="frm">
<input type="hidden" name="mode" value="viewGameResultList"/>
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">

	<table width="900" style="border-bottom:1 solid #909090;">

	<tr><td width="100"><img src="images/title_gameresult.gif"></td><td>지난 경기 결과입니다.<br>(최근 7일까지만 제공됩니다.)</td></td>
	<td align="right">
		<table cellpadding="0" cellspacing="0">
		<tr>
			<td>
			경기종류:
			<select name="type" style="color:white;background-color:black;" onchange="frm.submit();">
				<option value="">--전체--</option>
				<option value='wdl' <%=type.equals("wdl")?"selected":""%> style='color:#b0b0b0;'>승무패</option>
				<option value='handy' <%=type.equals("handy")?"selected":""%> style='color:#b0b0b0;'>핸디캡</option>
			</select>
			</td>
			<td>
			경기일자 :
				<select name="gameDate" style="color:white;background-color:black;" onchange="frm.submit();">
				<option value="">---전체---</option>
				<%
				for (int i = 0 ; i < dateList.length ; i++) {
				%>		
					<option value="<%=dateList[i]%>" <%=gameDate.equals(dateList[i])?"selected":""%>><%=dateList[i]%></option>
				<%
				}
				%>				
				</select>&nbsp;
			</td>
			<td>
			리그선택
			<select name='leagueId' onChange='this.form.submit()' style="color:white;background-color:black;">
				<option value=''>전체</option>
				<%
				if (leagueList != null) {
					for (League league : leagueList) {						
				%>
				<option value='<%=league.getId()%>' <%=leagueId.equals(league.getId())?"selected":""%>> <%=league.getName()%> </option>
				<%
					}
				}
				%>
			</select>
			</td>

			<td><img src="images/btn_reload.gif" onclick="location.href=location.href;" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
		</tr></table>
	</td>
	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424242>
		<tr bgcolor=212021 height=27>
			<td  width=270 align=center ><nobr><font color=FFFFFF><b>경기일시</td>
			<td  width=200 align=center ><nobr><font color=FFFFFF><b>리그</td>
			<td  width=500 align=center ><nobr><font color=FFFFFF><b>(승)홈 팀</td>
			<td  width=130 align=center ><nobr><font color=FFFFFF><b>무/핸디캡</td>
			<td  width=500 align=center ><nobr><font color=FFFFFF><b>(패)원정팀</td>
			<td  width=210 align=center ><nobr><font color=FFFFFF><b>경기결과</td>
		</tr>

<%
if (gameList != null) {
	for (Game game : gameList) {
		
%>																								
		<tr height=25 bgcolor=000000>
			<td align=center  ><nobr><%=game.getGameDateStr()%></td>
			<td align=center ><nobr><img width=22 height=14 src="images/league/<%=game.getLeagueImage()%>" align=absmiddle>
			<font color="#ffffff"><%=game.getLeagueName()%></font></td>
			<td align=right >
				<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=424142>
					<tr>
						<td align=right width=100%><nobr><font color="#ffffff"><%=game.getHomeTeam()%></font></td>
						<td align=right width=30>&nbsp;<%=game.getWinRateStr()%>&nbsp;</td>
						<td align=right width=10>
						</td>
					</tr>
				</table>
			</td>
			<td align=center align=center><nobr>
				<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=424142>
					<tr>
						<%if (game.getType().equals("wdl")){%>
						<td align=center ><nobr><%=game.getDrawRateStr()%></td>
						<%} else { %>
						<td align=center ><nobr><%=game.getDrawRate()>0?"+":""%><%=game.getDrawRate()%></td>
						<%}%>
					</tr>
				</table>
			</td>
			<td align=left >
				<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=424142>
					<tr>
						<td width=20><nobr></td>
						<td width=30>&nbsp;<%=game.getLoseRateStr()%>&nbsp;</td>
						<td ><nobr><font color="#ffffff"><%=game.getAwayTeam()%></font></td>
						
					</tr>
				</table>
			</td>
			<td align=center ><nobr>
			<%if (game.getStatus().equals(Code.GAME_STATUS_END)) { %>
			<%=game.getHomeScore()%> : <%=game.getAwayScore()%>
			&nbsp;
			<%=Code.getValue(game.getResult())%>
			<%} else { %>
			<%=Code.getValue(game.getStatus())%>
			<%}%>
			</td>
		</tr>

<%
	}
}
%>
	</table>

</td></tr>
</table>
</form>


<%@include file="../footer.jsp"%>