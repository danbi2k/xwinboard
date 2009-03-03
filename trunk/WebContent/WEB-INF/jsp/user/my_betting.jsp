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
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<form name="frm" action="myBet.aspx">
<input type="hidden" name="mode" value="viewMyBettingList"/>
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">

<table width="900" style="border-bottom:1 solid #909090;">
<tr>
	<td width="100"><img src="images/title_mybet.gif"></td>
	<td>배팅 내역 및 결과입니다.</td>
</tr>
</table>
</td><tr>
<tr><td valign="top" align="center">
<table border="0" cellpadding="0" cellspacing="0" width="900">

<%
	if (bettingList != null) {
		for (Betting betting : bettingList) {
%>

<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tbody><tr>
					<td>
						<table bgcolor="#424142" border="0" cellpadding="0" cellspacing="1" width="100%">
							<tbody><tr bgcolor="#212021" height="27">
								<td align="center" width="110"><font color="#ffffff"><b><nobr>배팅일시</nobr></b></font></td>
								<td align="center" width="110"><font color="#ffffff"><b><nobr>경기날짜</nobr></b></font></td>
								<td align="center" width="270"><font color="#ffffff"><b><nobr>(승)홈 팀</nobr></b></font></td>
								<td align="center" width="85"><font color="#ffffff"><b><nobr>무/핸디캡</nobr></b></font></td>
								
								<td align="center" width="270"><font color="#ffffff"><b><nobr>(패)원정팀</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>배팅팀</nobr></b></font></td>
								<td align="center" width="95"><font color="#ffffff"><b><nobr>경기결과</nobr></b></font></td>
								<td align="center" width="80"><font color="#ffffff"><b><nobr>적중유무</nobr></b></font></td>
								<td align="center" width="70"><font color="#ffffff"><b><nobr>삭제</nobr></b></font></td>
								<td align="center" width="90"><font color="#ffffff"><b><nobr>복사</nobr></b></font></td>
							</tr>
							
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		int count = 0;
		for (BetGame betGame : betGameList) {
%>
							<tr bgcolor="#000000" height="25">
								<td align="center"><nobr><font color="#ffffff"><%=betting.getDateStr() %></font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=betGame.getGameDateStr()%></font></nobr></td>
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
									<img src="images/btn_coment_del.gif" onclick="deleteMyBetting(<%=betting.getId()%>)">
									<%
									}
									%>
								</td>
								<td align="center" rowspan="<%=betGameCount%>" nowrap>
									<img src="images/btn_board.jpg" onclick="location.href='board.aspx?mode=viewBoardWriteForm&boardName=user&bettingId=<%=betting.getId()%>'" style="cursor:hand"><br>
									<img src="images/btn_qna.jpg" onclick="location.href='board.aspx?mode=viewBoardWriteForm&boardName=qna&bettingId=<%=betting.getId()%>'" style="cursor:hand">
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
</td>
</tr>
<tr>
</tr>
</table>
<br>
<br>
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
<br>
<br>
<script>
function deleteMyBetting(id)
{
	if (confirm("배팅 기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyBetting";
		query += "&bettingId=" + id;
		var http = new JKL.ParseXML("myBet.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function goPage(pageIndex)
{
	location.href = "myBet.aspx?mode=viewMyBettingList&pageIndex=" + pageIndex;
}
</script>
<%@include file="../footer.jsp"%>