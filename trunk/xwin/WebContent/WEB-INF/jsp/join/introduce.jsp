<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../header.jsp"%>

<form name="intro">
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_betguide.gif"></td><td>배팅하는 방법을 소개합니다.</td>

	</table>
</td></tr>
<tr><td valign="top" align="center">
	<input type="text" name="mobile"/>
	<input type="button" value="초대하기" onclick="introduce()"/>	
</td></tr>
</table>
</form>

<script>
function introduce()
{
	var frm = document.intro;
	if (frm.mobile.value == "") {
		alert("전화번호를 입력하세요");
		return;
	}
	
	var query = "mode=introduce";
	query += "&mobile=" + frm.mobile.value;
	var http = new JKL.ParseXML("introduce.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}
</script>

<%@include file="../footer.jsp"%>