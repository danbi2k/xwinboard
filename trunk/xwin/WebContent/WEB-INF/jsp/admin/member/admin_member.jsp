<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 20;
	int SHOWPAGE = 10;
	
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	Integer totalCount = (Integer) request.getAttribute("memberCount");
	
	String grade = XwinUtil.nvl(request.getParameter("grade"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
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
	<input type='hidden' name='mode' value='viewAdminMember'/>
 	<select name='grade' onChange='this.form.submit()'>
 		<option value='' <%=grade.equals("")?"selected":""%>>전체</option>
		<option value='<%=Code.USER_GRADE_NORMAL%>' <%=grade.equals(Code.USER_GRADE_NORMAL)?"selected":""%>>일반</option>
		<option value='<%=Code.USER_GRADE_VIP%>' <%=grade.equals(Code.USER_GRADE_VIP)?"selected":""%>>VIP</option>
 	</select>
	<select name='search'>
		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>회원닉네임</option>
		<option value='mobile' <%=search.equals("mobile")?"selected":""%>>휴대전화</option>
		<option value='email' <%=search.equals("email")?"selected":""%>>EMAIL</option>
	</select>
	<input type='text' name='keyword' value='<%=keyword%>'>
	<input type='submit' value='검 색'>
 </form>

<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th width=10%>회원종류</th>
		<th width=10%>아이디</th>
		<th width=15%>닉네임</th>
		<th width=10%>보유금액</th>
		<th width=15%>휴대전화</th>
		<th width=20%>EMAIL</th>
		<th width=15%>가입일</th>
	</tr>
<%
if (memberList != null) {
	for (Member member : memberList) {
%>
	<tr>
		<td width=5%><%=member.getId()%></td>
		<td width=10%><%=Code.getValue(member.getGrade())%></td>
		<td width=10%><a href='adminMember.aspx?mode=viewMemberDetail&userId=<%=member.getUserId()%>'><%=member.getUserId()%></a></td>
		<td width=15%><%=member.getNickName()%></td>
		<td width=10%><%=XwinUtil.comma3(member.getBalance())%></td>
		<td width=15%><%=member.getMobile()%></td>
		<td width=20%><%=member.getEmail()%></td>
		<td width=15%><%=member.getJoinDateStr()%></td>
	</tr>
<%
 }
}
%>							
</table>

<div class="pages">
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil(totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + 15;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b> <%=i+1%> </b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
	}
%>
</div>

<%@ include file="../admin_footer.jsp"%>