<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	Member member = (Member) request.getAttribute("member");
%>
 
<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;

		var query = "mode=updateMember";
		query += "&userId=" + '<%=member.getUserId()%>';
		query += "&status=" + regist.status.value;
		query += "&grade=" + regist.grade.value;
		var http = new JKL.ParseXML("adminMember.aspx", query);
		var result = http.parse();

		if (result.resultXml.code == 0)
			alert(result.resultXml.message);
	}

	function delIT(userid) {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='member/index.php?mode=del_exe&userid='+userid+'&page=1&page_list=1&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}


	function chargeIT() {
		var d=document.charge;
		if(!d.amt.value) { alert('금액을 입력하세요'); d.amt.focus(); return false; }
		if(!d.msg.value) { alert('내역을 입력하세요'); d.msg.focus(); return false; }
		if(!confirm('금액을 충전/삭감 하시겠습니까?')) {
			return false;
		}
		else {
			d.action='member/index.php?mode=recharge&userid=ori7907&page=1&page_list=1&search=&kwd=&type=';
		}
	}
</SCRIPT>

<form method=post name='regist'>
<input type='hidden' name='mode' value='updateMember'/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원아이디</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getUserId()%></td>
	</tr>
   	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>닉네임</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getNickName()%></td>
	</tr>
    <tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>보유금액</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=XwinUtil.comma3(member.getBalance())%> 원
	</td>
	</tr>
    <tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>비밀번호</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getPassword()%></td>
 	</tr>
 	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>연락처</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getMobile()%></a></td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>EMAIL</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getEmail()%></a></td>
 	</tr>
	<!-- 
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원상태</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input type='radio' name='status' value='<%=Code.USER_STATUS_NORMAL%>' <%=member.getStatus().equals(Code.USER_STATUS_NORMAL)?"checked":""%>> 정상 
			<input type='radio' name='status' value='<%=Code.USER_STATUS_SECEDE%>' <%=member.getStatus().equals(Code.USER_STATUS_SECEDE)?"checked":""%>> 탈퇴
			<input type='radio' name='status' value='<%=Code.USER_STATUS_SECEDE_REQ%>' <%=member.getStatus().equals(Code.USER_STATUS_SECEDE_REQ)?"checked":""%>> 탈퇴요청
		</td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원종류</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input type='radio' name='grade' value='<%=Code.USER_GRADE_NORMAL%>' <%=member.getGrade().equals(Code.USER_GRADE_NORMAL)?"checked":""%>> 일반 
			<input type='radio' name='grade' value='<%=Code.USER_GRADE_VIP%>' <%=member.getGrade().equals(Code.USER_GRADE_VIP)?"checked":""%>> VIP
		</td>
	</tr>
	 -->
</table>
<BR>													
<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=100% bgcolor='#ffffff' align='center'>	
			<!-- img src='images/admin/but_modify.gif' border=0 onclick="checkIT()" -->
			<!-- img src='images/admin/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand" -->
		</td>
	</tr>
</table>

<%@ include file="../admin_footer.jsp"%>