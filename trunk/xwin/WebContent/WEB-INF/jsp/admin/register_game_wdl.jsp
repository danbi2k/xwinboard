<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.game.*" %>

 <%@include file="header.jsp"%>

<%
List<League> leagueList = (List<League>)request.getAttribute("leagueList");
%>
<h3>게임등록</h3> 

<form name="registerGame" method="post">
<table>
	<tr>
		<td>리그</td>
		<td>
			<select name="leagueId">
				<%
					if (leagueList != null && leagueList.size() > 0) {
						for (League league : leagueList) {
				%>
					<option value=<%=league.getId()%>><%=league.getName()%></option>
				<%
						}
					}
				%>
			</select>
	</tr>
	<tr>
		<td>홈팀명</td>
		<td><input name="homeTeam" type="text" value="팀1"></td>
	</tr>
	<tr>
		<td>원정팀명</td>
		<td><input name="awayTeam" type="text" value="팀2"></td>		
	</tr>
	<tr>
		<td>승</td>
		<td><input name="winRate" type="text" value="1.1"></td>
	</tr>
	<tr>
		<td>무</td>
		<td><input name="drawRate" type="text" value="1.2"></td>
	</tr>
	<tr>
		<td>패</td>
		<td><input name="loseRate" type="text" value="1.3"></td>
	</tr>
	<tr>
		<td>일시</td>
		<td>
			<select name="year">
				<option value="2008">2008</option>
				<option value="2009">2009</option>
			</select>
			<select name="month" id="monthSelect">
			</select>
			<select name="date" id="dateSelect">
			</select>
			<select name="hour" id="hourSelect">
			</select>
			<select name="minute" id="minSelect">
			</select>
		</td>
	</tr>
</table>
</form>
<br>
<a onclick="AdminGame.RegisterGame(registerGame, 'wdl')">등록</a>
<script>
function init()
{
	var monthSelect = document.getElementById("monthSelect");
	var dateSelect = document.getElementById("dateSelect");
	var hourSelect = document.getElementById("hourSelect");
	var minSelect = document.getElementById("minSelect");
	
	makeSeqOption(monthSelect, 1, 12, 1);
	makeSeqOption(dateSelect, 1, 31, 1);
	makeSeqOption(hourSelect, 0, 23, 1);
	makeSeqOption(minSelect, 0, 59, 5);
}

function makeSeqOption(oobj, start, end, diff)
{
	var options = [];
	for (var i = start ; i <= end ; i+=diff) {
		var opt = new Option();
		opt.value = i;
		opt.text = i;
		oobj.options.add(opt);
	}
} 

</script>

 <script>
 init();
 </script>
 <%@include file="footer.jsp"%>