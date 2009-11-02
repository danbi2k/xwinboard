<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<MoneyIn> moneyInList = (List<MoneyIn>)request.getAttribute("moneyInList");
	Integer totalCount = (Integer)request.getAttribute("moneyInCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
<tr>
	<td><img src="img/menu08.jpg" border="0"></td>
</tr>
<tr>
	<td align="center"><img src="img/moneynotice.jpg" border="0"></td>
</tr>

</table>
<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="33">
	<tr>
		<td width="771" height="37" align="left" valign="top"  background="../../../img/bar_bg.gif">
		<a href="earncache.php?mode=viewMoneyInRequest"><img
			src="img/8.jpg" border="0"></a>&nbsp;<img src="img/10-.jpg"
			border="0">	  </td>
	</tr>

</table>
<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="40"  background="img/bar1.gif">
	<tr>
		<td width="131" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">신청일자</p>	  </td>
		<td width="209" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">입금계좌</p>	  </td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">입금자</p>	  </td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">입금액</p>	  </td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">상태</p>	  </td>
		<td width="131" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">처리일시</p>	  </td>
		<td width="30" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">취소</p>	  </td>
		<td width="30" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">삭제</p>	  </td>
	</tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771" border="0">
	<%
		if (moneyInList != null && moneyInList.size() > 0) {
			for (MoneyIn moneyIn : moneyInList) {
				boolean isCancel = moneyIn.getStatus().equals(Code.MONEY_IN_CANCEL) ||
					moneyIn.getStatus().equals(Code.MONEY_IN_CANCEL_TIMEOUT); 
	%>
	<tr>
		<td width="131" class="tablebg1" align="center" valign="middle">
		<p><%=moneyIn.getReqDateStr()%></p>
		</td>
		<td width="209" class="tablebg2" align="center" valign="middle">
		<p>[<%=moneyIn.getBankBook().getBankName()%>] <%=moneyIn.getBankBook().getNumber()%></p>
		</td>
		<td width="80" class="tablebg1" align="center" valign="middle">
		<p><%=moneyIn.getName()%></p>
		</td>
		<td width="80" class="tablebg2" align="center" valign="middle">
		<p><%=isCancel?"<STRIKE>":""%><%=XwinUtil.comma3(moneyIn.getMoney())%><%=isCancel?"</STRIKE>":""%></p>
		</td>
		<td width="80" class="tablebg1" align="center" valign="middle">
		<p><%=Code.getValue(moneyIn.getStatus())%></p>
		</td>
		<td width="131" class="tablebg2" align="center" valign="middle">
		<p><%=moneyIn.getProcDateStr()%></p>
		</td>
		<td width="30" class="tablebg1" align="center" valign="middle">
		<p>
		<%if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) { %>
			<img src="img/x.gif" onclick="cancelMoneyInRequest(<%=moneyIn.getId()%>)" title="충전신청취소">
		<%}%>
		</p>
		</td>
		<td width="30" class="tablebg2" align="center" valign="middle">
		<p>
		<%if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST) == false) { %>
			<img src="img/x.gif" onclick="removeMoneyInRequestLog(<%=moneyIn.getId()%>)" title="충전기록삭제">
		<%} %>
		</p>
		</td>
	</tr>
	<%	
			}
		}
	%>
</table>
<br>
<br>
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'><img src="img/prev.jpg" border="0" align="absmiddle"></a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'><img src="img/next.jpg" border="0" align="absmiddle"></a>
<%
	}
%>

<script>
	function goPage(index) {
		location.href = "earncache.php?mode=viewMoneyInRequestList&pageIndex="
				+ index;
	}

	function cancelMoneyInRequest(id) {
		if (confirm("충전 신청을 취소 하시겠습니까?")) {
			var query = "mode=cancelMoneyInRequest";
			query += "&id=" + id;
			var http = new JKL.ParseXML("earncache.php", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0)
				location.reload(0);
		}
	}

	function removeMoneyInRequestLog(id) {
		if (confirm("충전  기록을 삭제 하시겠습니까?")) {
			var query = "mode=removeMoneyInRequestLog";
			query += "&id=" + id;
			var http = new JKL.ParseXML("earncache.php", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0)
				location.reload(0);
		}
	}
</script>

<%@include file="../footer.jsp"%>