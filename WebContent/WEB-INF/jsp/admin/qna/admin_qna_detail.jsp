<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.domain.common.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	BoardItem boardItem = (BoardItem) request.getAttribute("boardItem");
	Betting betting = (Betting) request.getAttribute("betting");
	List<BoardComment> boardCommentList = boardItem.getBoardCommentList();
	List<ReuseComment> reuseCommentList = (List<ReuseComment>) request.getAttribute("reuseCommentList");
	
	String grade = XwinUtil.nvl(request.getParameter("grade"));
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title"><%=grade.equals(Code.USER_GRADE_VIP)?"Pusat langganan (VIP)":"Pusat langganan" %></div>
<%
if (betting != null) {
%>
<table>
<tr>
		<td>
						<table class='prettytable'>
							<tbody><tr bgcolor="#EEEEEE" height="27">
								<td  width="110"><b><nobr>배팅일시</nobr></b></td>
								<td  width="110"><b><nobr>경기날짜</nobr></b></td>
								<td  width="270"><b><nobr>(승)홈 팀</nobr></b></td>
								<td  width="85"><b><nobr>무/핸디캡</nobr></b></td>
								
								<td  width="270"><b><nobr>(패)원정팀</nobr></b></td>
								<td  width="60"><b><nobr>배팅팀</nobr></b></td>
								<td  width="95"><b><nobr>경기결과</nobr></b></td>
								<td  width="80"><b><nobr>적중유무</nobr></b></td>
							</tr>
							
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		int count = 0;
		for (BetGame betGame : betGameList) {
%>
							<tr height="25">
								<td ><nobr><%=betting.getDateStr() %></nobr></td>
								<td ><nobr><%=betGame.getGameDateStr()%></nobr></td>
								<td align="right"><nobr>
									
									<%=betGame.getHomeTeam()%>&nbsp;<%=betGame.getWinRateStr()%>&nbsp;
									</nobr></td>
								<td ><nobr>
									<%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>
								</nobr></td>
								
								<td><nobr>&nbsp;
									
									<%=betGame.getLoseRateStr()%>&nbsp;<%=betGame.getAwayTeam()%></nobr></td>
								<td ><nobr><%=Code.getValue(betGame.getGuess())%></nobr></td>
								<td ><nobr>&nbsp;
								<%=Code.getValue(betGame.getResult())%>
								<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%>
								</nobr></td>
								<td ><nobr>
									
									<B><%=Code.getValue(betGame.getResultStatus())%></B></nobr>
								</td>
							</tr>
<%
		}	
	}		
%>	
							<tr><td height="3" colspan="8"></td></tr>
							<tr>
								<td align="center" colspan="8">배당율 : <%=betting.getRateStr()%> / 배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%>원 / 예상적중금액 : <%=XwinUtil.comma3(betting.getExpect())%>원 /
								적중금액 :
								<%
								if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
									out.print(XwinUtil.comma3(betting.getExpect()));
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
</table>
<%
}
%>
<form method='post' name='search' action='adminMember.aspx'>
	<input type='hidden' name='mode' value=''/>
 </form>

<h3>문의</h3>
<table class="list">
	<tr>
		<th width="10%" height="30px">작성자</th>
		<td width="*" style="padding-left:10px;"><%=boardItem.getNickName()%></td>
	</tr>
	<tr>
		<th width="10%" height="30px">제목</th>
		<td width="*" style="padding-left:10px;"><%=boardItem.getTitle()%></td>
	</tr>
	<tr>
		<th width="10%" height="30px">내용</th>
		<td width="*" style="padding-left:10px;">
		 <%
	    String context = boardItem.getContext();
	    context = StringEscapeUtils.escapeHtml(context);
	    context = context.replaceAll("\n", "<br>");
	    out.print(context);
	    %>
		</td>
	</tr>					
</table>

<h3>답변</h3>
<table class="list">
<%
if (boardCommentList != null) {
	for (BoardComment boardComment : boardCommentList) {
%>
<tr>
	<th width="10%"><%=boardComment.getNickName()%></th>
	<td width="*" style="padding-left:10px;" height="25px">
	<%
		String comment = StringEscapeUtils.escapeHtml(boardComment.getComment());
		comment = comment.replaceAll("\n", "<BR>");
		out.print(comment);
	%>
	</td>
	<td width="10%"  align=center><img src="images/btn_coment_del.gif" onclick="deleteBoardComment(<%=boardComment.getId()%>)"></td>
</tr>
<%
	}
}
%>
</table>

<form name="answer">
<table class="prettytable">
<tr>
<td width="10%">답변</td>
<td width="*"><textarea name="comment" style="width:100%;height:300;"></textarea></td>
</tr>
<td width="10%" colspan=2><input type="checkbox" name="reuse">자주사용하는답변에저장</td>
</table>
</form>
<input type='button' value='답변저장' onclick="answerQna()"/>

<BR>
<h3>재사용답변</h3>
<form name="reuse">
<table class="list">
<%
if (reuseCommentList != null) {
	for (ReuseComment reuseComment : reuseCommentList) {
%>
<tr>
	<th width="20"><%=reuseComment.getId()%></th>
	<td width="*" onclick='getReuseComment(<%=reuseComment.getId()%>)' style="cursor:hand">
	<%
		String comment = StringEscapeUtils.escapeHtml(reuseComment.getComment());
		comment = comment.replaceAll("\n", "<BR>");
		out.print(comment);
	%>
	</td>
	<td width="20"  align=center><img src="images/btn_coment_del.gif" onclick="deleteReuseComment(<%=reuseComment.getId()%>)"></td>
</tr>
<%
	}
}
%>
</table>
</form>

<script>
function getReuseComment(id)
{
	var query = "mode=getReuseComment";
	query += "&id=" + id;
	var http = new JKL.ParseXML("adminReuse.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0)
		document.answer.comment.value = result.resultXml.message;	
}

function deleteBoardComment(id)
{
	if (confirm("ingin di hapus?")) {
		var query = "mode=deleteBoardComment";
		query += "&id=" + id;
		var http = new JKL.ParseXML("adminBoard.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();	
	}
}

function answerQna()
{
	if (havingSqlKeyword(document.answer.comment.value)) {
		alert("ada senar kata yang tidak bisa di pakai"); document.answer.comment.focus(); return false;
	}
	
	var query = "mode=answerQna";
	query += "&id=" + <%=boardItem.getId()%>;
	query += "&comment=" + Xwin.Escape(document.answer.comment.value);
	query += "&reuse=" + document.answer.reuse.checked;
	var http = new JKL.ParseXML("adminQna.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.reload();
}
</script>

<%@ include file="../admin_footer.jsp"%>