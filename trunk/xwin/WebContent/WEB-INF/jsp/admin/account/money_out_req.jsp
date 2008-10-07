<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
		 
<SCRIPT LANGUAGE="JavaScript">
	function acceptMoneyOutRequest(id) {
		var d=document.regist;
		if(confirm('환전하시겠습니까?')) {			
			var query = "mode=acceptMoneyOutRequest";
			query += "&id=" + id;
			var http = new JKL.ParseXML("adminAccount.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();		
			} 
		}
	}
</SCRIPT>
	
<form method='post' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyOut'/>
	<select name='search'>
		<option value='userId' >회원아이디</option>
		<option value='name' >예금주명</option>
	</select>
	<input type='text' name='keyword' value=''>
	<select name='searchDate'>
		<option value='procDate'>환전일</option>
		<option value='regDate'>신청일</option>
	</select>
		<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
		~
		<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value=''>				
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
		<th>체크</th>
		<th>충전</th>
	</tr>
	<%
	if (moneyOutList != null) {
		for (MoneyOut moneyOut : moneyOutList) {
	%>
	<tr>
		<td>1</td>
		<td><a href='adminAccount.aspx?mode=viewMoneyOutDetail&id=<%=moneyOut.getId()%>'><B><%=moneyOut.getUserId()%></B></a></td>
		<td><a href='adminAccount.aspx?mode=viewMoneyOutDetail&id=<%=moneyOut.getId()%>'><%=moneyOut.getMoney()%></a></td>
		<td><%=moneyOut.getBankName()%></td>
		<td><%=moneyOut.getNumber()%></td>
		<td><%=moneyOut.getName()%></td>
		<td><%=moneyOut.getReqDateStr()%></td>
		<td><%=Code.getValue(moneyOut.getStatus())%></td>
		<td><input type='checkbox'></td>
		<td><input type='button' value='환전' onclick='acceptMoneyOutRequest(<%=moneyOut.getId()%>)'></td>
	</tr>
<%
	}
}
%>

</table>

<%@ include file="../admin_footer.jsp"%>
