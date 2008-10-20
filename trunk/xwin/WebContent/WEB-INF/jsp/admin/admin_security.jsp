<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="admin_header.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
		function checkIT() {
		var d=document.regist;
		if(!d.passwd.value) { alert('비밀번호를 입력하세요'); d.passwd.focus(); return false; }

		var query = "mode=updateAdminInfo";
		query += "&nickName=" + d.name.value;
		query += "&password=" + d.passwd.value;
		query += "&mobile=" + d.phone.value;
		query += "&email=" + d.email.value;

		var http = new JKL.ParseXML("adminInfo.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
		}
		else {
		}
	}
//-->
</SCRIPT>

<div class="title">보안정보</div>
<h3>※ 체크하신 항목이 사용 금지 됩니다.</h3>
<br>
<form method=post name='security'>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>회원가입금지</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="DENY_JOIN" <%=Admin.DENY_JOIN.equals("Y") == false ? "checked":""%>></td>
		</tr>	
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>게시판쓰기금지</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="DENY_BOARD" <%=Admin.DENY_BOARD.equals("Y") == false ? "checked":""%>></td>
		</tr>	
	     <tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>고객센터쓰기금지</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="DENY_QNA" <%=Admin.DENY_QNA.equals("Y") == false ? "checked":""%>></td>
		</tr>		
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>충전요청금지</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="DENY_CHARGE" <%=Admin.DENY_CHARGE.equals("Y") == false ? "checked":""%>></td>
		</tr>					 
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>환전요청금지</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type="checkbox" name="DENY_EXCHANGE" <%=Admin.DENY_EXCHANGE.equals("Y") == false ? "checked":""%>></td>
		</tr>
	</table>
	<BR>													
	<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=100% bgcolor='#ffffff' align='center'>
				<input type="button" value="저장" onclick="changeSecurity()"/>
			</td>
		</tr>
	</table>									
</form>

<script>
function changeSecurity()
{
	var frm = document.security;
	
	var query = "mode=changeSecurity";
	query += "&DENY_JOIN=" + (frm.DENY_JOIN.checked?"N":"Y");
	query += "&DENY_BOARD=" + (frm.DENY_BOARD.checked?"N":"Y");
	query += "&DENY_QNA=" + (frm.DENY_QNA.checked?"N":"Y");
	query += "&DENY_CHARGE=" + (frm.DENY_CHARGE.checked?"N":"Y");
	query += "&DENY_EXCHANGE=" + (frm.DENY_EXCHANGE.checked?"N":"Y");
	var http = new JKL.ParseXML("adminInfo.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}
</script>

 <%@ include file="admin_footer.jsp"%>