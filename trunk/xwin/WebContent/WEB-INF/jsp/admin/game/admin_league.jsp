<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>


<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
%>
 <%@ include file="../admin_header.jsp"%>

<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;
		if(!d.name.value) { alert('리그명을 입력하세요'); d.name.focus(); return false; }
		d.action='game/index.php?mode=modify_exe';
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='game/index.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}
</SCRIPT>

<h2 class="title">리그관리</h2>
<input type="button" value="등록하기" onclick="location.href='adminLeague.aspx?mode=viewRegisterLeagueForm'">
<br>
<br>

<form method='post' name='search' action='adminLeague.aspx'>
	<input type="hidden" name="mode" value="viewLeagueList"/>
	<select name='search'>
		<option value='name' selected>리그명</option>
	</select>
	<input type='text' name='keyword' value='<%=keyword%>'>
	<input type='submit' value='검 색'>
</form>
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th width=20%>번호</th>
		<th width=20%>이미지</th>
		<th width=80%>리그명</th>
	</tr>
	<%
	if (leagueList != null) {
		for (League league : leagueList) {
	%>
						 
	<tr align='center' bgcolor='#ffffff'>
		<td width=20%><%=league.getId()%></td>
		<td width=20%><img src='images/league/<%=league.getImage()%>' width='20' height='12' border=0></td>
		<td width=80%><a href='adminLeague.aspx?mode=viewUpdateLeagueForm&id=<%=league.getId()%>'><%=league.getName()%></a></td>
	</tr>
	<%
		}
	}
	%>
 </table>

<%@ include file="../admin_footer.jsp"%>
