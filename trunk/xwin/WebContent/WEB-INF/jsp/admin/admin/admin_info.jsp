<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../admin_header.jsp" %>
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

<div class="title">관리자정보</div>
<form method=post name='regist'>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>관리자아이디</td>
			<td width=80% bgcolor='#ffffff' align='left'><%=admin.getUserId()%></td>
		</tr>	
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>관리자명</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='name' value='<%=admin.getNickName()%>'></td>
		</tr>	
	     <tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>비밀번호</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='passwd' value='<%=admin.getPassword()%>'></td>
		</tr>		
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>전화번호</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type='text' size='40' name='phone' value='<%=admin.getMobile()%>'></td>
		</tr>					 
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=20%>EMAIL</td>
			<td width=80% bgcolor='#ffffff' align='left'><input type='text' size='40' name='email' value='<%=admin.getEmail()%>'></td>
		</tr>
	</table>
	<BR>													
	<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
		<tr align="center" bgcolor="#E4E4E4" height=20>
			<td width=100% bgcolor='#ffffff' align='center'>
				<img src='images/admin/but_modify.gif' border=0 onclick="checkIT()" style="cursor:hand">
				<img src='images/admin/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand">
			</td>
		</tr>
	</table>									
</form>

 <%@ include file="../admin_footer.jsp"%>