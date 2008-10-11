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

<table class="prettytable">
	<tr>
		<td width="10%">작성자</td>
		<td width="*"><%=boardItem.getNickName()%></td>
	</tr>
	<tr>
		<td width="10%">제목</td>
		<td width="*"><%=boardItem.getTitle()%></td>
	</tr>
	<tr>
		<td width="10%">내용</td>
		<td width="*">
		 <%
	    String context = boardItem.getContext();
	    context = StringEscapeUtils.escapeHtml(context);
	    context = context.replaceAll("\n", "<br>");
	    out.print(context);
	    %>
		</td>
	</tr>					
</table>

<input type="button" value="리스트" onclick="history.back()"/>
<input type="button" value="삭제" onclick="deleteBoardItem()"/>

<script>
function deleteBoardItem()
{
	if (confirm("삭제하시겠습니까?")) {
		location.href='adminBoard.aspx?mode=deleteBoardItem&id=<%=boardItem.getId()%>';
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>