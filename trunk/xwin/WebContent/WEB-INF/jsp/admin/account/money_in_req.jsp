<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>

		  
<SCRIPT LANGUAGE="JavaScript">
	function acceptMoneyInRequest(id) {
		if(confirm('충전하시겠습니까?')) {
			var query = "mode=acceptMoneyInRequest";
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
	<input type='hidden' name='mode' value='viewMoneyIn'/>
 	<select name='search'>
 		<option value='userId' >회원아이디</option>
 		<option value='name' >입금자명</option>
 	</selec>
 	<input type='text' name='kwd' value=''>
	<select name='searchDate'>
 		<option value='procDate' >충전일</option>
 		<option value='reqDate' >신청일</option>
 	</select>
 	<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
 	~
 	<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value=''>		
 	<input type='submit' value='검 색'>
</form>
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th width=5%>번호</th>
		<th>아이디(닉네임)</th>
		<th>입금자</th>
		<th>충전요청금액</th>
		<th>신청일자</th>
		<th>상태</th>
		<th>체크</th>
		<th>충전</th>
	</tr>

	<%
	if (moneyInList != null) {
		for (MoneyIn moneyIn : moneyInList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td width=5%><%=moneyIn.getId()%></td>
		<td><%=moneyIn.getUserId()%></td>
		<td><%=moneyIn.getName()%></td>
		<td><%=XwinUtil.comma3(moneyIn.getMoney())%></td>
		<td><%=moneyIn.getReqDateStr()%></td>
		<td><%=Code.getValue(moneyIn.getStatus())%></td>
		<td><input type='checkbox'></td>
		<td><input type='button' value='충전' onclick='acceptMoneyInRequest(<%=moneyIn.getId()%>)'></td>
	  </tr>
	<%
		}
	}
	%>
 </table>

<%@ include file="../admin_footer.jsp"%>
