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

<div class="title">게시판</div>

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
<input type="button" value="삭제" onclick="deleteBoardItem()"/

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
		location.href='adminBoard.aspx?mode=deleteBoardItem&id=<%=boardItem.getId()%>';
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>