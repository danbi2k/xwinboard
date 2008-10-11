<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>


<%
	int ROWSIZE = 20;
	int SHOWPAGE = 10;
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Integer totalCount = (Integer) request.getAttribute("leagueCount");
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
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

<div class="title">리그관리</div>
<input type="button" value="등록하기" onclick="location.href='adminLeague.aspx?mode=viewRegisterLeagueForm'">
<br>
<br>

<form method='post' name='search' action='adminLeague.aspx'>
	<input type="hidden" name="mode" value="viewLeagueList"/>
	<input type="hidden" name="pageIndex"/>
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
		<td width=20%><img src='images/league/<%=league.getImage()%>' width='22' height='14' border=0></td>
		<td width=70%><%=league.getName()%></td>
		<td width=10%><input type="button" onclick="delIT(<%=league.getId()%>)" value="삭제"></td>
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
	int pageNum = (int) totalCount / ROWSIZE + 1;
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
