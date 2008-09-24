<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="header.jsp"%>
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
	<tr><td width="100"><img src="images/title_inmoney.gif"></td><td>입금계좌를 통해 머니를 충전합니다.</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width="800" style="margin-top:10">
	<tr><td><b>머니 충전 방법</b></td></tr>
	</table>
	<table width="800" bgcolor="#333333" cellpadding="10" style="border:1 solid #909090;">
	<tr><td style="line-height:20px;">
		1. 입금하실 금액과 입금자명을 입력하고 [머니충전] 신청을 합니다.<br>

		2. 입금하실 계좌 번호를 꼭! 확인합니다. <br>
		3. 인터넷뱅킹, 폰뱅킹, 무통장입금, ATM이체 등의 방법으로 입금을 합니다.<br>
		4. 입금후 5분~10분 이내에 입금확인 처리가 됩니다.<br>
		※ 입력하신 정보(입금액/입금자명)와 실제입금금액/입금자명이 동일해야만 처리가 가능합니다.<br>
	</td></tr>
	</table>

	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_inmoney.gif"		onclick="location.href='inmoney.jsp'" style="cursor:hand;filter:gray();"></td>
			<td><img src="images/tab_inmoney_list.gif" onclick="location.href='inmoneylist.jsp'" style="cursor:hand;" hspace="3"></td>
		</tr></table>
	</td></tr>
	</table>

	

	<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="100" align="center">
	<col width="*">
	<col width="80" align="center">
	<col width="80" align="right">
	<col width="80" align="center">
	<col width="100" align="center">
	</colgroup>

	<tr bgcolor="#ce892c">
		<td style="color:white"><b>신청일자</td>
		<td style="color:white" align="center"><b>입금계좌</td>
		<td style="color:white"><b>입금자</td>
		<td style="color:white" align="center"><b>입금액</td>
		<td style="color:white"><b>상태</td>

		<td style="color:white"><b>처리일시</td>
	</tr>
<tr bgcolor='black'><td colspan='6' height='150' align='center'>최근 머니충전 신청내역이 없습니다.</td></tr>
	</table>

	<table width="800">
	<tr><td style="line-height:20px;">	
	※ 머니충전 취소를 하시면, 입금하셔도 입금 확인이 되지 않습니다.<br>
	※ 입금한 정보와 머니충전신청 정보를 동일하게 맞추어 주시기 바랍니다.
	</td></tr>

	</table>


	


	<br><br>


</td></tr>
</table>

<%@include file="footer.jsp"%>