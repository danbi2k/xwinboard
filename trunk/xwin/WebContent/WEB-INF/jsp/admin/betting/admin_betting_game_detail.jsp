<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 25;
	int SHOWPAGE = 10;
	
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	Integer totalCount = (Integer) request.getAttribute("bettingCount");
	
	String id = request.getParameter("id");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
%>
<div class="title">경기별 배팅 현황</div>		
<form name='search' method='get' action='adminBetting.aspx'>
<input type='hidden' name='mode' value='viewBettingMoneyDetail'/>
<input type="hidden" name="id" value="<%=id%>"/>
<input type='hidden' name='pageIndex'/>
배팅상태
<select name='status' onChange='this.form.submit()'>
<option value=''>전체</option>
<option value='<%=Code.BET_STATUS_RUN%>' <%=status.equals(Code.BET_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=status.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
<option value='<%=Code.BET_STATUS_FAILURE%>' <%=status.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
<option value='<%=Code.BET_STATUS_NOMATCH%>' <%=status.equals(Code.BET_STATUS_NOMATCH)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_NOMATCH)%></option>
<option value='<%=Code.BET_STATUS_CANCEL%>' <%=status.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>
</select>
<select name='search'>
	<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
	<option value='nickName' <%=search.equals("nickName")?"selected":""%>>회원닉네임</option>
</select>
<input type='text' name='keyword' value='<%=keyword%>'>
배팅시각
<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">
<input type='submit' value='검 색'>
</form> 
<table class="prettytable">
<%
if (bettingList != null) {
	for (Betting betting : bettingList) {		
%>
	<tr>
	<th width=5%>번호</th>
		<th>아이디 (닉네임)</th>
		<th>경기시각</th>
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
		<td rowspan='<%=betting.getTotalCount()%>'><font color='#000000'><a href="adminMember.aspx?mode=viewMemberDetail&userId=<%=betting.getUserId()%>"><%=betting.getUserId()%></a> (<%=betting.getNickName()%>)</a></td>
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
			배팅시각 : <%=betting.getDateStr()%>&nbsp; / &nbsp; 배당률 : x<%=betting.getRateStr()%>&nbsp; / &nbsp;
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
