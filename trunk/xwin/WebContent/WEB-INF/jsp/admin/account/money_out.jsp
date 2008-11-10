<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Integer totalSum = (Integer) request.getAttribute("totalSum");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	String bankNumber = XwinUtil.nvl(request.getParameter("bankNumber"));
%>

<div class="title">환전내역</div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>
<form method='get' name='search' action='adminStat.aspx'>
	<input type='hidden' name='mode' value='viewMoneyOutList'/>
	<input type='hidden' name='pageIndex'/>
	<input type="hidden" name="bankNumber" value="<%=bankNumber%>"/>
 	<select name='search'>
		<option value='name' <%=search.equals("name")?"selected":""%>>예금주</option>
 		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
 	</select>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	일자
	<input type='hidden' name='dateType' value='proc'/>
	<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
	<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">		
 	<input type='submit' value='검 색'/>
</form>

<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		

		<th>아이디 (닉네임)</th>
		<th>예금주</td>
		<th>요청금액</td>
		<th>은행명</td>
		<th>계좌번호</td>
		<th>신청일</td>
		<th>처리일</td>
		<th>상태</td>
	</tr>
	<%
	if (moneyOutList != null) {
		for (MoneyOut moneyOut : moneyOutList) {
	%>
	<tr>		
		
		<td><a href='javascript:goMemberDetail("<%=moneyOut.getUserId()%>")'><%=moneyOut.getUserId()%></a> (<%=moneyOut.getNickName()%>)</td>
		<td><%=moneyOut.getName()%></td>
		<td><font color=red><%=XwinUtil.comma3(moneyOut.getMoney())%></font></td>
		<td><%=moneyOut.getBankName()%></td>
		<td><%=moneyOut.getNumber()%></td>
		<td><%=moneyOut.getReqDateStr()%></td>
		<td><%=moneyOut.getProcDateStr()%></td>
		<td><%=Code.getValue(moneyOut.getStatus())%></td>
	</tr>
<%
	}
}
%>

</table>
</form>
<BR>
<!-- input type="button" value="삭제" onclick="deleteCheckedItem()"/ -->
<BR>
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
