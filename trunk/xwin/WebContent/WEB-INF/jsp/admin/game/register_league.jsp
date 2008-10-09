<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;
		if(!d.name.value) { alert('리그명을 입력하세요'); d.name.focus(); return false; }
		
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/game/index.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

</SCRIPT>

<form name='regist' action="adminLeague.aspx" method='post' enctype="multipart/form-data">
<input type="hidden" name="mode" value="registerLeague"/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='text' name='name' size='80'>
		</td>
	</tr>												
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">파일업로드</td>
		<td bgcolor="#FFFFFF" width="85%" colspan=3>
			<input type='file' name='image'>
		</td>
	</tr>												
</table>
<BR>
</form>
<table width="2%"  border="0" cellspacing="5" cellpadding="0">
	<tr>
		<td><input type="image" src="images/admin/but_input.gif" border="0" onclick="checkIT()"></td>                               
		<td><img src="images/admin/but_cancel.gif" border="0" onClick="location.href='adminLeague.aspx?mode=viewLeagueList'" style="cursor:hand"></td>
	</tr>
</table>

<%@ include file="../admin_footer.jsp"%>
