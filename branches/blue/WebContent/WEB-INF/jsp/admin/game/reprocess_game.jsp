<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	Game game = (Game) request.getAttribute("game");
	String type = request.getParameter("type");	
	String grade = request.getParameter("grade");
%>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
<div class="title"><%=grade.equals(Code.USER_GRADE_VIP)?"스페셜":type.equals("wdl")?"승무패":"핸디캡"%>경기 재처리</div>
<form method='post' name='repGame'>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
		<td bgcolor="#FFFFFF"  colspan=3><%=game.getLeagueName()%></td>
	</tr>		
 	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">게임시간</td>
		<td bgcolor="#FFFFFF"  colspan=3><%=game.getGameDateStr()%></td>
	</tr>		
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">홈팀</td>
		<td bgcolor="#FFFFFF" width=35%><%=game.getHomeTeam()%></td>
 		<td align="center" bgcolor="E7E7E7" width="15%">원정팀</td>
		<td bgcolor="#FFFFFF" width="35%"><%=game.getAwayTeam()%></td>
	</tr>	
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">배당률</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			승  : <%=game.getWinRateStr()%><BR>
			<%if (type.equals("wdl")) {%>
			무  : <%=game.getDrawRateStr()%><BR>
			<%} else { %>
			핸디 : <%=game.getDrawRate()>0?"+":""%><span id="handy" value='<%=game.getDrawRate()%>'><%=game.getDrawRate()%></span><BR>
			<%} %>
			패  : <%=game.getLoseRateStr()%><BR>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">상태</td>
		<td bgcolor="#FFFFFF"  colspan=3><%=Code.getValue(game.getStatus())%></td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">결과</td>
		<td bgcolor="#FFFFFF"  colspan=3><span id="resultSpan"><%=Code.getValue(game.getResult())%></span></td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">스코어</td>
		<td bgcolor="#FFFFFF"  colspan=3>
		<%
		if (game.getStatus().equals(Code.GAME_STATUS_END)) {
		%>	
			<%=game.getHomeTeam()%>  <input onkeyup='calcResult()' type='text' name='homeScore' size=5 value='<%=XwinUtil.nvl(game.getHomeScore())%>'> : 
			<input onkeyup='calcResult()' type='text' name='awayScore' size=5 value='<%=XwinUtil.nvl(game.getAwayScore())%>'> <%=game.getAwayTeam()%>
		<%
		} else if (game.getStatus().equals(Code.GAME_STATUS_CANCEL)) {
		%> 
		스코어 없음
		<%
		}
		%> 						
		</td>
	</tr>		
 </table>
</form>
<BR>
<table width="2%"  border="0" cellspacing="5" cellpadding="0">
	<tr>
		<%
		if (game.getStatus().equals(Code.GAME_STATUS_END)) {
		%>
	     <td><input type="button" value="재처리" onclick="reprocessGame()"></td>
		<%
		}
		%> 
		<%
		if (game.getStatus().equals(Code.GAME_STATUS_CANCEL)) {
		%>
		 <td><input type="button" value="복구" onclick="recoverGame()"></td>                              
		<%
		}
		%>
	     <td><input type="button" value="취소" onclick="history.back()"></td>
	</tr>
</table>

<script>
function reprocessGame()
{
	var frm = document.repGame;
	var homeScore = frm.homeScore.value;
	var awayScore = frm.awayScore.value;

	if (!homeScore || !awayScore) {
		alert("스코어를 입력하세요");
	}

	var query="mode=reprocessGame";
	query += "&homeScore=" + homeScore;
	query += "&awayScore=" + awayScore;
	query += "&id=<%=game.getId()%>";
	query += "&type=<%=game.getType()%>";
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	alert (result.resultXml.message);
}

function recoverGame()
{
	var frm = document.repGame;

	var query="mode=recoverGame";
	query += "&id=<%=game.getId()%>";
	query += "&type=<%=game.getType()%>";
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	alert (result.resultXml.message);
}

function calcResult()
{
	if ((event.keyCode>=48 && event.keyCode<=57) || event.keyCode==13 || event.keyCode==8) {
		var homeScore = document.getElementById("homeScore").value;
		var awayScore = document.getElementById("awayScore").value;
		var handySpan = document.getElementById("handy");

		var handy = 0;
		if (handySpan != undefined)
			handy = handySpan.value;
		
		var resultSpan = document.getElementById("resultSpan");

		if (handy == undefined)
			handy = 0;

		if (homeScore == '' || awayScore == '') {
			return;
		}

		var hScore = parseInt(homeScore) + parseFloat(handy);
		var aScore = parseInt(awayScore);

		if (hScore < aScore)
			resultSpan.innerHTML = "패";
		else if (hScore == aScore)
			resultSpan.innerHTML = "무";
		else
			resultSpan.innerHTML = "승";
	}
}
</script>
<%@ include file="../admin_footer.jsp"%>