<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	BoardItem boardItem = (BoardItem) request.getAttribute("boardItem");
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

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
function answerQna()
{
	var query = "mode=answerQna";
	query += "&id=" + <%=boardItem.getId()%>;
	query += "&comment=" + document.answer.comment.value;
	var http = new JKL.ParseXML("adminQna.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.href="adminQna.aspx?mode=viewQnaList";
}
</script>

<%@ include file="../admin_footer.jsp"%>