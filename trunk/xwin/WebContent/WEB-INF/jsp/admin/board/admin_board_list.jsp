<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 25;
	int SHOWPAGE = 10;
	List<BoardItem> boardItemList = (List<BoardItem>) request.getAttribute("boardItemList");
	Integer totalCount  = (Integer) request.getAttribute("boardItemCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">게시판</div>

<form name='search' method='get' action='adminBoard.aspx'>
<input type='hidden' name='mode' value='viewBoardList'/>
<input type='hidden' name='pageIndex'/>
<select name='search'>
	<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
	<option value='nickName' <%=search.equals("nickName")?"selected":""%>>회원닉네임</option>
</select>
<input type='text' name='keyword' value='<%=keyword%>'>
작성시각
<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">
<input type='submit' value='검 색'>
</form> 

<table class="list">
	<tr>
		<th width=5%>번호</th>
		<th width=20%>아이디 (닉네임)</th>
		<th width=*>제목</th>
		<th width=15%>작성시각</th>
	</tr>
<%
if (boardItemList != null) {
	for (BoardItem boardItem : boardItemList) {
%>
	<tr>
		<td width=5% align=center><%=boardItem.getId()%></td>
		<td width=20% align=center><%=boardItem.getUserId()%> (<%=boardItem.getNickName()%>)
		<td width=*>&nbsp;&nbsp;<a href="adminBoard.aspx?mode=viewBoardDetail&id=<%=boardItem.getId()%>"><%=boardItem.getTitle()%>&nbsp;&nbsp;[<%=boardItem.getCommentCount()%>]</a></td>
		<td width=15% align=center><%=XwinUtil.toDateStr(boardItem.getDate(), 1)%></td>
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