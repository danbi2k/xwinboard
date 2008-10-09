<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	String notice = (String) request.getAttribute("notice");
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<form name="notice">
<table class="prettytable">
	<tr>
		<td width="10%">내용</td>
		<td width="*">
		 <%
	    String context = notice;
	    context = StringEscapeUtils.escapeHtml(context);
	    context = context.replaceAll("\n", "<br>");
	    out.print(context);
	    %>
		</td>
	</tr>					
</table>
<input type='button' value='Notice저장' onclick="saveNotice()"/>
</form>

<script>
function saveNotice()
{
	var query = "mode=saveNotice";
	query += "&notice=" + document.answer.comment.value;
	var http = new JKL.ParseXML("adminBoard.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.href="adminBoard.aspx?mode=viewNotice";
}
</script>

<%@ include file="../admin_footer.jsp"%>