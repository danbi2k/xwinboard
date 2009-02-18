<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../admin_header.jsp" %>

<div class="title">보너스 설정</div>
<br>
<form method=post name='bonus'>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>승무패 보너스 사용</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="WDL_BONUS_USE" <%=Admin.WDL_BONUS_USE ? "checked":""%>></td>
		</tr>	
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>승무패 보너스 기준</td>
			<td width=80% bgcolor='#ffffff' align='left'>
				<input type="text" size="2" name="WDL_BONUS_LIMIT" value="<%=Admin.WDL_BONUS_LIMIT%>"> 폴더 이상
				<input type="text" size="2" name="WDL_BONUS_RATE" value="<%=Admin.WDL_BONUS_RATE%>"> % 지급
			</td>
		</tr>
	</table>
	<BR>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	     <tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>핸디캡 보너스 사용</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="HANDY_BONUS_USE" <%=Admin.HANDY_BONUS_USE ? "checked":""%>></td>
		</tr>	
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>핸디캡 보너스 기준</td>
			<td width=80% bgcolor='#ffffff' align='left'>
				<input type="text" size="2" name="HANDY_BONUS_LIMIT" value="<%=Admin.HANDY_BONUS_LIMIT%>"> 폴더 이상
				<input type="text" size="2" name="HANDY_BONUS_RATE" value="<%=Admin.HANDY_BONUS_RATE%>"> % 지급
			</td>
		</tr>	
	</table>
	<BR>													
	<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=100% bgcolor='#ffffff' align='center'>
				<input type="button" value="저장" onclick="changeBonus()"/>
			</td>
		</tr>
	</table>									
</form>

<script>
function changeBonus()
{
	var frm = document.bonus;
	
	var query = "mode=changeBonus";
	query += "&WDL_BONUS_USE=" + (frm.WDL_BONUS_USE.checked?"Y":"N");
	query += "&WDL_BONUS_LIMIT=" + frm.WDL_BONUS_LIMIT.value;
	query += "&WDL_BONUS_RATE=" + frm.WDL_BONUS_RATE.value;

	query += "&HANDY_BONUS_USE=" + (frm.HANDY_BONUS_USE.checked?"Y":"N");
	query += "&HANDY_BONUS_LIMIT=" + frm.HANDY_BONUS_LIMIT.value;
	query += "&HANDY_BONUS_RATE=" + frm.HANDY_BONUS_RATE.value;
	
	var http = new JKL.ParseXML("adminInfo.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}
</script>

 <%@ include file="../admin_footer.jsp"%>