<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");
%>
<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.registerGame;
		var gameType
		<%if (type.equals("mix")) {%>
		if (d.gameType[0].checked)
			gameType = d.gameType[0].value;
		else if (d.gameType[1].checked)
			gameType = d.gameType[1].value;
		<%} else {%>
		gameType = '<%=type%>';
		<%}%>
		if(!d.leagueName.value) { alert('리그명을 선택하세요'); d.leagueName.focus(); return false; }
		//if(!d.gamedate.value) { alert('게시일을 선택하세요'); d.gamedate.focus(); return false; }f
		if(!d.gameDate.value) { alert('경기 시작 시각(일자)을 선택하세요'); d.gameDate.focus(); return false; }
		if(!d.gameHour.value) { alert('경기 시작 시각(시)을 선택하세요'); d.gameHour.focus(); return false; }
		if(!d.gameMinute.value) { alert('경기 시작 시각(분)을 선택하세요'); d.gameMinute.focus(); return false; }
		//if(!d.gametime4.value) { alert('경기 시작 시각(초)을 선택하세요'); d.gametime4.focus(); return false; }
		if(!d.homeTeam.value) { alert('홈팀명을 입력하세요'); d.homeTeam.focus(); return false; }		
		if(!d.awayTeam.value) { alert('원정팀명을 입력하세요'); d.awayTeam.focus(); return false; }
		if(!d.winRate.value) { d.winRate.value = 0.0; }
		if(!d.loseRate.value) { d.loseRate.value = 0.0; }
		if(!d.drawRate.value) { d.drawRate.value = 0.0; }
		if (!gameType) { alert('종류를 선택하세요');  return false;}
		<%if (type.equals("handy")){ %>
		if (d.uoCheck.checked) {
			if(!d.underRate.value) { alert('언더 배당률을 입력하세요'); d.underRate.focus(); return false; }
			if(!d.handyRate.value) { alert('핸디 배당률을 입력하세요'); d.handyRate.focus(); return false; }
			if(!d.overRate.value) { alert('오버 배당률을 입력하세요'); d.overRate.focus(); return false; }
		}
		<%}%>

		var query = "mode=registerGame";
		query += "&type=" + gameType;
		query += "&grade=<%=grade%>";
		query += "&leagueName=" + d.leagueName.value;
		query += "&gameDate=" + d.gameDate.value;
		query += "&gameHour=" + d.gameHour.value;
		query += "&gameMinute=" + d.gameMinute.value;
		query += "&homeTeam=" + d.homeTeam.value;
		query += "&awayTeam=" + d.awayTeam.value;
		query += "&winRate=" + d.winRate.value;
		query += "&loseRate=" + d.loseRate.value;
		query += "&drawRate=" + d.drawRate.value;
		<%if (type.equals("handy")){ %>
		query += "&underRate=" + d.underRate.value;
		query += "&handyRate=" + d.handyRate.value;
		query += "&overRate=" + d.overRate.value;
		query += "&uoCheck=" + d.uoCheck.checked;
		<%}%>
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
			d.homeTeam.value = '';
			d.awayTeam.value = '';
			d.winRate.value = '';
			d.loseRate.value = '';
			d.drawRate.value = '';
			d.winDeny.checked = false;
			d.drawDeny.checked = false;
			d.loseDeny.checked = false;
			<%if (type.equals("handy")){ %>
			d.underRate.value = '';
			d.handyRate.value = '';
			d.overRate.value = '';
			d.uoCheck.checked = false;
			<%}%>
		}	
	}
</SCRIPT>
<div class="title"><%=grade.equals(Code.USER_GRADE_VIP)?"이벤트경기등록":type.equals("wdl")?"승무패경기등록":"핸디캡경기등록"%></div>

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
				<option value='<%=league.getName()%>' > <%=league.getName()%> </option>
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
			<input type='text' name='gameDate' size=10 readonly onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
			<select name='gameHour'>
			<%
				for (int i = 0 ; i < 24 ; i++) {
					String hour = "" + i;
			%>
				<option value='<%=hour%>'><%=XwinUtil.Int2Digit(i)%></option>
			<%
				}
			%>
			</select>
			시
			<select name='gameMinute'>
			<%
				for (int i = 0 ; i < 60 ; i+=5) {
					String minute = "" + i;
			%>
				<option value='<%=minute%>'><%=XwinUtil.Int2Digit(i)%></option>
			<%
				}
			%>
			</select>
		</td>
	</tr>
	<%if (type.equals("mix")) { %>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">종류</td>
		<td bgcolor="#FFFFFF" width=35% colspan='3'>
			승무패 <input type='radio' name="gameType" value="wdl"/>
			핸디캡<input type='radio' name="gameType" value="handy"/>
		</td>
	</tr>			
	<%} else { %>
		<input type='hidden' name="type" value="<%=type%>"/>
	<%} %>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">홈팀</td>
		<td bgcolor="#FFFFFF" width=35%>팀명 <input type='text' name="homeTeam"/></td>
	 	<td align="center" bgcolor="E7E7E7" width="15%">원정팀</td>
		<td bgcolor="#FFFFFF" width="35%">팀명 <input type='text' name="awayTeam"/></td>
	</tr>	
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">배당률</td>
		<td bgcolor="#FFFFFF"  colspan="3">
		승 <input type='text' name='winRate' size=5/>
		<%=type.equals("mix")?"무/핸디":type.equals("wdl")?"무":"핸디" %> <input type='text' name='drawRate' size=5/>
		패 <input type='text' name='loseRate' size=5/>											
		</td>
	</tr>
<%if (type.equals("handy")){ %>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">오버언더</td>
		<td bgcolor="#FFFFFF"  colspan="3">
		오버 <input type='text' name='overRate' size=5/>
		핸디	<input type='text' name='handyRate' size=5/>
		언더 <input type='text' name='underRate' size=5/><br>
		<input type='checkbox' name='uoCheck'> 체크하시면 오버/언더 경기가 동시에 등록됩니다.									
		</td>
	</tr>
<%} %>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">배팅차단</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			승 <input type='checkbox' name='winDeny' value="N">
			무 <input type='checkbox' name='drawDeny' value="N">
			패 <input type='checkbox' name='loseDeny' value="N">
			(체크하신 승/무/패 가 배팅이 차단됩니다)											
		</td>
	</tr>
</table>
</form>				
<table width="2%"  border="0" cellspacing="5" cellpadding="0">
	<tr>
		<td><input type='image' src="images/admin/but_input.gif" border="0" onclick="checkIT()"></td>                               
		<td><img src="images/admin/but_cancel.gif" border="0" onClick="history.back()" style="cursor:hand"></td>
	</tr>
</table>

<%@ include file="../admin_footer.jsp"%>
