<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">통장관리</div>

<form name="list">
<table class="list">
	<tr>
		<th width="5%"></th>
		<th width="10%">번호</th>
		<th width="20%">은행</th>
		<th width="45%">계좌번호</th>
		<th width="20%">예금주</th>
	</tr>
<%
	if (bankBookList != null) {
		for (BankBook bankBook : bankBookList) {
%>
	<tr>	
		<td><input type="checkbox" name="checkCheck" value="<%=bankBook.getId()%>"/></td>
		<td align='center'><%=bankBook.getId()%></td>
		<td align='center'><%=bankBook.getBankName()%></td>
		<td align='center'><%=bankBook.getNumber()%></td>
		<td align='center'><%=bankBook.getName()%></td>
	</tr>
<%		
		}
	}
%>					
</table>
</form>
<BR>
<input type='button' value='삭제' onclick="deleteBankBook()"/>
<BR>
<BR>
<div class="title">통장등록</div>
<form name="bankbook">
<table class="list">
<tr>
	<td width="20%">은행</td>
	<td width="*">
	<select name="bankName">
		<option value="">--선택--</option>
		<option value='국민' style=''>국민</option><option value='기업' style=''>기업</option><option value='농협' style=''>농협</option><option value='신한' style=''>신한</option><option value='조흥' style=''>조흥</option><option value='외환' style=''>외환</option><option value='우체국' style=''>우체국</option><option value='SC제일' style=''>SC제일</option><option value='하나' style=''>하나</option><option value='한국시티' style=''>한국시티</option><option value='한미' style=''>한미</option><option value='우리' style=''>우리</option><option value='경남' style=''>경남</option><option value='광주' style=''>광주</option><option value='대구' style=''>대구</option><option value='도이치' style=''>도이치</option><option value='부산' style=''>부산</option><option value='산업' style=''>산업</option><option value='수협' style=''>수협</option><option value='전북' style=''>전북</option><option value='제주' style=''>제주</option><option value='새마을' style=''>새마을</option><option value='신협' style=''>신협</option><option value='HSBC' style=''>HSBC</option><option value='상호저축' style=''>상호저축</option>
	</select>
	</td>
</tr>
<tr>
	<td>계좌번호</td>
	<td width="*">
	<input type="text" name="number" size="40"/>
	</td>
</tr>
<tr>
	<td>예금주</td>
	<td width="*">
	<input type="text" name="name" size="40"/>
	</td>
</tr>
</table>
</form>
<BR>
<input type='button' value='등록' onclick="saveBankBook()"/>
<script>
function saveBankBook()
{
	var frm = document.bankbook;
	if (!frm.bankName.value) {alert("은행을선택하세요"); return false;}
	if (!frm.number.value) {alert("계좌번호를 입력하세요"); return false;}
	if (!frm.name.value) {alert("예금주를 입력하세요"); return false;}

	var query = "mode=saveBankBook";
	query += "&bankName=" + frm.bankName.value;
	query += "&number=" + frm.number.value;
	query += "&name=" + frm.name.value;

	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}
function deleteBankBook()
{
	var query = "mode=deleteBankBook";

	var c = document.list.checkCheck;
	c = Xwin.ToArray(c);
	for (var i = 0 ; i < c.length ; i++) {
		if (c[i].checked) {
			query += "&id=" + c[i].value;
		}
	}
	
	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}
</script>

<%@ include file="../admin_footer.jsp"%>