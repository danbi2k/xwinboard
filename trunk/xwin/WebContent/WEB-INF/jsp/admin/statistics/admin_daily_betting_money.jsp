<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.statistics.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 20;
	int SHOWPAGE = 10;
	
	List<BetMoneyStat> betMoneyStatList = (List<BetMoneyStat>) request.getAttribute("betMoneyStatList");
	Integer totalCount = (Integer) request.getAttribute("betMoneyStatCount");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));	
%>

		  
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">일일정산내역</div>

<form method="get" name="list" action="adminStat.aspx">
<input type="hidden" name="mode" value="viewDailyBettingMoneySummary"/>
<input type="hidden" name="pageIndex"/>
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th>날짜</th>
		<th>총배팅금액 ①</th>
		<th>총당첨금액 ②</th>
		<th>순순익  ① - ②</th>
	</tr>

	<%
	if (betMoneyStatList != null) {
		for (BetMoneyStat betMoneyStat : betMoneyStatList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td><%=XwinUtil.toDateStr(betMoneyStat.getDate(), 2)%></td>
		<td><%=XwinUtil.comma3(betMoneyStat.getInMoney())%></td>
		<td><%=XwinUtil.comma3(betMoneyStat.getOutMoney())%></td>
		<td><B><font color="red"><%=XwinUtil.comma3(betMoneyStat.getInMoney() - betMoneyStat.getOutMoney())%></font></B></td>
	  </tr>
	<%
		}
	}
	%>
 </table>
</form>
<BR>
<BR>
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
	var frm = document.list;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>
