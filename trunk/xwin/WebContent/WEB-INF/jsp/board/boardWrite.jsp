<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%
	String boardName = request.getParameter("boardName");
%>

<%@include file="../header.jsp"%>

<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_board.gif"></td><td>게시물을 작성하고, 중요 내용을 확인 할 수 있습니다.</td></td>
	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


<link rel='stylesheet' href='/board/skin_board/board.css'><script language='JavaScript' src='/board/skin_board/board.js'></script>
<script>
function list(){
    location.href="/board/board.asp?idx=board";
}
function check_frm(){
    if(frm.title.value   ==""){ alert("제목을 입력하세요!");   frm.title.focus();    return false; }
    if(frm.name.value    ==""){ alert("작성자를 입력하세요!"); frm.name.focus();     return false; }
    if(frm.contents.value==""){ alert("내용을 입력하세요!");   frm.contents.focus(); return false; }
    return true;
}
</script>


<table width="95%" border="0" align="center" bgcolor="#d9d8d6" cellpadding="3" cellspacing="1" style="margin-top:7px;">
<colgroup>
<col height="31" width="10%" align="center">
<col height="31" width="90%" align="center">
</colgroup>
<form name="frm" action="board.aspx" method="post" onsubmit="return check_frm();">
<input type="hidden" name="mode" value="writeBoardItem">
<input type="hidden" name="boardName" value="<%=boardName%>">

<tr bgcolor="#0a0a0a">
	<td bgcolor="#525252" style="color:white;"><b>작성자</td>
    <td align="left"><input type="text" name="name" readonly style="background-color:#0a0a0a;border:0;color:white" value="<%=member.getNickName()%>" style="width:100;"></td>
<tr bgcolor="#0a0a0a">
	<td bgcolor="#525252" style="color:white;"><b>제&nbsp;목</td>
    <td align="left"><input type="text" name="title" class="board" value="" style="width:80%;">
	</td></tr>
<tr bgcolor="#0a0a0a">
	<td bgcolor="#525252" style="color:white;"><b>내&nbsp;용</td>
	<td align="left"><textarea name="context" class="board" style="width:100%;height:300;"></textarea></td></tr>
</table>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="margin-top:5;">
<tr><td width="50%" height="30"><div align="left">
        <a href="javascript:history.back()"><img src="images/btn_list.gif" border="0"></a>
    </td>
    <td width="50%" height="30"  align="right">
		<input type="image" src="images/btn_write.gif" style="cursor:hand">
    </td></tr>
</form>
</table>


</td></tr>
</table>

<%@include file="../footer.jsp"%>


</body>
</html>