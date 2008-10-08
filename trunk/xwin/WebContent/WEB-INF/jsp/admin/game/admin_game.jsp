<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
	final Integer ROWSIZE = 10;
	final Integer SHOWPAGE = 10;

	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Integer totalCount = (Integer) request.getAttribute("gameCount");
	
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String gameDate = XwinUtil.nvl(request.getParameter("gameDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	String type = request.getParameter("type");
%>
<%@ include file="../admin_header.jsp"%>
<SCRIPT LANGUAGE="JavaScript">

	function goPage(pageIndex)
	{
		document.search.pageIndex.value = pageIndex;
		document.search.submit();
	}

	function readyGame(id)
	{
		if (confirm("경기를 대기 하시겠습니까?")) {
			var query = "mode=readyGame";
			query += "&id=" + id;
			query += "&type=" + '<%=type%>';
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();
			}
		}
	}
	
	function runGame(id, oselect)
	{
		if (confirm("경기를 진행 하시겠습니까?")) {	
			var query = "mode=runGame";
			query += "&id=" + id;
			query += "&type=" + '<%=type%>';
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0)
				location.reload();
		}
	}
	
	function endGame(id)
	{
		var homeScore = document.getElementById("homeScore_"+id).value;
		var awayScore = document.getElementById("awayScore_"+id).value;

		if (homeScore == '' || awayScore == '') {
			alert("스코어를 입력하세요");
			return;
		}

		if (confirm("경기를 종료 하시겠습니까?")) {
			var query = "mode=endGame";
			query += "&homeScore=" + homeScore;
			query += "&awayScore=" + awayScore;
			query += "&id=" + id;
			query += "&type=" + '<%=type%>';
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();
			}
		}
	}

	function cancelGame(id)
	{
		if (confirm("경기를 취소 하시겠습니까?")) {
			var query = "mode=cancelGame";
			query += "&id=" + id;
			query += "&type=" + '<%=type%>';
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();
			}
		}
	}

	function changeBetStatus(id, oselect)
	{
		var betStatus = oselect.value;
		var msg = "";
		if (betStatus == '<%=Code.BETTING_STATUS_ACCEPT%>')
			msg = "배팅 가능 상태로 바꾸시겠습니까?";
		else if (betStatus == '<%=Code.BETTING_STATUS_DENY%>')
			msg = "배팅 금지 상태로 바꾸시겠습니까?";
		else
			msg = "배팅을 정산 하시겠습니까?";

		if (confirm(msg)) {
			var query = "mode=changeBetStatus";
			query += "&betStatus=" + betStatus;
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
		}
	}

	function cancelGameScore(id)
	{
		var query = "mode=cancelGameScore";
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}

	function removeGame(id)
	{
		var query = "mode=removeGame";
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}
</SCRIPT>

<h2 class="heading"><%=type.equals("wdl")?"승무패":"핸디캡"%></h2>
<input type="button" value="등록하기" onclick="location.href='adminGame.aspx?mode=viewRegisterGameForm&type=<%=type%>'">
<br>
<br>
<form method='get' name='search'>
<input type='hidden' name='pageIndex' value='0'/>
<input type='hidden' name='mode' value='viewGameList'/>
<input type='hidden' name='type' value='<%=type%>'/>

리그명
<select name='leagueId' onChange='this.form.submit()'>
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
경기상태
<select name='status' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.GAME_STATUS_READY%>' <%=status.equals(Code.GAME_STATUS_READY)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_READY)%></option>
	<option value='<%=Code.GAME_STATUS_RUN%>' <%=status.equals(Code.GAME_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_RUN)%></option>
	<option value='<%=Code.GAME_STATUS_END%>' <%=status.equals(Code.GAME_STATUS_END)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_END)%></option>
	<option value='<%=Code.GAME_STATUS_CANCEL%>' <%=status.equals(Code.GAME_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_CANCEL)%></option>	
 </select>
배팅상태
<select name='betStatus' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.BETTING_STATUS_ACCEPT%>' <%=betStatus.equals(Code.BETTING_STATUS_ACCEPT)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_ACCEPT)%></option>
	<option value='<%=Code.BETTING_STATUS_DENY%>' <%=betStatus.equals(Code.BETTING_STATUS_DENY)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_DENY)%></option>	
 </select>

 경기일자
<input type='text' name='gameDate'value='' size=10 readonly onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">

 <select name='search'>
	 <option value='homeTeam' <%=search.equals("homeTeam")?"selected":""%>>홈팀명</option>
 	<option value='awayTeam' <%=search.equals("awayTeam")?"selected":""%>>원정팀명</option>
 </select>
 <input type='text' name='keyword' value='<%=keyword%>'>
 <input type='submit' value='검 색'>
</form>
게임진행: <img src="images/admin/btn_run.jpg">
게임대기: <img src="images/admin/btn_ready.jpg">
게임종료: <img src="images/admin/btn_end.jpg">
게임취소: <img src="images/admin/btn_cancel.jpg">
<form method='get' name='game'>
	<table class="prettytable">
 		<tr>
			<th width=5%>번호</th>
			<th>리그명</th>
			<th>경기시각</th>
			<th>홈팀</th>
			<th>원정팀</th>
			<th>승</th>
			<%
			if (type.equals("wdl")) {
			%>
			<th>무</th>
			<%
			} else {
			%>
			<th>핸디</th>
			<%
			}
			%>
			<th>패</th>								
			<th>스코어</th>
			<th>결과</th>
			<th>배팅</th>
			<th>상태</th>
			<th>기능</th>
	  	</tr>

		<%
		if (gameList != null) {
			for (Game game : gameList) {
				
		%>
 		<tr>
			<td width=5%><a href="adminGame.aspx?mode=viewUpdateGameForm&type=<%=type%>&id=<%=game.getId()%>"><%=game.getId()%></a></td>
			<td><%=game.getLeagueName()%></td>
			
			<td><%=game.getGameDateStr()%></td>
			<td><%=game.getHomeTeam()%></td>
			<td><%=game.getAwayTeam()%></td>
			<td><%=game.getWinRateStr()%></td>
			<%
			if (type.equals("wdl")) {
			%>
			<td><%=game.getDrawRateStr()%></td>
			<%
			} else {
			%>
			<td><%=game.getDrawRate()%></td>
			<%
			}
			%>
			<td><%=game.getLoseRateStr()%></td>
			<td>
				<%
				if (game.getStatus().equals(Code.GAME_STATUS_RUN)) {
				%>
				<input id='homeScore_<%=game.getId()%>' type='text' name='homeScore' value='<%=XwinUtil.nvl(game.getHomeScore())%>' size=2>
				:
				<input id='awayScore_<%=game.getId()%>' type='text' name='awayScore' value='<%=XwinUtil.nvl(game.getAwayScore())%>' size=2>
				<%
				} else {
				%>
				<%=XwinUtil.nvl(game.getHomeScore())%> : <%=XwinUtil.nvl(game.getAwayScore())%>							
				<%
				}
				%>
			</td>
			<td><%=Code.getValue(game.getResult())%></td>
			<td>
				<select name='betStatus_<%=game.getId()%>' onchange='changeBetStatus(<%=game.getId()%>, this)'>
					<option value='<%=Code.BETTING_STATUS_ACCEPT%>' <%=game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_ACCEPT)%></option>
					<option value='<%=Code.BETTING_STATUS_DENY%>' <%=game.getBetStatus().equals(Code.BETTING_STATUS_DENY)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_DENY)%></option>
				</select>
			</td>								
			<td><B><%=Code.getValue(game.getStatus())%></B></td>
			<td>
				<%
					if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false) {
				%>
				<img src="images/admin/btn_run.jpg" onclick='runGame(<%=game.getId()%>)' style='cursor:hand'>
				<%
					}
					if (game.getStatus().equals(Code.GAME_STATUS_RUN)) {
				%>															
				<img src="images/admin/btn_end.jpg" onclick='endGame(<%=game.getId()%>)' style='cursor:hand'>
				<%
					}
					if (game.getStatus().equals(Code.GAME_STATUS_READY) == false) {
				%>
				<img src="images/admin/btn_ready.jpg" onclick='readyGame(<%=game.getId()%>)' style='cursor:hand'>
				<%
					}
					if (game.getStatus().equals(Code.GAME_STATUS_CANCEL) == false) {
				%>
				<img src="images/admin/btn_cancel.jpg" onclick='cancelGame(<%=game.getId()%>)' style='cursor:hand'>
				<%
					}										
				%>
			</td>
		</tr>
			<%
				}
			}
			%>
	</table>
	<div class="pages">
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil(totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + 15;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b> <%=i+1%> </b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
	}
%>
	</div>
<%@ include file="../admin_footer.jsp"%>