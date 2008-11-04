<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<Transaction> transactionList = (List<Transaction>) request.getAttribute("transactionList");
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Integer totalSum = (Integer) request.getAttribute("totalSum");
	
	String type = XwinUtil.nvl(request.getParameter("type"));
	String isCharge = XwinUtil.nvl(request.getParameter("isCharge"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	String note = XwinUtil.nvl(request.getParameter("note"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
		 
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
<div class="title">입출금내역</div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>
<form method='get' name='search' action='adminTran.aspx'>
	<input type='hidden' name='mode' value='viewTransactionList'/>
	<input type='hidden' name='pageIndex'/>
	종류
	<select name='type' onchange='this.form.submit()'>
		<option value=''>전체</option>
 		<option value='<%=Code.TRAN_TYPE_MONEYIN%>' <%=type.equals(Code.TRAN_TYPE_MONEYIN)?"selected":""%>>입금</option>
 		<option value='<%=Code.TRAN_TYPE_MONEYOUT%>' <%=type.equals(Code.TRAN_TYPE_MONEYOUT)?"selected":""%>>출금</option>
 	</select>
	충전
	<select name='isCharge' onchange='this.form.submit()'>
		<option value=''>전체</option>
 		<option value='Y' <%=isCharge.equals("Y")?"selected":""%>>충전완료</option>
 		<option value='N' <%=isCharge.equals("N")?"selected":""%>>충전대기</option>
		<option value='N' <%=isCharge.equals("C")?"selected":""%>>대기취소</option>
 	</select>
	비고
	<select name='note' onchange='this.form.submit()'>
		<option value=''>전체</option>
 		<option value='Y' <%=note.equals("Y")?"selected":""%>>있음</option>
 		<option value='N' <%=note.equals("N")?"selected":""%>>없음</option>
 	</select>
	<BR>
 	<select name='search'>
 		<option value='money' <%=search.equals("money")?"selected":""%>>금액</option>
		<option value='userName' <%=search.equals("userName")?"selected":""%>>예금주</option>
 	</select>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	일자
	<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
	<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">		
 	<input type='submit' value='검 색'/>
</form>

<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th>종류</th>
		<th>날짜</td>
		<th>예금주</td>
		<th>금액</td>
		<th>잔액</td>
		<th>충전여부</td>
		<th>대기취소</td>
		<th>비고</th>
	</tr>
	<%
	if (transactionList != null) {
		for (Transaction transaction : transactionList) {
			boolean plus = transaction.getType().equals(Code.TRAN_TYPE_MONEYIN);
	%>
	<tr>		
		<td><%=Code.getValue(transaction.getType())%></td>
		<td><%=XwinUtil.toDateStr(transaction.getDate(), 0)%></td>
		<td><%=transaction.getUserName()%></td>
		<td><font color=<%=plus?"blue":"red"%>><%=XwinUtil.comma3(transaction.getMoney())%></font></td>
		<td><%=XwinUtil.comma3(transaction.getBalance())%></td>
		<td>
			<%if (transaction.getType().equals(Code.TRAN_TYPE_MONEYIN)) { %>
				<%=transaction.getIsCharge().equals("Y")?"충전완료":transaction.getIsCharge().equals("C")?"대기취소":"충전대기"%>
			<%} %>
		</td>
		<td>
			<%if (transaction.getIsCharge().equals("N")) { %>
				<input type="button" value="대기취소" onclick="cancelIsCharge(<%=transaction.getId()%>)"/>
			<%} %>
		</td>
		<td><%=XwinUtil.nvl(transaction.getNote())%></td>
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
function cancelIsCharge(id)
{
	if (confirm("대기취소하시겠습니까?")) {
		var query = "mode=cancelIsCharge";
		query += "&id=" + id;
		var http = new JKL.ParseXML("adminTran.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	} 
}

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>
