<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%
	int ROWSIZE = 10;
	int SHOWPAGE = 10;
	String status = XwinUtil.nvl(request.getParameter("status"));
	String gameType = XwinUtil.nvl(request.getParameter("gameType"));
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	Integer totalCount = (Integer) request.getAttribute("bettingCount");
%>
<%@include file="../header.jsp"%>

<div class='sub_ti1'>
		<img src='img/sub_betlist_ti.gif' alt='배팅내역' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 배팅 내역 및 결과입니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='betlog.php?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='bet_list'>
<%
	if (bettingList != null) {
		for (Betting betting : bettingList) {
%>			
				<div class='list_box'>
					<img src='img/sub_betlist_del_bt.gif' alt='삭제' class='img_bt ml5' onclick="deleteMyBetting(<%=betting.getId()%>)"> 배당율 : <span><%=betting.getRateStr()%></span> / 배팅금액 : <span><%=XwinUtil.comma3(betting.getMoney())%></span> / 예상적중금액 : <span><%=XwinUtil.comma3(betting.getExpect())%></span> / 적중금액 :
					<span>
					<%
					if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
						out.print(XwinUtil.comma3(betting.getExpect()));
					else
						out.print(0);							
					%>
					</span> 
					<table>
						<tr>
							<th class='t0'>배팅일시</th>
							<th class='t1'>경기일시</th>
							<th class='t2'>(승) 홈팀</th>
							<th class='t3'>무/핸디캡</th>
							<th class='t4'>(패) 원정팀</th>
							<th class='t5'>배팅팀</th>
							<th class='t6'>경기결과</th>
							<th class='t7'>적중유무</th>
						</tr>
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		for (BetGame betGame : betGameList) {
			String classStr = betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)?"win":"";
%>
						<tr>
							<td class='<%=classStr%>'><%=betting.getDateStr() %></td>
							<td class='<%=classStr%>'><%=betGame.getGameDateStr()%></td>
							<td class='<%=classStr%>'><%=betGame.getHomeTeam()%>&nbsp;<%=betGame.getWinRateStr()%></td>
							<td class='<%=classStr%>'><%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%></td>
							<td class='<%=classStr%>'><%=betGame.getLoseRateStr()%>&nbsp;<%=betGame.getAwayTeam()%></td>
							<td class='<%=classStr%>'><%=Code.getValue(betGame.getGuess())%></td>
							<td class='<%=classStr%>'><%=Code.getValue(betGame.getResult())%>
							<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%>
							</td>
							<td class='<%=classStr%>'><%=Code.getValue(betGame.getResultStatus())%></td>
						</tr>
<%
		}
	}
%>

					</table>

				</div>
<%
		}	
	}		
%>	

<!-----[ 페이징 ]--------------------------------------------/-->
				<div class='paginate'>    
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<span class='pre'><a href='javascript:goPage(<%=startPage - 1%>)'><img src='img/list_prev_bt.gif' alt='이전'></a></span>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<span class='txt'><strong><%=i+1%></strong></span>
<%
		} else {
%>		
			<span class='txt'><a href='javascript:goPage(<%=i%>)'><%=i+1%></a></span>
<%			
		}
	}
	if (i < pageNum) {
%>		
		<span class='next'><a href='javascript:goPage(<%=i%>)''><img src='img/list_next_bt.gif' alt='다음' class='next'></a></span>
<%
	}
%>
				</div>		
			</div>
			<!-- end bet_list -->
		</div>
		<!-- sub_content1 -->

<script>
function deleteMyBetting(id)
{
	if (confirm("배팅 기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyBetting";
		query += "&bettingId=" + id;
		var http = new JKL.ParseXML("betlog.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function goPage(pageIndex)
{
	location.href = "betlog.php?mode=viewMyBettingList&pageIndex=" + pageIndex;
}
</script>
<%@include file="../footer.jsp"%>