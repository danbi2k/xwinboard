<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;
		if(!d.name.value) { alert('masukan nama liga'); d.name.focus(); return false; }
		alert("sedang persiapkan upload gambar");
		d.submit();
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
			<input type='file' name='image' size='40'>
		</td>
	</tr>												
</table>
<BR>

<table width="2%"  border="0" cellspacing="5" cellpadding="0">
	<tr>
		<td><input type="image" src="images/admin/but_input.gif" border="0""></td>                               
		<td><img src="images/admin/but_cancel.gif" border="0" onClick="history.back()" style="cursor:hand"></td>
	</tr>
</table>

<%@ include file="../admin_footer.jsp"%>
