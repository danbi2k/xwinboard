<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
	final Integer ROWSIZE = 30;
	final Integer SHOWPAGE = 20;

	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Integer totalCount = (Integer) request.getAttribute("gameCount");
	
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");
%>
<%@ include file="../admin_header.jsp"%>
<SCRIPT LANGUAGE="JavaScript">

	function goPage(pageIndex)
	{
		document.search.pageIndex.value = pageIndex;
		document.search.submit();
	}

	function cancelGame(id)
	{
		if (confirm("ingin batalkan pertandingan?")) {
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

	function changeDisplayStatus(id, oselect)
	{
		var displayStatus = oselect.value;

		var query = "mode=changeDisplayStatus";
		query += "&displayStatus=" + displayStatus;
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
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

	function saveAllScore()
	{
		var c = document.game.checkGame;
		for (var i in c) {
			alert(c[i].value); 
		}
	}
</SCRIPT>

<div class="title"><%=type.equals("wdl")?(grade.equals(Code.USER_GRADE_NORMAL)?"승무패":"이벤트"):"핸디캡"%></div>
<input type="button" value="등록하기" onclick="location.href='adminGame.aspx?mode=viewRegisterGameForm&type=<%=type%>&grade=<%=grade%>'">
<br>
<br>
<form method='get' name='search' action='adminGame.aspx'>
<input type='hidden' name='mode' value='viewEndGameList'/>
<input type='hidden' name='pageIndex'/>
<input type='hidden' name='type' value='<%=type%>'/>
<input type='hidden' name='grade' value='<%=grade%>'/>

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
	<option value='<%=Code.GAME_STATUS_END%>' <%=status.equals(Code.GAME_STATUS_END)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_END)%></option>
	<option value='<%=Code.GAME_STATUS_CANCEL%>' <%=status.equals(Code.GAME_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_CANCEL)%></option>	
 </select>
<BR>
 경기일자
<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">

 <select name='search'>
	 <option value='homeTeam' <%=search.equals("homeTeam")?"selected":""%>>홈팀명</option>
 	<option value='awayTeam' <%=search.equals("awayTeam")?"selected":""%>>원정팀명</option>
 </select>
 <input type='text' name='keyword' value='<%=keyword%>'>
 <input type='submit' value='검 색'>
</form>
<!--
게임진행: <img src="images/admin/btn_run.jpg">
게임대기: <img src="images/admin/btn_ready.jpg">
게임종료: <img src="images/admin/btn_end.jpg">
게임취소: <img src="images/admin/btn_cancel.jpg">
-->
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
			<th>상태</th>
			<!--th>기능</th  -->
	  	</tr>

		<%
		if (gameList != null) {
			for (Game game : gameList) {
				
		%>
 		<tr>
			<td width=5%><a href="adminGame.aspx?mode=viewReprocessGame&id=<%=game.getId()%>&type=<%=game.getType()%>&grade=<%=game.getGrade()%>"><%=game.getId()%></a></td>
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
			<td><B><%=Code.getValue(game.getStatus())%></B></td>
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
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
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
<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>