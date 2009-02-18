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
<div class='sub_ti1'>
		<img src='img/sub_outcash_ti.gif' alt='환전요청' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 환전요청을 하시면 캐쉬를 실계좌로 입금해 드립니다.</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='outcashlist'>

				<div class='tab'>
				<img src='img/sub_outcashlist_on_ti.gif' onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequestList'" style="cursor:hand;">
				<img src='img/sub_outcash_off_ti.gif' onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequest'" style="cursor:hand;">
				</div>
				<div class='box tabbox list_box'>
			
					<table>
					<tr>
						<th class='t1'>신청일시</th>
						<th class='t2'>환전계좌</th>
						<th class='t3'>환전액</th>
						<th class='t4'>상태</th>
						<th class='t5'>처리일시</th>
						<th class='t6'>삭제</th>
					</tr>
					<%
		if (moneyOutList != null && moneyOutList.size() > 0) {
			for (MoneyOut moneyOut : moneyOutList) {
	%>
		<tr>
			<td><%=moneyOut.getReqDateStr()%></td>
			<td>[<%=moneyOut.getBankName()%>] <%=moneyOut.getNumber()%> <%=moneyOut.getName()%></td>
			<td><%=XwinUtil.comma3(moneyOut.getMoney())%></td>
			<td><%=Code.getValue(moneyOut.getStatus())%></td>
			<td><%=moneyOut.getProcDateStr()%></td>
			<td>
				<%if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST)) { %>
				<%} else {%>
				<img src='img/sub_incashlist_del_bt.gif' alt='삭제' onclick="removeMoneyOutRequestLog(<%=moneyOut.getId()%>)" title="환전기록삭제">
				<%} %>
			</td>
		</tr>
	<%	
			}
		}
	%>
					</table><br>

				</div>
				

				

			</div>
			<!-- end outcash -->
		</div>
		<!-- sub_content1 -->

<script>
function goPage(index)
{
	location.href="moneyOut.aspx?mode=viewMoneyOutRequestList&pageIndex=" + index;
}

function removeMoneyOutRequestLog(id)
{
	if (confirm("환전 기록을 삭제 하시겠습니까?")) {
		var query = "mode=removeMoneyOutRequestLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("moneyOut.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>

<%@include file="../footer.jsp"%>