<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

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
<form name="notice" action="adminBoard.aspx">
<input type="hidden" name="mode" value="writeNotice"/>
<table class="prettytable">
	<tr>
		<td width="10%">제목</td>
		<td width="*">
		<input type="text" name="title" style='width=100%' size='50'></input>
		</td>
	</tr>
	<tr>
		<td width="10%">내용</td>
		<td width="*">
		<textarea name="context" style='width=100%;height=500px'></textarea>
		</td>
	</tr>					
</table>
<input type='button' value='저장' onclick="checkform()"/>
</form>

<%@ include file="../admin_footer.jsp"%>