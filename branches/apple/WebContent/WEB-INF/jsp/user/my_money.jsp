<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<Account> accountList = (List<Account>) request.getAttribute("accountList");
	Integer totalCount = (Integer) request.getAttribute("accountCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

<div class='sub_ti1'>
		<img src='img/sub_mycash_ti.gif' alt='캐쉬내역' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 캐쉬 입환전 내역 입니다.</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='cashlist'>

				<div class='tab'>
				<a href="myMoney.aspx?mode=viewMyMoneyList"><img src='img/sub_cashlist_on_ti.gif'></a>
				<a href="myMoney.aspx?mode=viewMyPointList"><img src='img/sub_apple_off_ti.gif'></a>
				</div>
				<div class='box tabbox list_box'>
			
					<table>
					<tr>
						<th class='t1'>거래일자</th>
						<th class='t2'>기잔고</th>
						<th class='t3'>입환전</th>
						<th class='t4'>잔액</th>
						<th class='t5'>종류</th>
						<th class='t6'>비고</th>
						<th class='t7'>삭제</th>
					</tr>
	<%
	if (accountList != null && accountList.size() > 0) {
		for (Account account : accountList) {
	%>
	<tr>
	<td><%=account.getDateStr()%></td>
	<td><%=XwinUtil.comma3(account.getOldBalance())%></td>
	<td><%=XwinUtil.comma3(account.getMoney())%></td>
	<td><%=XwinUtil.comma3(account.getBalance())%></td>
	<td><%=Code.getValue(account.getType())%></td>
	<td><%=XwinUtil.nvl(account.getNote())%>
	<td><img src='img/sub_cashlist_del_bt.gif' alt='삭제' onclick="deleteMyMoneyLog(<%=account.getId()%>)"></td>
	</tr>
	<%
		}
	}
	%>
					</table><br>

				</div>
				

				

			</div>
			<!-- end cashlist -->
		</div>
		<!-- sub_content1 -->

<script>
function goPage(index)
{
	location.href="myMoney.aspx?mode=viewMyMoneyList&pageIndex=" + index;
}

function deleteMyMoneyLog(id)
{
	if (confirm("머니기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyMoneyLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("myMoney.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>
<%@include file="../footer.jsp"%>