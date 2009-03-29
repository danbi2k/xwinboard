<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
	final Integer ROWSIZE = 40;
	final Integer SHOWPAGE = 20;

	Toto toto = (Toto) request.getAttribute("toto");
	List<BetToto> betTotoList = (List<BetToto>) request.getAttribute("betTotoList");
	Integer totalCount = (Integer) request.getAttribute("betTotoCount");
	Long betTotoMoney = (Long) request.getAttribute("betTotoMoney");
	
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String runStatus = XwinUtil.nvl(request.getParameter("runStatus"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

<%@ include file="../admin_header.jsp"%>

<div class="title">토토 구매 현황</div>

<form method='get' name='search' action='adminToto.aspx'>
<input type='hidden' name='mode' value='viewBetTotoList'/>
<input type='hidden' name='pageIndex'/>

상태
<select name='runStatus' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.BET_STATUS_RUN%>' <%=runStatus.equals(Code.BET_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
	<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=runStatus.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
	<option value='<%=Code.BET_STATUS_FAILURE%>' <%=runStatus.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
	<option value='<%=Code.BET_STATUS_CANCEL%>' <%=runStatus.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>	
 </select>
<select name='search'>
	<option value='userIdLike' <%=search.equals("userIdLike")?"selected":""%>>회원아이디</option>
	<option value='nickNameLike' <%=search.equals("nickNameLike")?"selected":""%>>회원닉네임</option>
</select>
<input type='text' name='keyword' value='<%=keyword%>'>
<input type='submit' value='검 색'>
</form>
<BR>
제목 : <%=toto.getTitle()%> <BR>
총발매수 : <%=totalCount%> <BR>
총발매액 : <%=XwinUtil.comma3(betTotoMoney)%> <BR>


<table class="prettytable">
		<tr>
		<th width=5%>번호</th>
		<th>아이디 (닉네임)</th>
		<th>구매일</th>
		<th>구매액</th>
		<th>당첨액</th>
		<th>상태</th>
  	</tr>

	<%
	if (betTotoList != null) {
		for (BetToto betToto : betTotoList) {
			
	%>
		<tr>
		<td width=5%><a href="adminToto.aspx?mode=viewBetTotoDetail&id=<%=betToto.getId()%>"><%=betToto.getId()%></a></td>
		<td width=15% align='left'>&nbsp;<a href='javascript:goMemberDetail("<%=betToto.getUserId()%>")'><%=betToto.getUserId()%></a> (<%=betToto.getNickName()%>)
		<td width=15%><%=XwinUtil.getBoardItemDate(betToto.getDate())%></td>
		<td><%=XwinUtil.comma3(betToto.getMoney())%></td>
		<td><%=XwinUtil.comma3(betToto.getExpect())%></td>
		<td><%=Code.getValue(betToto.getRunStatus())%></td>
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