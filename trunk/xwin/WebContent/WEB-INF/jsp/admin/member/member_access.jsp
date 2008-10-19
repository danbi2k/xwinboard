<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 25;
	int SHOWPAGE = 10;
	List<Access> accessList = (List<Access>) request.getAttribute("accessList");
	Integer totalCount = (Integer) request.getAttribute("accessCount");

	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
%>
<div class="title">접속목록</div>

<form method='GET' action="adminMember.aspx">
	<input type='hidden' name='mode' value='viewAccessList'/>
	<input type='hidden' name='pageIndex'/>
	<select name='search'>
		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>회원닉네임</option>
	</select>
	<input type='text' name='keyword' value='<%=keyword%>'>
	<input type='submit' value='검 색'>
 </form>

<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th width=10%>아이디</th>
		<th width=15%>닉네임</th>
		<th width=*>접속시각</th>
		<th width=15%>아이피</th>
	</tr>
<%
if (accessList != null) {
	for (Access access : accessList) {
%>
	<tr>
		<td width=5%><%=access.getId()%></td>
		<td width=10%><%=access.getUserId()%></td>
		<td width=10%><%=access.getNickName()%></td>
		<td width=15%><%=XwinUtil.toDateStr(access.getDate(), 1)%></td>
		<td width=10%><%=access.getIpAddress()%></td>
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
<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>