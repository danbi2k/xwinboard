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
	function checkIT() {
		var d=document.regist;
		if(confirm('충전하시겠습니까?')) {			
			d.action='calc/index.php';
		}
		else {
			return false;
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?\n\n삭제하셔도 해당 유저의 충전금액이 삭제되지는 않습니다.')) {
			location='calc/index.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
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
	</tr>

	<%
	if (moneyInList != null) {
		for (MoneyIn moneyIn : moneyInList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td width=5%><%=moneyIn.getId()%></td>
		<td><a href='adminAccount.aspx?mode=viewMoneyInDetail&id=<%=moneyIn.getId()%>'><B><%=moneyIn.getUserId()%></B></a></td>
		<td><a href='adminAccount.aspx?mode=viewMoneyInDetail&id=<%=moneyIn.getId()%>'><%=moneyIn.getName()%></td>
		<td><%=moneyIn.getMoney()%></td>
		<td><%=moneyIn.getReqDateStr()%></td>
		<td><%=Code.getValue(moneyIn.getStatus())%></td>
	  </tr>
	<%
		}
	}
	%>
 </table>

<%@ include file="../admin_footer.jsp"%>
