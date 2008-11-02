<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	String grade = XwinUtil.nvl(request.getParameter("grade"));
%>

<SCRIPT LANGUAGE="JavaScript">
function checkform()
{
	var f = document.notice;
	if (!f.title) {alert("제목을 입력하세요");return false;}
	if (!f.context) {alert("내용을 입력하세요");return false;}

	f.submit();
}
</SCRIPT>

<div class="title">공지사항쓰기</div>
<form name="notice" action="adminBoard.aspx" method="post">
<input type="hidden" name="mode" value="writeNotice"/>
<input type="hidden" name="grade" value="<%=grade%>"/>
<table class="list">
	<tr>
		<th width="10%">종류</td>
		<td width="*">
		<select name="type">			
			<option value="<%=Code.BOARDITEM_TYPE_NOTICE%>">공지사항</option>
			<option value="<%=Code.BOARDITEM_TYPE_USER%>">일반글</option>
		</select>
		</td>
	</tr>
	<tr>
		<th width="10%">제목</td>
		<td width="*">
		<input type="text" name="title" style='width=100%' size='50'></input>
		</td>
	</tr>
	<tr>
		<th width="10%">내용</td>
		<td width="*">
		<textarea name="context" style='width=100%;height=500px'></textarea>
		</td>
	</tr>					
</table>
<input type='button' value='저장' onclick="checkform()"/>
</form>

<%@ include file="../admin_footer.jsp"%>