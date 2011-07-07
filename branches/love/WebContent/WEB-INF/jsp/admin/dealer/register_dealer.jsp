<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<script>
function checkValue()
{
	var d=document.regist;
	if(!d.dealerId.value)
	{
		alert('총판 아이디를 입력하세요');
		d.name.focus(); return false;
	}
	if (!d.password.value)
	{
		alert('비밀번호를 입력하세요');
		d.password.focus(); return false;
	}
	
	var query = "mode=checkExistDealerId";
	query += "&dealerId=" + d.dealerId.value;
	
	var http = new JKL.ParseXML("adminDealer.aspx", query);
	var result = http.parse();
	if (result.resultXml.code < 0)
	{
		alert(result.resultXml.message);
		return false;
	}
	
	d.submit();
}
</script>

<div class="title">총판등록</div>

<form name='regist' action="adminDealer.aspx" method='post'>
<input type="hidden" name="mode" value="registerDealer"/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">총판아이디</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='text' name='dealerId' size='80'>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">비밀번호</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='text' name='password' size='80'>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">은행명</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='text' name='bankName' size='80'>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">계좌번호</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='text' name='bankNumber' size='80'>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">예금주</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='text' name='bankOwner' size='80'>
		</td>
	</tr>												
</table>
<BR>
</form>
<table width="2%"  border="0" cellspacing="5" cellpadding="0">
	<tr>
		<td><input type="image" src="images/admin/but_input.gif" border="0" onclick="checkValue()"></td>                               
		<td><img src="images/admin/but_cancel.gif" border="0" onClick="location.href='adminDealer.aspx?mode=viewAdminDealer'" style="cursor:hand"></td>
	</tr>
</table>

<%@ include file="../admin_footer.jsp"%>
