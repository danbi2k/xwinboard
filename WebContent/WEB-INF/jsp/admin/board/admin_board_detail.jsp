<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	BoardItem boardItem = (BoardItem) request.getAttribute("boardItem");
	Betting betting = (Betting) request.getAttribute("betting");
	List<BoardComment> boardCommentList = boardItem.getBoardCommentList();
	String grade = XwinUtil.nvl(request.getParameter("grade"));
%>

<div class="title"><%=grade.equals(Code.USER_GRADE_VIP)?"게시판 (VIP)":"게시판 (일반)" %></div>
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
<form method='post' name='update' action='adminBoard.aspx'>
	<input type='hidden' name='mode' value='updateBoardItem'/>
	<input type="hidden" name="id" value="<%=boardItem.getId()%>"/>
	<input type="hidden" name="boardName" value="<%=boardItem.getBoardName()%>"/>

<table class="list">
	<tr>
		<th width="10%">작성자</th>
		<td width="*"><%=boardItem.getNickName()%></td>
	</tr>
	<tr>
		<th width="10%">제목</th>
		<td width="*"><input type="text" name="title" style='width=100%' size='50' value='<%=boardItem.getTitle()%>'></input></td>
	</tr>
	<tr>
		<th width="10%">내용</h>
		<td width="*" valign="top">
		<textarea name="context" style='width=100%;height=300px'><%
	    String context = boardItem.getContext();
	    out.print(context);
	    %></textarea>
		</td>
	</tr>					
</table>
 </form>

<br>
<br>

<input type="button" value="리스트" onclick="history.back()"/>
<input type="button" value="수정" onclick="updateBoardItem()"/>
<input type="button" value="삭제" onclick="deleteBoardItem()"/>

<br>
<br>

<form name="cmt">
<table class="list">
<tr>
	<th width="10%">관리자</th>
	<td width="*"><textarea name="comment" style='width=100%;height=50px'></textarea></td>
	<td width="10%"><input type="button" value="댓글입력" onclick="writeBoardComment()"></td>
</tr>
<%
if (boardCommentList != null) {
	for (BoardComment boardComment : boardCommentList) {
%>
<tr>
	<th width="10%"><%=boardComment.getNickName()%></th>
	<td width="*">
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
</form>
<script>
function updateBoardItem()
{
	var f = document.update;
	if (!f.title) {alert("제목을 입력하세요");return false;}
	if (!f.context) {alert("내용을 입력하세요");return false;}

	f.submit();
}

function writeBoardComment()
{
	if (havingSqlKeyword(document.cmt.comment.value)) {
		alert("내용에 사용할수 없는 문자열이 있습니다"); document.cmt.comment.focus(); return false;
	}
	
	var query = "mode=writeBoardComment";
	query += "&comment=" + Xwin.Escape(document.cmt.comment.value);
	query += "&id=<%=boardItem.getId()%>";
	var http = new JKL.ParseXML("adminBoard.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}

function deleteBoardComment(id)
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=deleteBoardComment";
		query += "&id=" + id;
		var http = new JKL.ParseXML("adminBoard.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();	
	}
}

function deleteBoardItem()
{
	if (confirm("삭제하시겠습니까?")) {
		location.href='adminBoard.aspx?mode=deleteBoardItem&id=<%=boardItem.getId()%>&grade=<%=boardItem.getGrade()%>';
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>