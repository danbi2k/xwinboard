<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 50;
	int SHOWPAGE = 20;
	
	Collection<HttpSession> sessionCol = Admin.loginMap.values();
	Integer totalCount = sessionCol.size();
	HttpSession[] sessionArray = new HttpSession[totalCount];
	sessionCol.toArray(sessionArray);
	
	String grade = XwinUtil.nvl(request.getParameter("grade"));
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	
	int memberIdx = totalCount - (pIdx * ROWSIZE);
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">로그인현황</div>
<form method='GET' name='search' action='adminStat.aspx'>
	<input type='hidden' name='mode' value='viewMemberLogin'/>
	<input type='hidden' name='pageIndex'/>
	<select name='grade' onChange='this.form.submit()'>
		<option value=''>전체</option>
		<option value='<%=Code.USER_GRADE_NORMAL%>' <%=grade.equals(Code.USER_GRADE_NORMAL)?"selected":""%>>일반</option>
		<option value='<%=Code.USER_GRADE_VIP%>' <%=grade.equals(Code.USER_GRADE_VIP)?"selected":""%>>VIP</option>
 	</select>
 </form>
<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th width=15%>회원종류</th>
		<th width=15%>아이디</th>
		<th width=15%>닉네임</th>
		<th width=10%>로그인시각</th>
		<th width=10%>마지막배팅시각</th>
	</tr>
<%
if (sessionArray != null) {
	for (int i = pIdx * ROWSIZE, j = 0 ; i < totalCount && j < ROWSIZE ; i++) {
		HttpSession loginSession = sessionArray[i];
		Member member = (Member) loginSession.getAttribute("Member");
		if (grade.length() > 0 && member.getGrade().equals(grade) == false) {
			continue;
		}
		
		j++;
		
		String betMinStr = "";
		if (member.getBettingDate() != null) {
			Date now = new Date();
			Long diff = now.getTime() - member.getBettingDate().getTime();
			long betMin = diff / 1000 / 60;
			betMinStr = "" + betMin + " 분  전";
		}		
%>
	<tr>
		<td width=5%><%=memberIdx--%></td>
		<td width=10%><%=Code.getValue(member.getGrade())%></td>
		<td width=20%><a href='javascript:goMemberDetail("<%=member.getUserId()%>")'><%=member.getUserId()%></a></td>
		<td width=15%><%=member.getNickName()%></td>
		<td width=10%><%=XwinUtil.toDateStr(member.getLoginDate(), 1)%></td>
		<td width=10%><%=betMinStr%></td>
	</tr>
<%
 }
}
%>							
</table>

<div class="pages">
<%
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
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
<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>