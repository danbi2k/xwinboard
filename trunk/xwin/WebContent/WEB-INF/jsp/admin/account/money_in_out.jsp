<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<MoneyInOut> moneyInOutList = (List<MoneyInOut>) request.getAttribute("moneyInOutList");
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Long totalSum = (Long) request.getAttribute("totalSum");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
%>
		 
<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;
		if(confirm('환전하시겠습니까?')) {			
			d.action='/admin_mode/calc/exchange.php';
		}
		else {
			return false;
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?\n\n삭제하셔도 해당 유저의 환전금액이 삭제되지는 않습니다.')) {
			location='/admin_mode/calc/exchange.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

</SCRIPT>
<div class="title">충환전내역</div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>
<form method='get' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyInOutList'/>
	<input type='hidden' name='pageIndex'/>
	상태
	<select name='status' onchange='this.form.submit()'>
		<option value='002' <%=status.equals("002")?"selected":""%>>전체</option>
 		<option value='MC002' <%=status.equals("MC002")?"selected":""%>>충전</option>
 		<option value='ME002' <%=status.equals("ME002")?"selected":""%>>환전</option>
 	</select>
 	<select name='search'>
		<option value='name' <%=search.equals("name")?"selected":""%>>예금주</option>
 		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
 	</select>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	일자
	<input type='hidden' name='dateType' value='proc'/>
	<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
	<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">		
 	<input type='submit' value='검 색'/>
</form>

<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		

		<th>아이디 (닉네임)</th>
		<th>예금주</td>
		<th>요청금액</td>
		<th>은행명</td>
		<th>계좌번호</td>
		<th>신청일</td>
		<th>처리일</td>
		<th>상태</td>
	</tr>
	<%
	if (moneyInOutList != null) {
		for (MoneyInOut moneyInOut : moneyInOutList) {
			boolean plus = moneyInOut.getStatus().equals("MC002");
	%>
	<tr>		
		
		<td><a href='javascript:goMemberDetail("<%=moneyInOut.getUserId()%>")'><%=moneyInOut.getUserId()%></a> (<%=moneyInOut.getNickName()%>)</td>
		<td><%=moneyInOut.getName()%></td>
		<td><font color=<%=plus?"blue":"red"%>><%=XwinUtil.comma3(moneyInOut.getMoney())%></font></td>
		<td><%=moneyInOut.getBankName()%></td>
		<td><%=moneyInOut.getNumber()%></td>
		<td><%=moneyInOut.getReqDateStr()%></td>
		<td><%=moneyInOut.getProcDateStr()%></td>
		<td><%=Code.getValue(moneyInOut.getStatus())%></td>
	</tr>
<%
	}
}
%>

</table>
</form>
<BR>
<!-- input type="button" value="삭제" onclick="deleteCheckedItem()"/ -->
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
function deleteCheckedItem()
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=deleteMoneyOutList";
		var c = document.list.checkCheck;
		c = Xwin.ToArray(c);
		for (var i = 0 ; i < c.length ; i++) {
			if (c[i].checked) {
				query += "&id=" + c[i].value;
			}
		}
	
		var http = new JKL.ParseXML("adminAccount.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	} 
}

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>
