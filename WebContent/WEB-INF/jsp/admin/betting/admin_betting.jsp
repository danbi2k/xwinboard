<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	final Integer ROWSIZE = 40;
	final Integer SHOWPAGE = 20;
	
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	Integer totalCount = (Integer) request.getAttribute("bettingCount");
	
	String gameType = XwinUtil.nvl(request.getParameter("gameType"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String betDate = XwinUtil.nvl(request.getParameter("betDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
		 
<script>
function cancelBetting(id, gameType)
{
	if (confirm("취소하시겠습니까?")) {
		var query = "mode=cancelBetting";
		query += "&id=" + id;
		query += "&gameType=" + gameType;
		var http = new JKL.ParseXML("adminBetting.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message)
		if (result.resultXml.code == 0) {
			location.reload(0);
		}
	}
}
</script>

<form method='post' name='search' action='adminBetting.aspx?mode=viewBettingList'>
 게임종류
<select name='gameType' onChange='this.form.submit()'>
<option value=''>전체</option>
<option value='wdl' <%=gameType.equals("wdl")?"selected":""%>>승무패</option>
<option value='handy' <%=gameType.equals("handy")?"selected":""%>>핸디캡</option>
                  <option value='oe' <%=gameType.equals("oe")?"selected":""%>>홀짝</option>
</select>

배팅상태
<select name='status' onChange='this.form.submit()'>
<option value=''>전체</option>
<option value='<%=Code.BET_STATUS_RUN%>' <%=status.equals(Code.BET_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=status.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
<option value='<%=Code.BET_STATUS_FAILURE%>' <%=status.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
<option value='<%=Code.BET_STATUS_RETURN%>' <%=status.equals(Code.BET_STATUS_RETURN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RETURN)%></option>
<option value='<%=Code.BET_STATUS_CANCEL%>' <%=status.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>
</select>

 배팅일자
<input type='text' name='betDate' value='<%=betDate%>' size=10 readonly onClick="popUpCalendar(this, betDate,'yyyy-mm-dd');" style="cursor:hand">

 <select name='search'>
 <option value='userId'>아이디</option>
 <option value='nickName'>닉네임</option>
</select> 
<input type='text' name='keyword' value='<%=keyword%>' size=12>
<input type='submit' value='검 색'>
<br>
배팅정산 : <img src="images/admin/btn_run.jpg">
배팅취소 : <img src="images/admin/btn_cancel.jpg">
</form>

<form method='post' name='game'>
<table class="prettytable">
	<tr>
	<th width=5%>번호</th>
		<th>아이디</th>
		<th>경기시각</th>
		<th>홈팀</th>
		<th>무승부<BR>/핸디캡</th>
		<th>원정팀</th>
		<th nowrap>배팅</th>
		<th nowrap>결과</th>
		<th nowrap>상태</th>
		<th nowrap>정산</th>
	</tr>
							 
	<%
	if (bettingList != null) {
		for (Betting betting : bettingList) {
			List<BetGame> betGameList = betting.getBetGameList();
			if (betGameList != null) {
				int betGameCount = betGameList.size();
				int count = 0;
				for (BetGame betGame : betGameList) {								
	%>
	<tr align='center' bgcolor='#ffffff'>
		<%
		if (count == 0) {
		%>
		<td rowspan='<%=betGameCount%>'><font color='#000000'><%=betting.getId()%></td>								
		<td rowspan='<%=betGameCount%>'><font color='#000000'><%=betting.getUserId()%></a></td>
		<%
		}
		%>
		<td><font color='#000000'><%=betGame.getGameDateStr()%></td>
		<td><font color='#000000'><%=betGame.getHomeTeam()%> (<%=betGame.getWinRateStr()%>)</td>																								
		<td><font color='#000000'><%=betGame.getDrawRateStr()%></td>
		<td><font color='#000000'><%=betGame.getAwayTeam()%> (<%=betGame.getLoseRateStr()%>)</td>
		<td><font color='#000000'><%=Code.getValue(betGame.getGuess())%></td>
		<td><font color='#000000'><B></b><%=Code.getValue(betGame.getResult())%><BR></td>
		<%
		if (count++ == 0) {
		%>
		<td rowspan='<%=betGameCount%>'><%=Code.getValue(betting.getStatus())%></td>
		<td rowspan='<%=betGameCount%>'><%=Code.getValue(betting.getCalcStatus())%></td>
		<%
		}
		%>
	</tr>
	<%
		}
	}			
	%>
	<tr>
		<td colspan='10'>
			<B>
			배팅시각 : <%=betting.getDateStr()%>&nbsp; / &nbsp; 배당률 : x<%=betting.getRateStr()%><br>
			배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%> 원&nbsp; / &nbsp; 예상금액 : <%=XwinUtil.comma3(betting.getExpect())%> 원
			</B>
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

<%@ include file="../admin_footer.jsp"%>
