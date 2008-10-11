<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 20;
	int SHOWPAGE = 10;
	List<BoardItem> boardItemList = (List<BoardItem>) request.getAttribute("boardItemList");
	Integer totalCount  = (Integer) request.getAttribute("boardItemCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">게시판</div>

<form method='get' name='search' action='adminBoard.aspx'>
	<input type='hidden' name='mode' value='viewBoardList'/>
	<input type='hidden' name='pageIndex'/>
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
if (boardItemList != null) {
	for (BoardItem boardItem : boardItemList) {
%>
	<tr>
		<td width=5%><%=boardItem.getId()%></td>
		<td width=10%><%=boardItem.getUserId()%></td>
		<td width=10%><%=boardItem.getNickName()%></td>
		<td width=*><a href="adminBoard.aspx?mode=viewBoardDetail&id=<%=boardItem.getId()%>"><%=boardItem.getTitle()%></a></td>
		<td width=15%><%=XwinUtil.toDateStr(boardItem.getDate(), 1)%></td>
	</tr>
<%
	}
}
%>							
</table>

<div class="pages">
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) totalCount / ROWSIZE + 1;
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b> <%=i+1%> </b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
	}
%>
</div>

<input type="button" value="공지사항쓰기" onclick="location.href='adminBoard.aspx?mode=viewWriteNotice'"/>
<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>