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
<div class='sub_ti1'>
		<img src='img/sub_gameresult_ti.gif' alt='이용약관' class='ml10 mr10 fl'> 
		<div class='sub_ti_desc'></div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='betlog.php?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>

		</div>


		<div id='sub_content1'>
			<div class='game_result'>				
				<div class='league_select'>
					<form name="frm">
					<input type="hidden" name="mode" value="viewGameResultList"/>
					경기종류:
					<select name='type' onchange='frm.submit();'>
					<option value="">--전체--</option>
					<option value='wdl' <%=type.equals("wdl")?"selected":""%> style='color:#b0b0b0;'>승무패</option>
					<option value='handy' <%=type.equals("handy")?"selected":""%> style='color:#b0b0b0;'>핸디캡</option>
					</select>
					경기일자 :
					<select name='gameDate' onchange='frm.submit();'>
					<option value="">---전체---</option>
					<%
					for (int i = 0 ; i < dateList.length ; i++) {
					%>		
						<option value="<%=dateList[i]%>" <%=gameDate.equals(dateList[i])?"selected":""%>><%=dateList[i]%></option>
					<%
					}
					%>	
					</select>
					<img src='img/sub_reload_bt.gif' alt='새로고침' class='img_bt' onclick="frm.submit()">
					</form>
				</div>
				<!-- end league_select -->

				<div class='list_box'>
					<table>
						<tr><th class='t1'>경기일시</th><th class='t2'>리그</th><th class='t3'>(승) 홈팀</th><th class='t4'>무/핸디캡</th><th class='t5'>(패) 원정팀</th><th class='t6'>경기결과</th></tr>
						<%
						if (gameList != null) {
							for (Game game : gameList) {
								
						%>
						<tr>
							<td><%=XwinUtil.getBoardItemDate(game.getGameDate())%></td>
							<td><img width=22 height=14 src="images/league/<%=game.getLeagueImage()%>"> <%=game.getLeagueName()%></td>
							<td style='text-align:right'><%=game.getHomeTeam()%>&nbsp;&nbsp;&nbsp;x<%=game.getWinRateStr()%>&nbsp;</td>
							<td>
								<%if (game.getType().equals("wdl")) {
									out.print("x" + game.getDrawRateStr());
								} else {
									out.print(game.getDrawRate()>0?"+":"");
									out.print(game.getDrawRate());
								}%>
							</td>
							<td style='text-align:left'>&nbsp;x<%=game.getLoseRateStr()%>&nbsp;&nbsp;&nbsp;<%=game.getAwayTeam()%></td>
							<td>
								<%if (game.getStatus().equals(Code.GAME_STATUS_END)) {
								out.print(game.getHomeScore() + " : " + game.getAwayScore() + " " + Code.getValue(game.getResult()));
								} else {
								out.print(Code.getValue(game.getStatus()));
								}%>								
							</td>
						</tr>
						<%
							}
						}
						%>
					</table>

				</div>
				<!-- end list_box -->




			
			</div>
		</div>
		<!-- sub_content1 -->


<%@include file="../footer.jsp"%>