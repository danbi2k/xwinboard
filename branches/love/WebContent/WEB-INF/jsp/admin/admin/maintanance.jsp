<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../admin_header.jsp" %>

<div class="title">DB 관리</div>
<br>
<form method=post name='db'>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=25%>충환전내역 삭제</td>
			<td width=75% bgcolor='#ffffff' align='left'>
				<input type='text' name='toDateInOut' size=10 readonly onClick="popUpCalendar(this,toDateInOut,'yyyy-mm-dd');" style="cursor:hand"> 전 까지
				<input type="button" value="삭제" onclick="deleteData('deleteMoneyInOutData', document.db.toDateInOut)"/>
			</td>
		</tr>
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=25%>거래내역 삭제</td>
			<td width=75% bgcolor='#ffffff' align='left'>
				<input type='text' name='toDateAccount' size=10 readonly onClick="popUpCalendar(this,toDateAccount,'yyyy-mm-dd');" style="cursor:hand"> 전 까지
				<input type="button" value="삭제" onclick="deleteData('deleteAccountData', document.db.toDateAccount)"/>
			</td>
		</tr>
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=25%>배팅내역 삭제</td>
			<td width=75% bgcolor='#ffffff' align='left'>
				<input type='text' name='toDateBetting' size=10 readonly onClick="popUpCalendar(this,toDateBetting,'yyyy-mm-dd');" style="cursor:hand"> 전 까지
				<input type="button" value="삭제" onclick="deleteData('deleteBettingData', document.db.toDateBetting)"/>
			</td>
		</tr>
	</table>			
</form>

<script>
function deleteData(mode, iobj)
{	
	if (!iobj.value) { alert("masukan tanggal standar untuk di hapus"); return; }
	
	var query = "mode=" + mode;
	query += "&date=" + iobj.value;
	
	var http = new JKL.ParseXML("admin.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}
</script>

 <%@ include file="../admin_footer.jsp"%>