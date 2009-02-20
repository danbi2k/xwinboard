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
<div class='sub_ti1'>
		<img src='./img/sub_incash_ti.gif' alt='캐쉬충전' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 입금계좌를 통해 캐쉬를 충전합니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='myBet.aspx?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='incashlist'>
				<h3>· 캐쉬충전 방법</h3>
				<div class='box'>
					1. 입금하실 금액과 입금자명을 입력하고 [캐쉬충전] 신청을 합니다.<br>
					2. 입금하실 계좌 번호를 꼭! 확인합니다. <br>
					3. 인터넷뱅킹, 폰뱅킹, 무통장입금, ATM이체 등의 방법으로 입금을 합니다.<br>
					4. 입금자명과 입금액이 동일시 입금후 2~3분이내 자동충전 처리 됩니다.<br>
					5. 신청하신후 1시간 이내에 입금되지 않은 신청은 자동취소 처리 됩니다.<br>
					<b>※ 입력하신 정보(입금액/입금자명)와 실제입금금액/입금자명이 동일해야만 처리가 가능합니다.</b>
				</div>


				<div class='tab'>
				<img src='./img/sub_incashlist_on_ti.gif' onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequestList'" style="cursor:hand;" >
				<img src='./img/sub_incash_off_ti.gif' class='img_bt' onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequest'" style="cursor:hand;">
				</div>
				<div class='box tabbox list_box'>
			
					<table>
					<tr>
						<th class='t1'>신청일자</th>
						<th class='t2'>입금계좌</th>
						<th class='t3'>입금자</th>
						<th class='t4'>입금액</th>
						<th class='t5'>상태</th>
						<th class='t6'>처리일시</th>
						<th class='t7'>취소</th>
						<th class='t8'>삭제</th>
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
				<img src='img/sub_incashlist_del_bt.gif' alt='삭제' onclick="removeMoneyInRequestLog(<%=moneyIn.getId()%>)" title="충전기록삭제">
				<%} %>
			</td>
		</tr>
	<%	
			}
		}
	%>
					</table><br>
※ 캐쉬충전 취소를 하시면, 입금하셔도 입금 확인이 되지 않습니다.<br>
※ 입금한 정보와 캐쉬충전신청 정보를 동일하게 맞추어 주시기 바랍니다.
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
			<!-- end introduce -->
		</div>
		<!-- sub_content1 -->

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