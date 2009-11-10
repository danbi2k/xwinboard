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
			<tr><td><img src="img/menu151.jpg" border="0"></td></tr>
		
</table>
<br>
<table align="center" cellpadding="0" cellspacing="0" width="841">
<%
	if (bettingList != null) {
		for (Betting betting : bettingList) {
%>
<tr bgcolor="darkred"><td>
	<table border="0" cellpadding="0" cellspacing="0">
		<tbody><tr>
		<td>&nbsp;<img src='img/sub_betlist_del_bt.gif' alt='삭제' class='img_bt ml5' onclick="deleteMyBetting(<%=betting.getId()%>)"></td>
	<td width="670" style="color:white;vertical-align:middle;text-align:left;"><b>&nbsp;배팅일시 : <%=XwinUtil.getMMddDate(betting.getDate())%> / 배당 : <%=betting.getRateStr()%> / 배팅액 : <%=XwinUtil.comma3(betting.getMoney())%> / 예상적중액 : <%=XwinUtil.comma3(betting.getExpect())%> /
	적중액 :
	<%
	if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
		out.print("<font color='ffff00'>" + XwinUtil.comma3(betting.getExpect()) + "</font>");
	else
		out.print(0);							
	%>
	 원</b>
	</td><td>
	<img src="img/btn_board.gif" onclick="location.href='bbs.php?mode=viewBoardWriteForm&boardName=user&bettingId=<%=betting.getId()%>'" style="cursor:hand">
	<img src="img/btn_qna.gif" onclick="location.href='bbs.php?mode=viewBoardWriteForm&boardName=qna&bettingId=<%=betting.getId()%>'" style="cursor:hand">
	</td>
	</tr></tbody></table></td>
</tr>
<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0">
				<tbody><tr>
					<td>
						<table bgcolor="#424142" border="0" cellpadding="0" cellspacing="1" style="table-layout:fixed;">
							<tbody><tr bgcolor="#a6a6a6" height="27">
								<td style='word-break:break-all;' align="center" width="90"><font color="#1a1a1a"><b><nobr>경기일시</nobr></b></font></td>
								<td style='word-break:break-all;' align="center" width="230"><font color="#1a1a1a"><b><nobr>(승)홈 팀</nobr></b></font></td>
								<td style='word-break:break-all;' align="center" width="85"><font color="#1a1a1a"><b><nobr>무/핸디캡</nobr></b></font></td>								
								<td style='word-break:break-all;' align="center" width="230"><font color="#1a1a1a"><b><nobr>(패)원정팀</nobr></b></font></td>
								<td style='word-break:break-all;' align="center" width="60"><font color="#1a1a1a"><b><nobr>배팅팀</nobr></b></font></td>
								<td style='word-break:break-all;' align="center" width="80"><font color="#1a1a1a"><b><nobr>경기결과</nobr></b></font></td>
								<td style='word-break:break-all;' align="center" width="60"><font color="#1a1a1a"><b><nobr>적중유무</nobr></b></font></td>
							</tr>
							
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		int count = 0;
		for (BetGame betGame : betGameList) {
%>
							<tr bgcolor="#ffffff" height="25">
								<td style='word-break:break-all;' align="center"><nobr><font color="#1a1a1a"><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></font></nobr></td>
								<td style='word-break:break-all;' align="right"><nobr>
									<%if (betGame.getResultStatus().equals(Code.RESULT_STATUS_RUN)) { %>
									<font color="#1a1a1a">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)) { %>
									<font color="#1000e2">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_FAILURE)) {%>
									<font color="#DD0000">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_DRAW) || betGame.getResultStatus().equals(Code.RESULT_STATUS_CANCEL)) {%>
									<font color="#DDDDDD"><STRIKE>
									<%} %>
									<%=betGame.getHomeTeam()%>&nbsp;<%=betGame.getWinRateStr()%>&nbsp;</font>
									</nobr></td>
								<td style='word-break:break-all;' align="center"><nobr>
									<font color="#1a1a1a"><%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>
								</font></nobr></td>
								
								<td style='word-break:break-all;'><nobr>&nbsp;
									<%if (betGame.getResultStatus().equals(Code.RESULT_STATUS_RUN)) { %>
									<font color="#1a1a1a">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)) { %>
									<font color="#1000e2">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_FAILURE)) {%>
									<font color="#DD0000">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_DRAW) || betGame.getResultStatus().equals(Code.RESULT_STATUS_CANCEL)) {%>
									<font color="#DDDDDD"><STRIKE>
									<%} %>
									<%=betGame.getLoseRateStr()%>&nbsp;<%=betGame.getAwayTeam()%></font></nobr></td>
								<td style='word-break:break-all;' align="center"><nobr><font color="#1a1a1a"><%=Code.getValue(betGame.getGuess())%></font></nobr></td>
								<td style='word-break:break-all;' align="center"><nobr>&nbsp;<font color="#1a1a1a">
								<%=Code.getValue(betGame.getResult())%>
								<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%>
								</font></nobr>&nbsp;</td>
								<td style='word-break:break-all;' align="center"><nobr>
									<%if (betGame.getResultStatus().equals(Code.RESULT_STATUS_RUN)) { %>
									<font color="#1a1a1a">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)) { %>
									<font color="#1000e2">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_FAILURE)) {%>
									<font color="#DD0000">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_DRAW) || betGame.getResultStatus().equals(Code.RESULT_STATUS_CANCEL)) {%>
									<font color="#DDDDDD">
									<%} %>
									<B><%=Code.getValue(betGame.getResultStatus())%></B></font></nobr></td>
								<%
								if (count == 0) {
								%>
								<%
								count++;
								}
								%>
								
							</tr>
<%
		}	
	}		
%>				
					
						</tbody></table>		
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				
				</tbody></table>
			</td>
		</tr>
	<tr><td height="10"></td>
	</tr>

<%			
		}
	}
%>
</table>
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'><img src="img/prev.jpg" border="0" align="absmiddle"></a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'><img src="img/next.jpg" border="0" align="absmiddle"></a>
<%
	}
%>
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