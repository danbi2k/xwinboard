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
		<div class='sub_ti_desc'></div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='betlog.php?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='cashlist'>

				<div class='tab'>
				<a href="account.php?mode=viewMyMoneyList"><img src='img/sub_cashlist_on_ti.gif'></a>
				<a href="account.php?mode=viewMyPointList"><img src='img/sub_apple_off_ti.gif'></a>
				</div>
				<div class='box tabbox list_box'>
			
					<table>
					<tr>
						<th class='t1'>거래일자</th>
						<th class='t2'>기존캐쉬</th>
						<th class='t3'>거래캐쉬</th>
						<th class='t4'>현존캐쉬</th>
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
				
<!-----[ 페이징 ]--------------------------------------------/-->
				<div class='paginate'>    
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<span class='pre'><a href='javascript:goPage(<%=startPage - 1%>)'><img src='img/list_prev_bt.gif' alt='이전'></a></span>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<span class='txt'><strong><%=i+1%></strong></span>
<%
		} else {
%>		
			<span class='txt'><a href='javascript:goPage(<%=i%>)'><%=i+1%></a></span>
<%			
		}
	}
	if (i < pageNum) {
%>		
		<span class='next'><a href='javascript:goPage(<%=i%>)''><img src='img/list_next_bt.gif' alt='다음' class='next'></a></span>
<%
	}
%>
				</div>		
				

			</div>
			<!-- end cashlist -->
		</div>
		<!-- sub_content1 -->

<script>
function goPage(index)
{
	location.href="account.php?mode=viewMyMoneyList&pageIndex=" + index;
}

function deleteMyMoneyLog(id)
{
	if (confirm("캐쉬내역을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyMoneyLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("account.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>
<%@include file="../footer.jsp"%>