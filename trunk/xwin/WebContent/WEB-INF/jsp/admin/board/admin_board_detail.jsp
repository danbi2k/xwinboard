<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	BoardItem boardItem = (BoardItem) request.getAttribute("boardItem");
	List<BoardComment> boardCommentList = boardItem.getBoardCommentList();
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">게시판</div>

<form method='post' name='search' action='adminMember.aspx'>
	<input type='hidden' name='mode' value=''/>
 </form>

<table class="list">
	<tr>
		<th width="10%">작성자</th>
		<td width="*"><%=boardItem.getNickName()%></td>
	</tr>
	<tr>
		<th width="10%">제목</th>
		<td width="*"><%=boardItem.getTitle()%></td>
	</tr>
	<tr>
		<th width="10%" height="300px">내용</h>
		<td width="*" valign="top">
		 <%
	    String context = boardItem.getContext();
	    context = StringEscapeUtils.escapeHtml(context);
	    context = context.replaceAll("\n", "<br>");
	    out.print(context);
	    %>
		</td>
	</tr>					
</table>

<br>
<br>

<input type="button" value="리스트" onclick="history.back()"/>
<input type="button" value="삭제" onclick="deleteBoardItem()"/>

<br>
<br>

<form name="cmt">
<table class="list">
<tr>
	<th width="10%">관리자</th>
	<td width="*"><input type="text" name="comment" width=100% size="90"></td>
	<td width="10%"><input type="button" value="댓글입력" onclick="writeBoardComment()"></td>
</tr>
<%
if (boardCommentList != null) {
	for (BoardComment boardComment : boardCommentList) {
%>
<tr>
	<th width="10%"><%=boardComment.getNickName()%></th>
	<td width="*"><%=StringEscapeUtils.escapeHtml(boardComment.getComment())%></td>
	<td width="10%"  align=center><img src="images/btn_coment_del.gif" onclick="deleteBoardComment(<%=boardComment.getId()%>)"></td>
</tr>
<%
	}
}
%>
</table>
</form>
<script>
function writeBoardComment()
{
	var query = "mode=writeBoardComment";
	query += "&comment=" + document.cmt.comment.value;
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
		location.href='adminBoard.aspx?mode=deleteBoardItem&id=<%=boardItem.getId()%>';
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>