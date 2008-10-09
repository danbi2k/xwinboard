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

	function delIT(id) {
		if(confirm('리그를 삭제하시겠습니까?')) {
			var query = "mode=removeLeague";
			query += "&id=" + id;
			var http = new JKL.ParseXML("adminLeague.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);

			location.href = "adminLeague.aspx?mode=viewLeagueList";
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
		<th width=70%>리그명</th>
		<th width=10%>삭제</th>
	</tr>
	<%
	if (leagueList != null) {
		for (League league : leagueList) {
	%>
						 
	<tr align='center' bgcolor='#ffffff'>
		<td width=20%><%=league.getId()%></td>
		<td width=20%><img src='images/league/<%=league.getImage()%>' width='20' height='12' border=0></td>
		<td width=70%><%=league.getName()%></td>
		<td width=10%><input type="button" onclick="delIT(<%=league.getId()%>)" value="삭제"></td>
	</tr>
	<%
		}
	}
	%>
 </table>

<%@ include file="../admin_footer.jsp"%>
