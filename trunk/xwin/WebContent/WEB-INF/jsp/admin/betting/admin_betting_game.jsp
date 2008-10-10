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

<h2 class="heading">경기별 배팅 현황</h2>
<br>
<br>
<form method='get' name='search'>
<input type='hidden' name='pageIndex' value='0'/>
<input type='hidden' name='mode' value='viewBettingMoneyList'/>

경기종류
<select name="type" onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='wdl'>승무패</option>
	<option value='handy'>핸디캡</option>
</select>
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
표시
<select name='betStatus' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.BETTING_STATUS_ACCEPT%>' <%=betStatus.equals(Code.BETTING_STATUS_ACCEPT)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_ACCEPT)%></option>
	<option value='<%=Code.BETTING_STATUS_DENY%>' <%=betStatus.equals(Code.BETTING_STATUS_DENY)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_DENY)%></option>	
 </select>

 경기일자
<input type='text' name='gameDate'value='' size=10 readonly onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
<input type='submit' value='검 색'>
</form>

<table class="prettytable">
		<tr>
		<th width=5%>번호</th>
		<th>종류</th>
		<th>리그명</th>
		<th>경기시각</th>
		<th>홈팀</th>
		<th>원정팀</th>
		<th>배팅액(승)</th>
		<th>배팅액(무)</th>
		<th>배팅액(패)</th>
		<th>경기상태</th>
  	</tr>

	<%
	if (gameList != null) {
		for (Game game : gameList) {
			
	%>
		<tr>
		<td width=5%><%=game.getId()%></td>
		<td><%=Code.getValue(game.getType())%></td>
		<td><%=game.getLeagueName()%></td>			
		<td><%=game.getGameDateStr()%></td>
		<td><%=game.getHomeTeam()%></td>
		<td><%=game.getAwayTeam()%></td>
		<td><font color='red'><%=XwinUtil.nvl(game.getWinMoney())%></font></td>
		<td><font color='red'><%=XwinUtil.nvl(game.getDrawMoney())%></font></td>
		<td><font color='red'><%=XwinUtil.nvl(game.getLoseMoney())%></font></td>
		<td><%=Code.getValue(game.getStatus())%></td>
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