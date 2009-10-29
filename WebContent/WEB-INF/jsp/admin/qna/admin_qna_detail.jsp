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
	
	String grade = XwinUtil.nvl(request.getParameter("grade"));
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title"><%=grade.equals(Code.USER_GRADE_VIP)?"고객센터 (VIP)":"고객센터 (일반)" %></div>

<form method='post' name='search' action='adminMember.aspx'>
	<input type='hidden' name='mode' value=''/>
 </form>

<h3>문의</h3>
<table class="list">
	<tr>
		<th width="10%" height="30px">작성자</th>
		<td width="*" style="padding-left:10px;"><a href='javascript:goMemberDetail("<%=boardItem.getUserId()%>")'><%=boardItem.getUserId()%></a> (<%=boardItem.getNickName()%>)</td>
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
</table>
</form>
<input type='button' value='답변저장' onclick="answerQna()"/>

<script>
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

function answerQna()
{
	if (havingSqlKeyword(document.answer.comment.value)) {
		alert("내용에 사용할수 없는 문자열이 있습니다"); document.answer.comment.focus(); return false;
	}
	
	var query = "mode=answerQna";
	query += "&id=" + <%=boardItem.getId()%>;
	query += "&comment=" + Xwin.Escape(document.answer.comment.value);
	var http = new JKL.ParseXML("adminQna.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.reload();
}
</script>

<%@ include file="../admin_footer.jsp"%>