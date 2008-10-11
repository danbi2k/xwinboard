<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyInOutList");
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int ROWSIZE = 20;
	int SHOWPAGE = 10;
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
<div class="title">환전내역</div>
<form method='post' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyOutList'/>
	<input type='hidden' name='pageIndex'/>
	<input type='hidden' name='status' value='<%=status%>'/>
	<select name='search'>
		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
		<option value='name' <%=search.equals("name")?"selected":""%>>예금주명</option>
	</select>
	<input type='text' name='keyword' value='<%=keyword%>'>
	<!-- select name='searchDate'>
		<option value='procDate'>환전일</option>
		<option value='regDate'>신청일</option>
	</select>
		<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
		~
		<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value='' -->				
		<input type='submit' value='검 색'>  
</form>
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<td width=5%>번호</td>
		<th>아이디</td>
		<th>환전요청금액</td>
		<th>은행명</td>
		<th>계좌번호</td>
		<th>예금주</td>
		<th>신청일자</td>
		<th>상태</td>
	</tr>
	<%
	if (moneyOutList != null) {
		for (MoneyOut moneyOut : moneyOutList) {
	%>
	<tr>
		<td>1</td>
		<td><B><%=moneyOut.getUserId()%></B></td>
		<td><%=XwinUtil.comma3(moneyOut.getMoney())%></td>
		<td><%=moneyOut.getBankName()%></td>
		<td><%=moneyOut.getNumber()%></td>
		<td><%=moneyOut.getName()%></td>
		<td><%=moneyOut.getReqDateStr()%></td>
		<td><%=Code.getValue(moneyOut.getStatus())%></td>
	</tr>
<%
	}
}
%>

</table>

<div class="pages">
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
</div>
<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>
