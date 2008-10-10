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

<form name="notice">
<table class="prettytable">
	<tr>
		<td width="10%">내용</td>
		<td width="*">
		<textarea name="text" style='width=100%;height=500px'>
		 <%
	    String context = Admin.POPUP;
	    context = StringEscapeUtils.escapeHtml(context);
	    context = context.replaceAll("\n", "<br>");
	    out.print(context);
	    %>
		</textarea>
		<input type="checkbox" name="popupFlag" <%=Admin.POPUPFLAG.equals("Y")?"checked":""%>/> 표시여부
		</td>
	</tr>					
</table>
<input type='button' value='긴급공지 저장' onclick="saveNotice()"/>
</form>

<script>
function savePopup()
{
	var query = "mode=savePopup";
	query += "&popup=" + document.notice.text.value;
	if (document.popupFlag.checked == true)
		query += "&popupFlag=Y";
	else
		query += "&popupFlag=N";
	
	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.href="admin.aspx?mode=viewPopup";
}
</script>

<%@ include file="../admin_footer.jsp"%>