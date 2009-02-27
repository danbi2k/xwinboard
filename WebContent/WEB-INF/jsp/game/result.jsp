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
			<tr><td><img src="img/menu06.jpg" border="0"></td></tr>
		
            </table>
			 <table align="center" cellpadding="0" cellspacing="0" width="887" height="40">
			<tr>
			  <td class="scoretable" align="right">
				<form name="frm">
				<input type="hidden" name="mode" value="viewGameResultList"/>
				경기일자&nbsp;
				<select name="gameDate" onchange="frm.submit();">
				<%
				for (int i = 0 ; i < dateList.length ; i++) {
				%>		
					<option value="<%=dateList[i]%>" <%=gameDate.equals(dateList[i])?"selected":""%>><%=dateList[i]%></option>
				<%
				}
				%>
				</select>&nbsp; <img src="img/find.jpg" border="0" align="absbottom">&nbsp;
				</form>
			</td>	
			</tr>  
			
             <table align="center" cellpadding="0" cellspacing="0" width="887" height="40" background="	img/bar.jpg">
    <tr>
        <td width="90" height="40" align="center" valign="middle" class="menubar">
            <p>경기일시</p>
        </td>
        <td width="155" height="40" align="center" valign="middle" class="menubar">
            <p>리그</p>
        </td>
        <td width="240" height="40" align="center" valign="middle" class="menubar">
            <p>승(홈팀)</p>
        </td>
        <td width="80" height="40" align="center" valign="middle" class="menubar">
            <p>무/핸디</p>
        </td>
        <td width="240" height="40" align="center" valign="middle" class="menubar">
            <p>패(원정팀)</p>
        </td>
        <td width="80" height="40" align="center" valign="middle" class="menubar">
            <p>경기결과</p>
        </td>
       
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="887">
<%
if (gameList != null) {
	for (Game game : gameList) {
		
%>	  
    <tr>
        <td width="90" class="tablebg1" align="center" valign="middle">
            <p><%=XwinUtil.getBoardItemDate(game.getGameDate())%></p>
        </td>
        <td width="155" class="tablebg2" align="left" valign="middle">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;<img width=22 height=14 src="images/league/<%=game.getLeagueImage()%>"> <%=game.getLeagueName()%></p>
        </td>
        <td width="240" class="tablebg1" align="right" valign="middle">
            <p><%=game.getHomeTeam()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=game.getWinRateStr()%>&nbsp;</p>
        </td>
        <td width="80" class="tablebg2" align="center" valign="middle">
            <p><%
				if (game.getType().equals("wdl"))
					out.print(game.getDrawRateStr());
				else {
					if (game.getDrawRate() > 0)
						out.print("+");
					out.print(game.getDrawRate());
				}
					
			%></p>
        </td>
        <td width="240" class="tablebg1"" align="left" valign="middle">
            <p>&nbsp;&nbsp;&nbsp;<%=game.getLoseRateStr()%>&nbsp;&nbsp;&nbsp;<%=game.getAwayTeam()%></p>
        </td>
        <td width="80" class="tablebg2" align="center" valign="middle">
            <p><%if (game.getStatus().equals(Code.GAME_STATUS_END)) { %>
			<%=game.getHomeScore()%> : <%=game.getAwayScore()%>
			&nbsp;
			<%=Code.getValue(game.getResult())%>
			<%} else { %>
			<%=Code.getValue(game.getStatus())%>
			<%}%></p>
        </td>
  
    </tr>
<%
	}
}
%>	
    
</table>

    <table align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="40" >
           
        </td>
    </tr>
   
  </table>


<%@include file="../footer.jsp"%>