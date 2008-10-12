<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	String id = request.getParameter("id");
%>
<div class="title">경기별 배팅 현황</div>		 
<table class="prettytable">
<%
if (bettingList != null) {
	for (Betting betting : bettingList) {		
%>
	<tr>
	<th width=5%>번호</th>
		<th>아이디</th>
		<th>경기시간</th>
		<th>홈팀</th>
		<th>무승부<BR>/핸디캡</th>
		<th>원정팀</th>
		<th>배팅</th>
		<th>결과</th>
		<th>적중유무</th>
		<th>상태</th>
		<th>취소</th>
	</tr>
							 
	<%
	if (betting != null) {
			List<BetGame> betGameList = betting.getBetGameList();
			if (betGameList != null) {
				int count = 0;
				for (BetGame betGame : betGameList) {								
	%>
	<tr align='center' bgcolor='#ffffff'>
		<%
		if (count == 0) {
		%>
		<td rowspan='<%=betting.getTotalCount()%>'><font color='#000000'><%=betting.getId()%></td>								
		<td rowspan='<%=betting.getTotalCount()%>'><font color='#000000'><%=betting.getUserId()%></a></td>
		<%
		}
		%>
		<td><font color='#000000'><%=betGame.getGameDateStr()%></td>
		<td><font color='#000000'><%=betGame.getHomeTeam()%> (<%=betGame.getWinRateStr()%>)</td>																								
		<td><font color='#000000'><%=betGame.getDrawRateStr()%></td>
		<td><font color='#000000'><%=betGame.getAwayTeam()%> (<%=betGame.getLoseRateStr()%>)</td>
		<td><font color='#000000'><%=Code.getValue(betGame.getGuess())%></td>
		<td><font color='#000000'><B></b><%=Code.getValue(betGame.getResult())%><BR></td>
		<td><%=XwinUtil.judgeBetGame(betGame)%></td>
		<%
		if (count++ == 0) {
		%>
		<td rowspan='<%=betting.getTotalCount()%>'><%=Code.getValue(betting.getStatus())%></td>
		<td rowspan='<%=betting.getTotalCount()%>'>
		<%if (betting.getStatus().equals(Code.BET_STATUS_RUN)) { %>
			<input type="button" value="배팅취소" onclick="cancelBetting(<%=betting.getId()%>)"/>
		<%} else { %>
			취소불가
		<%} %>
		</td>
		<%
		}
		%>
	</tr>
	<%
		}
	}			
	%>
	<tr>
		<td colspan='11'>
			<B>
			배팅시각 : <%=betting.getDateStr()%>&nbsp; / &nbsp; 배당률 : x<%=betting.getRateStr()%><br>
			배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%> 원&nbsp; / &nbsp; 예상금액 : <%=XwinUtil.comma3(betting.getExpect())%> 원
			</B>
		</td>
	</tr>
	<tr><td colspan=11>&nbsp;</td></tr>
<%
	}
	}
}
%>
</table>
<script>
function cancelBetting(id)
{
	if (confirm("취소하시겠습니까?")) {
		var query = "mode=cancelBetting";
		query += "&id=" + id;
		var http = new JKL.ParseXML("adminBetting.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.href='adminBetting.aspx?mode=viewBettingMoneyDetail&id=<%=id%>';
	}
}
</script>
<%@ include file="../admin_footer.jsp"%>
