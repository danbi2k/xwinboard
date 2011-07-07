<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.statistics.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<DealerSummary> dealerSummaryList = (List<DealerSummary>) request.getAttribute("dealerSummaryList");
	String dealerId = request.getParameter("dealerId");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	
	Calendar cal = Calendar.getInstance();
	if (year == null)
		year = "" + cal.get(Calendar.YEAR);
	
	if (month == null)
		month = String.format("%02d", cal.get(Calendar.MONTH) + 1);
%>

<div class="title"><%=dealerId%> 딜러비정산내역</div>
<form method='GET' name='search' action='adminDealer.aspx'>
	<input type='hidden' name='mode' value='viewDealerSummary'/>
	<input type='hidden' name='dealerId' value='<%=dealerId%>'/>
 	<select name='year' onChange='this.form.submit()'>
 	<%
 		for (int i = 2011 ; i < 2020 ; i++) {
 			String iYear = "" + i;
 	%>
		<option value='<%=iYear%>' <%=year.equals(iYear)?"selected":""%>><%=iYear%></option>
	<%} %>
 	</select>
 	<select name='month' onChange='this.form.submit()'>
 	<%
 		for (int i = 1 ; i <= 12 ; i++) {
 			String iMonth = String.format("%02d", i);
 	%>
		<option value='<%=iMonth%>' <%=month.equals(iMonth)?"selected":""%>><%=iMonth%></option>
	<%} %>
 	</select>
 </form>
<table class="prettytable">
	<tr>
		<th width=20%>날짜</th>
		<th width=20%>총배팅머니</th>
		<th width=20%>미적중배팅머니</th>
		<th width=10%>딜러비율</th>
		<th width=10%>선취금액</th>
		<th width=10%>후취금액</th>
		<th width=10%>정산금액</th>
	</tr>
<%
int dealerMoneySum = 0;
if (dealerSummaryList != null) {
	for (DealerSummary summary : dealerSummaryList) {
		int preMoney = ((int) Math.ceil(summary.getTotalBettingMoney() * 0.05));
		int postMoney = ((int) Math.ceil(summary.getFailureBettingMoney() * 0.05));
		int dealerMoney =  preMoney + postMoney;
		dealerMoneySum += dealerMoney;
%>
	<tr>
		<td width=20%><%=XwinUtil.toDateStr(summary.getDate(), 2)%></td>
		<td width=20%><%=XwinUtil.comma3(summary.getTotalBettingMoney())%></a></td>
		<td width=20%><%=XwinUtil.comma3(summary.getFailureBettingMoney())%></td>
		<td width=10%>5%</td>
		<td width=10%><%=XwinUtil.comma3(preMoney)%></td>
		<td width=10%><%=XwinUtil.comma3(postMoney)%></td>
		<td width=10%><%=XwinUtil.comma3(dealerMoneySum)%></td>
	</tr>
<%
	}
}
%>							
</table>

<h2><%=year%>-<%=month%> 총계 : <%=XwinUtil.comma3(dealerMoneySum)%></h2>


<%@ include file="../admin_footer.jsp"%>