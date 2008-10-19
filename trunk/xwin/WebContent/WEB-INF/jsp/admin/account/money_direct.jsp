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
	Integer totalSum = (Integer) request.getAttribute("totalSum");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int ROWSIZE = 25;
	int SHOWPAGE = 10;
%>

		  
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title"><%=status.equals(Code.MONEY_IN_DIRECT)?"직충전내역":"직차감내역"%></div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>
<form method='post' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='<%=status.equals(Code.MONEY_IN_DIRECT)?"viewMoneyInList":"viewMoneyOutList"%>'/>
	<input type='hidden' name='pageIndex'/>
	<input type='hidden' name='status' value='<%=status%>'/>
 	<select name='search'>
 		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
 	</selec>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	<!-- select name='searchDate'>
 		<option value='procDate' >날짜</option>
 	</select>
 	<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
 	~
 	<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value='' -->		
 	<input type='submit' value='검 색'>
</form>
<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th></th>
		<th width=5%>번호</th>
		<th>아이디 (닉네임)</th>
		<th>금액</th>
		<th>일자</th>
		<th>상태</th>
		<th>비고</th>
	</tr>

	<%
	if (moneyInOutList != null) {
		for (MoneyInOut moneyInOut : moneyInOutList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<th><input type="checkbox" name="checkCheck" value="<%=moneyInOut.getId()%>"/></th>
		<td width=5%><%=moneyInOut.getId()%></td>
		<td><B><%=moneyInOut.getUserId()%> (<%=moneyInOut.getNickName()%>)</B></td>
		<td><%=XwinUtil.comma3(moneyInOut.getMoney())%></td>
		<td><%=moneyInOut.getProcDateStr()%></td>
		<td><%=Code.getValue(moneyInOut.getStatus())%></td>
		<td><%=XwinUtil.nvl(moneyInOut.getNote())%>
	  </tr>
	<%
		}
	}
	%>
 </table>
</form>
<BR>
<!--input type="button" value="삭제" onclick="deleteCheckedItem()"/ -->
<BR>
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
function deleteCheckedItem()
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=<%=status.equals(Code.MONEY_IN_DIRECT)?"deleteMoneyInList":"deleteMoneyOutList"%>";
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
