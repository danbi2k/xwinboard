<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Game game = (Game) request.getAttribute("game");	
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");	
	String pageIndex = request.getParameter("pageIndex");
%>
<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.registerGame;
		if(!d.leagueName.value) { alert('리그명을 선택하세요'); d.leagueName.focus(); return false; }
		//if(!d.gamedate.value) { alert('게시일을 선택하세요'); d.gamedate.focus(); return false; }f
		if(!d.gameDate.value) { alert('경기 시작 시각(일자)을 선택하세요'); d.gameDate.focus(); return false; }
		if(!d.gameHour.value) { alert('경기 시작 시각(시)을 선택하세요'); d.gameHour.focus(); return false; }
		if(!d.gameMinute.value) { alert('경기 시작 시각(분)을 선택하세요'); d.gameMinute.focus(); return false; }
		//if(!d.gametime4.value) { alert('경기 시작 시각(초)을 선택하세요'); d.gametime4.focus(); return false; }
		if(!d.homeTeam.value) { alert('홈팀명을 입력하세요'); d.homeTeam.focus(); return false; }
		if(!d.winRate.value) { alert('홈팅 배당률을 입력하세요'); d.winRate.focus(); return false; }		
		if(!d.awayTeam.value) { alert('원정팀명을 입력하세요'); d.awayTeam.focus(); return false; }
		if(!d.loseRate.value) { alert('원정팀명 배당률을 입력하세요'); d.loseRate.focus(); return false; }
		if(!d.drawRate.value) { alert('무승부 배당률을 입력하세요'); d.drawRate.focus(); return false; }
		/*
		if(d.gametype_set.value=='1x2') {
			if(!d.x_by.value) { alert('무승부 배당률을 입력하세요'); d.x_by.focus(); return false; }
		}
		else {
			if(!d.handicap_title.value) { alert('핸디캡을 입력하세요'); return false; }
		}*/

		var query = "mode=updateGame";
		query += "&gameId=" + <%=game.getId()%>;
		query += "&leagueName=" + d.leagueName.value;
		query += "&gameDate=" + d.gameDate.value;
		query += "&gameHour=" + d.gameHour.value;
		query += "&gameMinute=" + d.gameMinute.value;
		query += "&homeTeam=" + d.homeTeam.value;
		query += "&winRate=" + d.winRate.value;
		query += "&awayTeam=" + d.awayTeam.value;
		query += "&loseRate=" + d.loseRate.value;
		query += "&drawRate=" + d.drawRate.value;
		query += "&note=" + Xwin.Escape(d.note.value);
		if (d.winDeny.checked)
			query += "&winDeny=N";
		else
			query += "&winDeny=Y";
		if (d.drawDeny.checked)
			query += "&drawDeny=N";
		else
			query += "&drawDeny=Y";
		if (d.loseDeny.checked)
			query += "&loseDeny=N";
		else
			query += "&loseDeny=Y";		

		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.href = "adminGame.aspx?mode=viewGameList&type=<%=type%>&id=<%=game.getId()%>&grade=<%=game.getGrade()%>&pageIndex=<%=pageIndex%>";
		}
	}
</SCRIPT>
<div class="title"><%=type.equals("wdl")?(grade.equals(Code.USER_GRADE_NORMAL)?"승무패경기수정":"이벤트경기수정"):"핸디캡경기수정"%></div>

※ 팀명에 update, select, delete, create, alter 라는 문자열은 사용하지 마세요
<form method='post' name='registerGame'>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<select name='leagueName'>
			<%
			if (leagueList != null) {
				for (League league : leagueList) {
					
			%>
				<option value='<%=league.getName()%>' <%=game.getLeagueName().equals(league.getName())?"selected":""%>> <%=league.getName()%> </option>
			<%
				}
			}
			%>
			</select>
		</td>
	</tr>		
 	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">게임시간</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type='text' name='gameDate' size=10 readonly value='<%=XwinUtil.toDateStr(game.getGameDate(), 2)%>' onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
			<select name='gameHour'>
			<%
			String gameHour = game.getGameHour();
			for (int i = 0 ; i < 24 ; i++) {
				String hour = "" + i;
			%>
			<option value='<%=hour%>' <%=hour.equals(gameHour)?"selected":""%>><%=XwinUtil.Int2Digit(i)%></option>
			<%
			}
			%>
			</select>
			시
			<select name='gameMinute'>
			<%
			String gameMinute = game.getGameMinute();
			for (int i = 0 ; i < 60 ; i+=5) {
				String minute = "" + i;
			%>
			<option value='<%=minute%>' <%=minute.equals(gameMinute)?"selected":""%>><%=XwinUtil.Int2Digit(i)%></option>
			<%
			}
			%>
			</select>
		</td>
	</tr>		
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">홈팀</td>
		<td bgcolor="#FFFFFF" width=35%>
			팀명 <input type='text' name='homeTeam' value="<%=game.getHomeTeam()%>"/>
		</td>
 		<td align="center" bgcolor="E7E7E7" width="15%">원정팀</td>
		<td bgcolor="#FFFFFF" width="35%">
			팀명 <input type='text' name='awayTeam' value="<%=game.getAwayTeam()%>"/>
		</td>
	</tr>	
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">배당률</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			승 <input type='text' name='winRate' size=5 value='<%=game.getWinRateStr()%>'/>
			<%if (type.equals("wdl")) {%>
			무 <input type='text' name='drawRate' size=5 value='<%=game.getDrawRateStr()%>'/>
			<%} else { %>
			핸디<input type='text' name='drawRate' size=5 value='<%=game.getDrawRate()>0?"+"+game.getDrawRate():game.getDrawRate()%>'/>
			<%} %>
			패 <input type='text' name='loseRate' size=5 value='<%=game.getLoseRateStr()%>'>											
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">배팅차단</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			승 <input type='checkbox' name='winDeny' value="N" <%=game.getWinDeny().equals("Y")?"":"checked" %>>
			무 <input type='checkbox' name='drawDeny' value="N" <%=game.getDrawDeny().equals("Y")?"":"checked" %>>
			패 <input type='checkbox' name='loseDeny' value="N" <%=game.getLoseDeny().equals("Y")?"":"checked" %>>
			(체크하신 승/무/패 가 배팅이 차단됩니다)											
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">공지</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<textarea name="note" style="width:100%;height:100"><%=XwinUtil.nvl(game.getNote())%></textarea>								
		</td>
	</tr>	
 </table>
</form>
<BR>
<table width="2%"  border="0" cellspacing="5" cellpadding="0">
	<tr>
	     <td><input type='image' src="images/admin/but_input.gif" border="0" onclick="checkIT()"></td>                               
	     <td><img src="images/admin/but_cancel.gif" border="0" onClick="history.back()" style="cursor:hand"></td>
	</tr>
</table>
<!-- 페이지 내용 -->
<%@ include file="../admin_footer.jsp"%>