<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.statistics.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<MoneyOutStat> moneyOutList = (List<MoneyOutStat>) request.getAttribute("moneyOutList");
	Integer totalCount = (Integer) request.getAttribute("moneyOutCount");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));	
%>

		  
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">환전계좌내역</div>

<form method="get" name="list" action="adminStat.aspx">
<input type="hidden" name="mode" value="viewMoneyOutStat"/>
<input type="hidden" name="pageIndex"/>
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th>은행명</th>
		<th>계좌번호</th>
		<th>예금주</th>
		<th>환전금액</th>
		<th>환전횟수</th>
	</tr>

	<%
	if (moneyOutList != null) {
		for (MoneyOutStat moneyOutStat : moneyOutList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td><%=moneyOutStat.getBankName()%></td>
		<td><%=moneyOutStat.getNumber()%></td>
		<td><%=moneyOutStat.getName()%></td>
		<td><%=XwinUtil.comma3(moneyOutStat.getOutSum())%></td>
		<td><%=moneyOutStat.getOutCount()%></td>
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
	var frm = document.list;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>
