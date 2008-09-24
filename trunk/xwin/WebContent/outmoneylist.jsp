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

<table width="960"  style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_outmoney.gif"></td><td>출금요청을 하시면 머니를 실계좌로 입금해 드립니다.</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_outmoney.gif"		 onclick="location.href='outmoney.jsp'" style="cursor:hand;filter:gray();"></td>
			<td><img src="images/tab_outmoney_list.gif" onclick="location.href='outmoneylist.jsp'" style="cursor:hand;" hspace="3"></td>
		</tr></table>

	</td></tr>
	</table>




	<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="100" align="center">
	<col width="*">
	<col width="80" align="right">

	<col width="80" align="center">
	<col width="100" align="center">
	</colgroup>

	<tr bgcolor="#ce892c">
		<td style="color:white"><b>신청일시</td>
		<td style="color:white" align="center"><b>출금계좌</td>
		<td style="color:white" align="center"><b>출금액</td>

		<td style="color:white"><b>상태</td>
		<td style="color:white"><b>처리일시</td>
	</tr>
<tr bgcolor='black'><td colspan='6' height='150' align='center'>최근 출금 신청내역이 없습니다.</td></tr>
	</table>





</td></tr>
</table>


<%@include file="footer.jsp"%>