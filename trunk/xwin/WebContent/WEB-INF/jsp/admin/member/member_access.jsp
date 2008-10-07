<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	List<Access> accessList = (List<Access>) request.getAttribute("accessList");
%>

<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;
		if(!d.passwd.value) { alert('비밀번호를 입력하세요'); d.passwd.focus(); return false; }
		d.action='/admin_mode/member/index.php?mode=modify_exe';
		d.submit();
	}

	function delIT(userid) {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/member/index.php?mode=del_exe&userid='+userid+'&page=&page_list=&search=&kwd=&type=';
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
			d.action='/admin_mode/member/index.php?mode=recharge&userid=&page=&page_list=&search=&kwd=&type=';
		}
	}


</SCRIPT>

<form method='post' name='search' action='adminMember.aspx'>
	<input type='hidden' name='mode' value=''/>
 </form>

<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th width=10%>아이디</th>
		<th width=15%>닉네임</th>
		<th width=*>접속시각</th>
		<th width=15%>아이피</th>
	</tr>
<%
if (accessList != null) {
	for (Access access : accessList) {
%>
	<tr>
		<td width=5%><%=access.getId()%></td>
		<td width=10%><%=access.getUserId()%></td>
		<td width=10%><%=access.getNickName()%></td>
		<td width=15%><%=XwinUtil.toDateStr(access.getDate(), 1)%></td>
		<td width=10%><%=access.getIpAddress()%></td>
	</tr>
<%
 }
}
%>							
</table>

<%@ include file="../admin_footer.jsp"%>