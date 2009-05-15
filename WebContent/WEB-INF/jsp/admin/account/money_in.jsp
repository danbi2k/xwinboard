<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInOutList");
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Long totalSum = (Long) request.getAttribute("totalSum");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
%>

<div class="title">충전내역</div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>
<form method='post' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyInList'/>
	<input type='hidden' name='pageIndex'/>
	<input type='hidden' name='status' value='<%=status%>'/>
 	<select name='search'>
		<option value='name' <%=search.equals("name")?"selected":""%>>예금주</option>
 		<option value='userId' <%=search.equals("userId")?"selected":""%>>anggota idenditas</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
 	</selec>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	<!-- select name='searchDate'>
 		<option value='procDate' >충전일</option>
 		<option value='reqDate' >신청일</option>
 	</select>
 	<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
 	~
 	<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value='' -->		
 	<input type='submit' value='검 색'>
</form>
<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		
		<th width=5%>번호</th>
		<th>아이디(닉네임)</th>
		<th>예금주</th>
		<th>충전요청금액</th>
		<th>신청일자</th>
		<th>상태</th>
	</tr>

	<%
	if (moneyInList != null) {
		for (MoneyIn moneyIn : moneyInList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		
		<td width=5%><%=moneyIn.getId()%></td>
		<td><B><%=moneyIn.getUserId()%></B></td>
		<td><%=moneyIn.getName()%></td>
		<td><%=XwinUtil.comma3(moneyIn.getMoney())%></td>
		<td><%=moneyIn.getReqDateStr()%></td>
		<td><%=Code.getValue(moneyIn.getStatus())%></td>
	  </tr>
	<%
		}
	}
	%>
 </table>
</form>
<BR>
<!--input type="button" value="삭제" onclick="deleteCheckedItem()"/  -->
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
	if (confirm("ingin di hapus?")) {
		var query = "mode=deleteMoneyInList";
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
