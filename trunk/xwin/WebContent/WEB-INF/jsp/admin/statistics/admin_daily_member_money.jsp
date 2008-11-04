<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.statistics.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<MemMoneyStat> memMoneyStatList = (List<MemMoneyStat>) request.getAttribute("memMoneyStatList");
	Integer totalCount = (Integer) request.getAttribute("memMoneyStatCount");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));	
%>

		  
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">일자별유저보유액</div>

<form method="get" name="list" action="adminStat.aspx">
<input type="hidden" name="mode" value="viewDailyMemberMoneySummary"/>
<input type="hidden" name="pageIndex"/>
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th>날짜</th>
		<th>유저보유액 ①</th>
		<th>배팅금액 ②</th>
		<th>총액  ① + ②</th>
	</tr>

	<%
	if (memMoneyStatList != null) {
		for (MemMoneyStat memMoneyStat : memMoneyStatList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td><%=XwinUtil.toDateStr(memMoneyStat.getDate(), 1)%></td>
		<td><%=XwinUtil.comma3(memMoneyStat.getBalance())%></td>
		<td><%=XwinUtil.comma3(memMoneyStat.getMoney())%></td>
		<td><B><font color="red"><%=XwinUtil.comma3(memMoneyStat.getBalance() + memMoneyStat.getMoney())%></font></B></td>
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
