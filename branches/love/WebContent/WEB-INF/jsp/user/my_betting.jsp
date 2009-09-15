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
			<tr><td><img src="img/menu15.jpg" border="0"></td></tr>
		
</table>
<table align="center" cellpadding="0" cellspacing="0" width="841">
<%
	if (bettingList != null) {
		for (Betting betting : bettingList) {
%>

<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0">
				<tbody><tr>
					<td>
						<table bgcolor="#424142" border="0" cellpadding="0" cellspacing="1">
							<tbody><tr bgcolor="#212021" height="27">
								<td align="center" width="90"><font color="#ffffff"><b><nobr>배팅일시</nobr></b></font></td>
								<td align="center" width="90"><font color="#ffffff"><b><nobr>경기날짜</nobr></b></font></td>
								<td align="center" width="210"><font color="#ffffff"><b><nobr>(승)홈 팀</nobr></b></font></td>
								<td align="center" width="85"><font color="#ffffff"><b><nobr>무/핸디캡</nobr></b></font></td>
								
								<td align="center" width="210"><font color="#ffffff"><b><nobr>(패)원정팀</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>선택</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>결과</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>적중</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>삭제</nobr></b></font></td>
								<td align="center" width="70"><font color="#ffffff"><b><nobr>복사</nobr></b></font></td>
							</tr>
							
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		int count = 0;
		for (BetGame betGame : betGameList) {
%>
							<tr bgcolor="#000000" height="25">
								<td align="center"><nobr><font color="#ffffff"><%=XwinUtil.getBoardItemDate(betting.getDate())%></font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></font></nobr></td>
								<td align="right"><nobr>
									<%if (betGame.getResultStatus().equals(Code.RESULT_STATUS_RUN)) { %>
									<font color="#ffffff">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)) { %>
									<font color="#FFC602">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_FAILURE)) {%>
									<font color="#DD0000">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_DRAW) || betGame.getResultStatus().equals(Code.RESULT_STATUS_CANCEL)) {%>
									<font color="#DDDDDD"><STRIKE>
									<%} %>
									<%=betGame.getHomeTeam()%>&nbsp;<%=betGame.getWinRateStr()%>&nbsp;</font>
									</nobr></td>
								<td align="center"><nobr>
									<font color="#ffffff"><%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>
								</font></nobr></td>
								
								<td><nobr>&nbsp;
									<%if (betGame.getResultStatus().equals(Code.RESULT_STATUS_RUN)) { %>
									<font color="#ffffff">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)) { %>
									<font color="#FFC602">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_FAILURE)) {%>
									<font color="#DD0000">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_DRAW) || betGame.getResultStatus().equals(Code.RESULT_STATUS_CANCEL)) {%>
									<font color="#DDDDDD"><STRIKE>
									<%} %>
									<%=betGame.getLoseRateStr()%>&nbsp;<%=betGame.getAwayTeam()%></font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=Code.getValue(betGame.getGuess())%></font></nobr></td>
								<td align="center"><nobr>&nbsp;<font color="#ffffff">
								<%=Code.getValue(betGame.getResult())%>
								<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%>
								</font></nobr></td>
								<td align="center"><nobr>
									<%if (betGame.getResultStatus().equals(Code.RESULT_STATUS_RUN)) { %>
									<font color="#ffffff">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_SUCCESS)) { %>
									<font color="#FFC602">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_FAILURE)) {%>
									<font color="#DD0000">
									<%} else if (betGame.getResultStatus().equals(Code.RESULT_STATUS_DRAW) || betGame.getResultStatus().equals(Code.RESULT_STATUS_CANCEL)) {%>
									<font color="#DDDDDD">
									<%} %>
									<B><%=Code.getValue(betGame.getResultStatus())%></B></font></nobr></td>
								<%
								if (count == 0) {
								%>
								<td align="center" rowspan="<%=betGameCount%>">
									<%
									if (betting.getStatus().equals(Code.BET_STATUS_RUN) == false) {
									%>
									<img src="img/x.gif" onclick="deleteMyBetting(<%=betting.getId()%>)">
									<%
									}
									%>
								</td>
								<td align="center" rowspan="<%=betGameCount%>" nowrap>
									<img style='margin:5px 5px 5px 5px' src="img/btn_board.gif" onclick="location.href='bbs.php?mode=viewBoardWriteForm&boardName=user&bettingId=<%=betting.getId()%>'" style="cursor:hand"><br>
									<img style='margin:5px 5px 5px 5px' src="img/btn_qna.gif" onclick="location.href='bbs.php?mode=viewBoardWriteForm&boardName=qna&bettingId=<%=betting.getId()%>'" style="cursor:hand">
								</td>
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
				<tr>
					<td align="center">배당율 : <%=betting.getRateStr()%> / 배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%>원 / 예상적중금액 : <%=XwinUtil.comma3(betting.getExpect())%>원 /
					적중금액 :
					<%
					if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
						out.print("<font color='#FFC602'>" + XwinUtil.comma3(betting.getExpect()) + "</font>");
					else
						out.print(0);							
					%>
					 원
					</td>
				</tr>
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