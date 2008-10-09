<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	List<BoardItem> qnaList = (List<BoardItem>) request.getAttribute("qnaList");
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<form method='post' name='search' action='adminMember.aspx'>
	<input type='hidden' name='mode' value=''/>
 </form>

<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th width=10%>아이디</th>
		<th width=10%>닉네임</th>
		<th width=*>제목</th>
		<th width=15%>작성시각</th>
	</tr>
<%
if (qnaList != null) {
	for (BoardItem boardItem : qnaList) {
%>
	<tr>
		<td width=5%><%=boardItem.getId()%></td>
		<td width=10%><%=boardItem.getUserId()%></td>
		<td width=10%><%=boardItem.getNickName()%></td>
		<td width=*><a href="adminQna.aspx?mode=viewQnaDetail&id=<%=boardItem.getId()%>"><%=boardItem.getTitle()%></a></td>
		<td width=15%><%=XwinUtil.toDateStr(boardItem.getDate(), 1)%></td>
	</tr>
<%
	}
}
%>							
</table>


<%@ include file="../admin_footer.jsp"%>