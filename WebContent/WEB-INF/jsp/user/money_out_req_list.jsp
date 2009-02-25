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
			<div class='outcashlist'>

				<div class='tab'>
				<img src='img/sub_outcashlist_on_ti.gif' onclick="location.href='sendcache.php?mode=viewMoneyOutRequestList'" style="cursor:hand;">
				<img src='img/sub_outcash_off_ti.gif' onclick="location.href='sendcache.php?mode=viewMoneyOutRequest'" style="cursor:hand;">
				</div>
				<div class='box tabbox list_box'>
			
					<table>
					<tr>
						<th class='t1'>신청날짜</th>
						<th class='t2'>계좌번호</th>
						<th class='t3'>환전금액</th>
						<th class='t4'>상태</th>
						<th class='t5'>환전날짜</th>
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
			<!-- end outcash -->
		</div>
		<!-- sub_content1 -->

<script>
function goPage(index)
{
	location.href="sendcache.php?mode=viewMoneyOutRequestList&pageIndex=" + index;
}

function removeMoneyOutRequestLog(id)
{
	if (confirm("환전 기록을 삭제 하시겠습니까?")) {
		var query = "mode=removeMoneyOutRequestLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("sendcache.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>

<%@include file="../footer.jsp"%>