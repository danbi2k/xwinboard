<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">NOTICE</div>

<form name="notice">
<table class="prettytable">
	<tr>
		<td width="10%">내용</td>
		<td width="*">
		<textarea name="text" style='width=100%;height=500px'><%
	    String context = Admin.NOTICE;
	    context = StringEscapeUtils.escapeHtml(context);
	    out.print(context);
	    %></textarea>
		</td>
	</tr>					
</table>
<input type='button' value='Notice저장' onclick="saveNotice()"/>
</form>

<script>
function saveNotice()
{
	var query = "mode=saveNotice";
	query += "&notice=" + Xwin.Escape(document.notice.text.value);
	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.href="admin.aspx?mode=viewNotice";
}
</script>

<%@ include file="../admin_footer.jsp"%>