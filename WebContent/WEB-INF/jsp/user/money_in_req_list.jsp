<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<MoneyIn> moneyInList = (List<MoneyIn>)request.getAttribute("moneyInList");
	Integer totalCount = (Integer)request.getAttribute("moneyInCount");
	
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

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_inmoney.gif"></td><td>입금계좌를 통해 머니를 충전합니다.</td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width="800" style="margin-top:10">
	<tr><td><b>머니 충전 방법</b></td></tr>
	</table>
	<table width="800" bgcolor="#333333" cellpadding="10" style="border:1 solid #909090;">
	<tr><td style="line-height:20px;">
		1. 입금하실 금액과 입금자명을 입력하고 [머니충전] 신청을 합니다.<br>

		2. 입금하실 계좌 번호를 꼭! 확인합니다. <br>
		3. 인터넷뱅킹, 폰뱅킹, 무통장입금, ATM이체 등의 방법으로 입금을 합니다.<br>
		4. 입금후 5분~10분 이내에 입금확인 처리가 됩니다.<br>
		※ 입력하신 정보(입금액/입금자명)와 실제입금금액/입금자명이 동일해야만 처리가 가능합니다.<br>
	</td></tr>
	</table>

	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_inmoney.gif"		onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequest'" style="cursor:hand;filter:gray();"></td>
			<td><img src="images/tab_inmoney_list.gif" onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequestList'" style="cursor:hand;" hspace="3"></td>
		</tr></table>
	</td></tr>
	</table>

	

	<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="100" align="center">
	<col width="*">
	<col width="80" align="center">
	<col width="80" align="right">
	<col width="80" align="center">
	<col width="100" align="center">
	<col width="20" align="center">
	<col width="20" align="center">
	</colgroup>

	<tr bgcolor="#ce892c">
		<th style="color:white">신청일자</th>
		<th style="color:white" align="center">입금계좌</th>
		<th style="color:white">입금자</th>
		<th style="color:white" align="center">입금액</th>
		<th style="color:white">상태</th>
		<th style="color:white">처리일시</th>
		<th style="color:white">취소</th>
		<th style="color:white">삭제</th>
	</tr>

	<%
		if (moneyInList != null && moneyInList.size() > 0) {
			for (MoneyIn moneyIn : moneyInList) {
				boolean isCancel = moneyIn.getStatus().equals(Code.MONEY_IN_CANCEL) ||
					moneyIn.getStatus().equals(Code.MONEY_IN_CANCEL_TIMEOUT); 
	%>
		<tr bgcolor='black'>
			<td><%=moneyIn.getReqDateStr()%></td>
			<td>[<%=moneyIn.getBankBook().getBankName()%>] <%=moneyIn.getBankBook().getNumber()%></td>
			<td><%=moneyIn.getName()%></td>
			<td><%=isCancel?"<STRIKE>":""%><%=XwinUtil.comma3(moneyIn.getMoney())%><%=isCancel?"</STRIKE>":""%></td>
			<td>
				<font color="<%=isCancel?"white":"#FFC602"%>">
				<%=Code.getValue(moneyIn.getStatus())%>
				</font>
			</td>
			<td><%=moneyIn.getProcDateStr()%></td>
			<td>
				<%if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) { %>
				<img src="images/btn_cancel.gif" onclick="cancelMoneyInRequest(<%=moneyIn.getId()%>)" title="충전신청취소">
				<%}%>
			</td>
			<td>
				<%if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST) == false) { %>
				<img src="images/btn_coment_del.gif" onclick="removeMoneyInRequestLog(<%=moneyIn.getId()%>)" title="충전기록삭제">
				<%} %>
			</td>
		</tr>
	<%	
			}
		} else {
	%>
	<tr bgcolor='black'><td colspan='6' height='150' align='center'>최근 머니충전 신청내역이 없습니다.</td></tr>
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

	<table width="800">
	<tr><td style="line-height:20px;">	
	※ 머니충전 취소를 하시면, 입금하셔도 입금 확인이 되지 않습니다.<br>
	※ 입금한 정보와 머니충전신청 정보를 동일하게 맞추어 주시기 바랍니다.
	</td></tr>

	</table>
	<br><br>
</tr>
</table>

<script>
function goPage(index)
{
	location.href="moneyIn.aspx?mode=viewMoneyInRequestList&pageIndex=" + index;
}

function cancelMoneyInRequest(id)
{
	if (confirm("충전 신청을 취소 하시겠습니까?")) {
		var query = "mode=cancelMoneyInRequest";
		query += "&id=" + id;
		var http = new JKL.ParseXML("moneyIn.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}

function removeMoneyInRequestLog(id)
{
	if (confirm("충전  기록을 삭제 하시겠습니까?")) {
		var query = "mode=removeMoneyInRequestLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("moneyIn.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>

<%@include file="../footer.jsp"%>