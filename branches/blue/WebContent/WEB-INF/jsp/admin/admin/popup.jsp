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

<%
	String grade = request.getParameter("grade");
	if (grade == null)
		grade = Code.USER_GRADE_VIP;
	
	String popup = (String) request.getAttribute("popup");
	String popupFlag = (String) request.getAttribute("popupFlag");
%>

<div class="title">긴급공지 (<%=Code.getValue(grade)%>)</div>

<form name="chgrade" action="admin.aspx">
<input type="hidden" name="mode" value="viewPopup"/>
<select name='grade' onChange='this.form.submit()'>
	<option value='<%=Code.USER_GRADE_VIP%>' <%=grade.equals(Code.USER_GRADE_VIP)?"selected":""%>>VIP</option>
	<option value='<%=Code.USER_GRADE_NORMAL%>' <%=grade.equals(Code.USER_GRADE_NORMAL)?"selected":""%>>일반</option>
</select>
</form>

<form name="notice">
<table class="prettytable">
	<tr>
		<td width="10%">내용</td>
		<td width="*">
		<textarea name="text" style='width=100%;height=500px'><%
	    String context = popup;
	    context = StringEscapeUtils.escapeHtml(context);
	    out.print(context);
	    %></textarea>
		<input type="checkbox" name="popupFlag" <%=popupFlag.equals("Y")?"checked":""%>/> 표시여부
		</td>
	</tr>					
</table>
<input type='button' value='긴급공지 저장' onclick="savePopup()"/>
</form>

<script>
function savePopup()
{
	if (havingSqlKeyword(document.notice.text.value)) {
		alert("내용에 사용할수 없는 문자열이 있습니다"); document.notice.text.focus(); return false;
	}
	
	var query = "mode=savePopup";
	//alert(Xwin.Escape(document.notice.text.value));
	query += "&popup=" + Xwin.Escape(document.notice.text.value);
	if (document.notice.popupFlag.checked == true)
		query += "&popupFlag=Y";
	else
		query += "&popupFlag=N";
	query += "&grade=<%=grade%>";
	
	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.href="admin.aspx?mode=viewPopup&grade=<%=grade%>";
}
</script>

<%@ include file="../admin_footer.jsp"%>