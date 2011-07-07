<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<Dealer> dealerList = (List<Dealer>) request.getAttribute("dealerList");
	Integer totalCount = (Integer) request.getAttribute("dealerCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	
	int dealerIdx = totalCount - (pIdx * ROWSIZE);
%>

<div class="title">총판목록</div>
<input type="button" value="등록하기" onclick="location.href='adminDealer.aspx?mode=viewRegisterDealerForm'">

<table class="prettytable">
	<tr>
		<th width=10%>번호</th>
		<th width=25%>총판아이디</th>
		<th width=20%>선취수수료</th>
		<th width=20%>후취수수료</th>
		<th width=25%>상태</th>
	</tr>
<%
if (dealerList != null) {
	for (Dealer dealer : dealerList) {
%>
	<tr>
		<td width=5%><%=dealerIdx--%></td>
		<td width=30%><a href='adminDealer.aspx?mode=viewDealerSummary&dealerId=<%=dealer.getDealerId()%>'><%=dealer.getDealerId()%></a></td>
		<td width=20%><%=dealer.getPreFeeRate()%></td>
		<td width=20%><%=dealer.getPostFeeRate()%></td>
		<td width=25%><%=Code.getValue(dealer.getStatus())%></td>
	</tr>
<%
 }
}
%>							
</table>

<div class="pages">
<%
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
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