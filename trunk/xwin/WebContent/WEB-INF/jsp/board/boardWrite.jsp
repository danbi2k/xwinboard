<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>

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
	<tr><td width="100"><img src="images/title_board.gif"></td><td>새로운 게시물을 작성합니다.</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


<link rel='stylesheet' href='/board/skin_board/board.css'><script language='JavaScript' src='/board/skin_board/board.js'></script>

<script>
function img_resize(obj,max_width){
    obj.style.display='';
    if(obj.width>max_width){
        var wid = obj.width;
        var hei =max_width * obj.height / wid;
        obj.width = max_width;
        obj.height = hei;
    }
}
</script>

<form name="boardWrite" action="board.aspx">
<input type="hidden" name="mode" value="writeBoardItem">
<table width="95%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #4a4a4a;">
<tr> 
  <td colspan="2" class="bg_green" height="1"></td>
</tr>
<tr> 
  <td class="bg_green2" align="center" height="28" width="150"><span class="text_green">제목</span></td>
  <td align="left"> 
    <input name="title" size="130" style="border: 1px solid rgb(135, 135, 135); background-color: rgb(37, 37, 37);" value="" validator="nn" type="text" >
  </td>
</tr>
<tr>

  <td colspan="2" class="bg_green" height="1"></td>
</tr>


<tr> 
  <td class="bg_green2" align="center" height="28"><span class="text_green">내용</span></td>
  <td align="left" height="28"> 
    <textarea name="context" cols="100" rows="20" style="border: 1px solid rgb(135, 135, 135); background-color: rgb(37, 37, 37);"></textarea>
  </td>
</tr>

<tr> 
  <td colspan="2" class="bg_green" height="1"></td>
</tr>							
 
  <tr> 
   <td colspan="2" class="bg_green" height="1"></td>
 </tr>
</table>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="padding-top:8px">
<tr><td width="50%" height="30"></td>

    <td width="50%" height="30" align="right">		
        &nbsp;&nbsp;
        <img src="images/btn_write.gif" border="0" onclick="submitBoardItem()">
    </td></tr>
</table>
</form>

<script>
function submitBoardItem()
{
	var frm = document.boardWrite;

	if (frm.title.value.length <= 0) {
		alert("제목을 입력 하세요");
		return;
	}
	if (frm.context.value.length <= 0) {
		alert("내용을 입력 하세요");
		return;
	} 

	frm.submit();
}

function list(){
    location.href="board/board.asp?idx=board";
}
function pre_go(){
    
        location.href="board/board.asp?idx=board&no=13";
    
}
function next_go(){
    
        location.href="board/board.asp?idx=board&no=15";
    
}
function edit(no){
    if(confirm("수정하시겠습니까?")){
        location.href="board/board.asp?idx=board&m=e&no="+ no;
    }
}
function del(no){
    location.href="board/board.asp?idx=board&m=d&no="+ no;
}
</script>


<!--############################################################################################//-->

<script>
function comment_add(){
	
    if(comment_frm.name.value    ==""){ alert("이름을 입력하세요.");      comment_frm.name.focus(); return false; }
    if(comment_frm.comment.value ==""){ alert("댓글 내용을 입력하세요."); comment_frm.comment.focus(); return false; }
    //if(comment_frm.password.value==""){ alert("패스워드를 입력하세요.");  comment_frm.password.focus(); return false; }
    comment_frm.action = "?m=c";
    comment_frm.method = "post";
    comment_frm.submit();

}
function comment_del(val){

    document.all.comment_delfrm.c_del.value = val;
	if(0){
		document.all.comment_delfrm.password.value = "";
	    document.all.comment_delfrm.password.disabled = false;
		cdbox = document.getElementById("comment_delbox");
		cdbox.style.left = event.clientX-180+document.body.scrollLeft;;
		cdbox.style.top  = event.clientY+document.body.scrollTop;
		cdbox.style.visibility='visible';
		document.all.comment_delfrm.password.focus();
	}else{
		if(confirm("삭제하시겠습니까?")){ document.all.comment_delfrm.submit(); }
	}
}
function comment_submit(){
    if(document.all.comment_delfrm.password.value==""){ alert("패스워드를 입력하세요!"); comment_delfrm.password.focus(); return false; }
    comment_delfrm.submit();
}
</script>

<br><br>

</td></tr>
</table>

<%@include file="../footer.jsp"%>


</body>
</html>