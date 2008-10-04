<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	List<Account> accountList = (List<Account>) request.getAttribute("accountList");
%>
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_mymoney.gif"></td><td>머니 입출금 내역 입니다.</td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_money.gif"  onclick="location.href='?'" style="cursor:hand;"></td>
			
		</tr></table>

	</td></tr>
	</table>

	<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="140" align="center">
	<col width="100" align="right">
	<col width="100" align="right">
	<col width="100" align="right">

	<col width="*" align="left">
	</colgroup>

	<tr bgcolor="#ce892c">
		<th style="color:white" align="center">거래일자</th>
		<th style="color:white" align="center">기잔고</th>
		<th style="color:white" align="center">입출금</th>
		<th style="color:white" align="center">잔액</th>
		<th style="color:white" align="center">비고</th>
	</tr>
	<%
	if (accountList != null) {
		for (Account account : accountList) {
	%>
	<tr bgcolor='black'>
	<td><%=account.getDateStr()%></td>
	<td><%=account.getOldBalance()%></td>
	<td><%=account.getMoney()%></td>
	<td><%=account.getBalance()%></td>
	<td><%=Code.getValue(account.getType())%></td>
	</tr>
	<%
		}
	} else {
	%>
	<tr bgcolor='black'><td colspan='5' height='150' align='center' bgcolor='black'>머니 거래 내역이 없습니다.</td></tr>
	<%
	}
	%>
	</table>

<table width="850" height="30">
<tr><td align="center">

    <!-----[ 페이징 ]--------------------------------------------//-->
	
    <!-----[ 페이징 ]--------------------------------------------//-->

</td></tr>
</table>



</td></tr>
</table>


<%@include file="../footer.jsp"%>