<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
	final Integer ROWSIZE = 40;
	final Integer SHOWPAGE = 20;

	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Integer totalCount = (Integer) request.getAttribute("gameCount");
	Long[] moneySummar = (Long[]) request.getAttribute("moneySummary");
	
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	String type = XwinUtil.nvl(request.getParameter("type"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	if (status.length() == 0)
			status = Code.GAME_STATUS_RUN;
%>
<%@ include file="../admin_header.jsp"%>

<div class="title">경기별 배팅 현황</div>

<form method='get' name='search' action='adminBetting.aspx'>
<input type='hidden' name='mode' value='viewBettingMoneyList'/>
<input type='hidden' name='pageIndex'/>

경기종류
<select name="type" onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='wdl' <%=type.equals("wdl")?"selected":""%>>승무패</option>
	<option value='handy' <%=type.equals("handy")?"selected":""%>>핸디캡</option>
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
	<!--option value=''>전체</option  -->
	<option value='<%=Code.GAME_STATUS_RUN%>' <%=status.equals(Code.GAME_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_RUN)%></option>
	<option value='<%=Code.GAME_STATUS_END%>' <%=status.equals(Code.GAME_STATUS_END)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_END)%></option>
	<option value='<%=Code.GAME_STATUS_CANCEL%>' <%=status.equals(Code.GAME_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_CANCEL)%></option>	
 </select>
<BR>
경기일자
<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this, fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~ 
<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this, toDate,'yyyy-mm-dd');" style="cursor:hand">
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
  	</tr>

	<%
	if (gameList != null) {
		for (Game game : gameList) {
			
	%>
		<tr>
		<td width=5%><a href="adminBetting.aspx?mode=viewBettingMoneyDetail&id=<%=game.getId()%>"><%=game.getId()%></a></td>
		<td nowrap><font color=<%=game.getType().equals("wdl")?"blue":"green"%>><%=Code.getValue(game.getType())%></font></td>
		<td><%=game.getLeagueName()%></td>			
		<td><%=game.getGameDateStr()%></td>
		<td><%=game.getHomeTeam()%></td>
		<td><%=game.getAwayTeam()%></td>
		<td><font color='red'><%=XwinUtil.comma3(XwinUtil.numNvl(game.getWinMoney()))%></font> (<%=game.getWinRateStr()%>)</td>
		<td><font color='red'><%=XwinUtil.comma3(XwinUtil.numNvl(game.getDrawMoney()))%></font> (<%=game.getType().equals("wdl")?game.getDrawRateStr():game.getHandyString()%>)</td>
		<td><font color='red'><%=XwinUtil.comma3(XwinUtil.numNvl(game.getLoseMoney()))%></font> (<%=game.getLoseRateStr()%>)</td>
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

<table class="prettytable">
<tr>
<th>유저전체보유액</th>
<td><font color='red' size=3><B><%=XwinUtil.comma3(moneySummar[0])%> 원</B></font></td>
<th>유저배팅대기액</th>
<td><font color='red' size=3><B><%=XwinUtil.comma3(moneySummar[1])%> 원</B></font></td>
</tr>
</table>

<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>