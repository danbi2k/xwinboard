<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@include file="admin_header.jsp"%>

<form name='createLeague'>
<table>
<tr>
	<td>리그명</td>
	<td><input name='name' type='text'/></td>
</tr>
<tr>
	<td>이미지</td>
	<td><input name='file' type='file'/></td>
</tr>
</table>
</form> 

 <div id="leagueListDiv"></div>
  
 <script>
 AdminGame.GetLeagueList();
 </script>
 <%@include file="admin_footer.jsp"%>