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

<form name="frm">
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">

	<table width="900" style="border-bottom:1 solid #909090;">

	<tr><td width="100"><img src="images/title_mybet.gif"></td><td>배팅 내역 및 결과입니다.</td></td>
	<td align="right">
		<table cellpadding="0" cellspacing="0">
		<tr><td>상태 : <select name="Status" style="color:white;background-color:black;" onchange="frm.submit();"><option value="">--전체--</option><option value='0' style='color:#b0b0b0;'>진행중</option><option value='1' style='color:orange;'>적중</option><option value='2' style='color:#505050;'>실패</option><option value='8' style='color:#a47842;'>취소(환불)</option><option value='9' style=''>경기취소</option></select></td>
			<td><img src="images/btn_reload.gif" onclick="location.href=location.href;" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>

		</tr></table>
	</td>
	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width="900" bgcolor="#d9d8d6" cellspacing="1" cellpadding="3">
	<colgroup>
		<col align="center" width="50">
		<col align="center" width="100">

		<col align="center"  width="*">
		<col align="right"  width="80">
		<col align="center" width="70">
		<col align="right"  width="80">
		<col align="center" width="70">
		<col align="center" width="70">
	</colgroup>

	<tr bgcolor="#ce892c">

		<td style="color:white;"><b>No</td>
		<td style="color:white;"><b>배팅일시</td>
		<td style="color:white;"><b>진행상태</td>
		<td style="color:white;" align="center" ><b>배팅금액</td>
		<td style="color:white;"><b>배당율</td>
		<td style="color:white;" align="center" ><b>배당금</td>

		<td style="color:white;"><b>상태</td>
		<td style="color:white;"><b>자세히</td>
	</tr>

<tr bgcolor="#0a0a0a"><td colspan="10" height="50" align="center">배팅 내역이 없습니다.</td></tr>
	</table>

<table width="850" height="30">
<tr><td align="center">

    <!-----[ 페이징 ]--------------------------------------------//-->
	
    <!-----[ 페이징 ]--------------------------------------------//-->
</td></tr>
</table>

</td></tr>
</table>
</form>


<%@include file="footer.jsp"%>