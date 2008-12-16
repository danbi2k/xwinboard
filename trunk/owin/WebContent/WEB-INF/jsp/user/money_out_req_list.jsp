<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<MoneyOut> moneyOutList = (List<MoneyOut>)request.getAttribute("moneyOutList");
	Integer totalCount = (Integer)request.getAttribute("moneyOutCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960"  style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_outmoney.gif"></td><td>환전요청을 하시면 머니를 실계좌로 입금해 드립니다.</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_outmoney.gif"		 onclick="location.href='moneyOut.php?mode=viewMoneyOutRequest'" style="cursor:hand;filter:gray();"></td>
			<td><img src="images/tab_outmoney_list.gif" onclick="location.href='moneyOut.php?mode=viewMoneyOutRequestList'" style="cursor:hand;" hspace="3"></td>
		</tr></table>

	</td></tr>
	</table>




	<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="100" align="center">
	<col width="*">
	<col width="80" align="right">
	<col width="80" align="center">
	<col width="100" align="center">
	<col width="20" align="center">
	</colgroup>

	<tr bgcolor="#ce892c">
		<th style="color:white">신청일시</th>
		<th style="color:white" align="center">환전계좌</th>
		<th style="color:white" align="center">환전액</th>
		<th style="color:white">상태</th>
		<th style="color:white">처리일시</th>
		<th style="color:white">삭제</th>
	</tr>

	<%
		if (moneyOutList != null && moneyOutList.size() > 0) {
			for (MoneyOut moneyOut : moneyOutList) {
	%>
		<tr bgcolor='black'>
			<td><%=moneyOut.getReqDateStr()%></td>
			<td>[<%=moneyOut.getBankName()%>] <%=moneyOut.getNumber()%> <%=moneyOut.getName()%></td>
			<td><%=XwinUtil.comma3(moneyOut.getMoney())%></td>
			<td><%=Code.getValue(moneyOut.getStatus())%></td>
			<td><%=moneyOut.getProcDateStr()%></td>
			<td>
				<%if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST)) { %>
				<%} else {%>
				<img src="images/btn_coment_del.gif" onclick="removeMoneyOutRequestLog(<%=moneyOut.getId()%>)" title="환전기록삭제">
				<%} %>
			</td>
		</tr>
	<%	
			}
		} else {
	%>
	<tr bgcolor='black'><td colspan='6' height='150' align='center'>최근 환전 신청내역이 없습니다.</td></tr>
	<%
		}
	%>
	</table>
	<table width=100%>
	<tr bgcolor='black'>
	<td colspan='6' height='40' align='center' bgcolor='black'>
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
	</td>
	</tr>
	</table>
</td></tr>
</table>

<script>
function goPage(index)
{
	location.href="moneyOut.php?mode=viewMoneyOutRequestList&pageIndex=" + index;
}

function removeMoneyOutRequestLog(id)
{
	if (confirm("환전 기록을 삭제 하시겠습니까?")) {
		var query = "mode=removeMoneyOutRequestLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("moneyOut.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>

<%@include file="../footer.jsp"%>