<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.join.*"%>
<%@ page import="java.util.*"%>

<%@ include file="dealer_header.jsp"%>

<div class="title">총판정보</div>
<form name="regist">
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>총판아이디</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<%=dealer.getDealerId()%></a>
		</td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>현재비밀번호</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="password" type="text" value=""/>
		</td>
 	</tr>
    <tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>새비밀번호</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="password1" type="text" value=""/>
		</td>
 	</tr>
 	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>새비밀번호확인</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="password2" type="text" value=""/>
			<input type="button" value="변경" onclick="changePassword()"/>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>가입일</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=XwinUtil.toDateStr(dealer.getJoinDate(), 1)%></td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>상태</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=Code.getValue(dealer.getStatus())%></td>
 	</tr>
</table>
</form>
<script>
function changePassword()
{
	var frm = document.regist;
	
	if (frm.password != undefined) {
		if (!frm.password.value) {
			alert("현재비밀번호를 입력해 주십시오");
			return;
		}
	}
	
	if (frm.password1 != undefined) {
		if (!frm.password1.value) {
			alert("새비밀번호를 입력해 주십시오");
			return;
		}
	}
	
	if (frm.password2 != undefined) {
		if (!frm.password2.value) {
			alert("새비밀번호 확인을 입력해 주십시오");
			return;
		}
	}
	
	if (frm.password1.value != frm.password2.value) {
		alert("새비밀번호가 일치하지 않습니다");
		return;
	}
	
	if (frm.password1.value.length < 5) {
		alert("새 비밀번호를 5자 이상 입력하세요");
		return;
	}
	
	var query = "mode=changePassword";
	query += "&password=" + frm.password.value;
	query += "&password1=" + frm.password1.value;

	var http = new JKL.ParseXML("dealer.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}

</script>

<%@ include file="dealer_footer.jsp"%>