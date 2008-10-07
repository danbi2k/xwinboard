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
	String gameDate = XwinUtil.nvl(request.getParameter("gameDate"));
	
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

	<table width="900" bgcolor="#d9d8d6" cellspacing="1" cellpadding="3">
	<colgroup>
		<col align="center" width="100">

		<col align="center" width="*">
		<col align="center" width="180">
		<col align="center" width="180">
		<col align="center" width="70">
		<col align="center" width="50">
	</colgroup>

	<tr bgcolor="#ce892c" height="34">
		<td style="color:white;"><b>경기일시</td>
		<td style="color:white;"><b>리그</td>
		<td style="color:white;"><b>홈팀</td>
		<td style="color:white;"><b>원정팀</td>
		<td style="color:white;"><b>Score</td>
		<td style="color:white;"><b>결과</td>
	</tr>


<%
if (gameList != null) {
	for (Game game : gameList) {
		
%>
	<tr height="34" bgcolor="#0a0a0a">
		<td><%=game.getGameDateStr()%></td>
		<td align="left">
			<table cellpadding="0" cellspacing="2"><tr><td><img src="images/league/<%=game.getLeagueImage()%>" style="display:none" onload="this.style.display='';"></td>
			<td>&nbsp;<%=game.getLeagueName()%></td>
			<td style="color:darkorange">&nbsp;<%=game.getType().equals("wdl")?"승무패":"핸디캡" %></td></tr>

			</table>
		</td>
		<td><%=game.getHomeTeam()%></td>
		<td><%=game.getAwayTeam()%></td>

		<td>
		<%
		if (game.getType().equals("wdl")) {
		%>
		<%=game.getHomeScore()%> : <%=game.getAwayScore()%>
		<%
		} else {
			double homeScoreDouble = (double) game.getHomeScore();
			homeScoreDouble += game.getDrawRate();
		%>		
		<%=homeScoreDouble%> : <%=game.getAwayScore()%>
		<%
		}		
		%>
		</td>
		<td style="color:orange">
			<%=Code.getValue(game.getResult())%>
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