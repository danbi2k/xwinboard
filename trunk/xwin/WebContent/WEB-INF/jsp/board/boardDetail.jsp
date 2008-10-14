<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="org.apache.commons.lang.*"%>

<%@include file="../header.jsp"%>

<%
	BoardItem boardItem = (BoardItem) request.getAttribute("boardItem");
	List<BoardComment> boardCommentList = boardItem.getBoardCommentList();
	String boardName = request.getParameter("boardName");
%>
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


<link rel='stylesheet' href='style/board.css'><script language='JavaScript' src='script/board.js'></script>

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

<table align="center" width="95%" cellpadding="0" cellspacing="0" style="margin-top:7px;">
<tr align="center">
<td width="10"><img src="images/title_left.gif"></td>
<td width="*" background="images/title_bg.gif"><b style="color:white"><%=boardItem.getTitle()%></td>
<td width="10"><img src="images/title_right.gif"></td>
</tr>
</table>

<table width="95%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #4a4a4a;">
<tr height="200" valign="top"><td style="padding:13px;" bgcolor="#4f4f4f" style="color:white;">

    <%
    String context = boardItem.getContext();
    context = StringEscapeUtils.escapeHtml(context);
    context = context.replaceAll("\n", "<br>");
    out.print(context);
    %>

</td></tr>
<tr><td bgcolor="#525252">
    <table width="100%" style="color:#8b8b8b;">
    <tr>
        <td width="33%"><b style="color:black">작성자 : <b><%=boardItem.getNickName()%></b></td>
        <td width="33%" align="center"><b style="color:black"><%=XwinUtil.getBoardItemDate(boardItem.getDate()) %></td>
        <td width="33%" align="right"><b style="color:black">Read : <%=boardItem.getReadCount() %></td>
    </tr></table>
</td></tr>
</table>



<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="padding-top:8px">
<tr><td width="50%" height="30">
		<!--
        <img src="images/btn_list.gif" onclick="list();" style="cursor:hand;">
        &nbsp;&nbsp;
        <img src="images/btn_prev.gif" onclick="pre_go();" style="cursor:hand;">
        <img src="images/btn_next.gif" onclick="next_go();" style="cursor:hand;">
          -->
    </td>
    <td width="50%" height="30" align="right">
		<%if (boardItem.getUserId().equals(member.getUserId())) {%>
		<a href="" onclick="deleteItem()"><img src="images/btn_del.gif" border="0"></a>
		<%} %>
        &nbsp;&nbsp;
        <a href="board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>"><img src="images/btn_write.gif" border="0"></a>
    </td></tr>
</table>


<script>
function deleteItem()
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=deleteBoardItem";
		query += "&id=<%=boardItem.getId()%>";
		query += "&boardName=<%=boardName%>";
		var http = new JKL.ParseXML("board.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.href = "board.aspx?mode=viewUserBoard&boardName=<%=boardName%>";
		}
	}
}

function deleteComment(id)
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=deleteBoardComment";
		query += "&id=" + id;
		var http = new JKL.ParseXML("board.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}
}

function list(){
    location.href="/board/board.asp?idx=board";
}
function pre_go(){
    
        location.href="/board/board.asp?idx=board&no=1568";
    
}
function next_go(){
    
        alert("다음 게시믈이 없습니다.");
    
}
function edit(no){
    if(confirm("수정하시겠습니까?")){
        location.href="/board/board.asp?idx=board&m=e&no="+ no;
    }
}
function del(no){
    location.href="/board/board.asp?idx=board&m=d&no="+ no;
}
</script>


<!--############################################################################################//-->

<script>
function comment_add(){
	
    if(comment_frm.name.value    ==""){ alert("이름을 입력하세요.");      comment_frm.name.focus(); return false; }
    if(comment_frm.comment.value ==""){ alert("댓글 내용을 입력하세요."); comment_frm.comment.focus(); return false; }
    comment_frm.action = "board.aspx";
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


<form name="comment_frm" method="post" onsubmit="comment_add();return false;">
<input type="hidden" name="mode" value="writeBoardComment">
<input type="hidden" name="boardId" value="<%=boardItem.getId()%>">
<input type="hidden" name="boardName" value="<%=boardName%>">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;border:1 solid #4a4a4a">
<tr bgcolor="#525252" height="30">
	<td width="120" bgcolor="#3a3a3a" align="center"><b style="color:white"><b>Comment</b></td>
	<td width="*" style="padding-left:15;">
	작성자 <input type="text" name="name" value="<%=member.getNickName()%>" style="width:90;height:19px;border:1 #efefef solid;background-color:#8a8a8a;" readonly>
	내용 <input type="text" name="comment" style="width:500;height:19px;border:1 #7f9db9 solid;"></td>
	<td width="100">&nbsp;<input type="image" src="images/btn_write.gif"  style="cursor:hand"></td>
</tr>
</table>
</form>

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr align="center">
    <td colspan="3" bgcolor="#f5f5f5" style="border:1 #c5c5c5 solid;">


        
        <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:2px;margin-top:12px;margin-bottom:12px;border-top:1 #c5c5c5 dotted">
        <%
        if (boardCommentList != null) {
        	for (BoardComment boardComment : boardCommentList) {
        %>
        <tr><td>
            <table width="100%" height="25" style="border-bottom:1 #c5c5c5 dotted">
            <tr><td width="90"  style="color:black"><b><%=boardComment.getNickName()%></b></td>
                <td width="*"   style="color:black"><%=StringEscapeUtils.escapeHtml(boardComment.getComment())%></td>
                <td width="70" title="2008-10-06 오후 5:47:04" align="center" style="color:black"><b><%=XwinUtil.getBoardItemDate(boardComment.getDate()) %></td>
				
					<td width="16" align="center">
					<%if (boardComment.getUserId().equals(member.getUserId())) {%>
					<img onclick="deleteComment(<%=boardComment.getId()%>)" src="images/btn_coment_del.gif"></td>
					<%}else { %>
					&nbsp;					
					<%} %>
					</td>
				
             </tr>
             </table>
        </td></tr>
        <%
        	}
        }
        %>
        </table>
        

    </td>
</tr>
</form>


<table id="comment_delbox" cellspacing="0" width="180" style="position:absolute;visibility:hidden;border:1 gray solid;">
<form name="comment_delfrm" action="?m=c" method="post">
<input type="hidden" name="idx"   value="board">
<input type="hidden" name="b_uid" value="1570">
<input type="hidden" name="c_del" value="">
<tr><td bgcolor="#efefef" align="center" onclick="cdbox.style.visibility='hidden';" style="filter:gray();cursor:hand;">
    <table cellspacing="0" cellpadding="0" width="100%" height="22">
    <tr><td width="*" align="center"><b>댓글 삭제</tD>
        <td width="20" align="right"><img src="images/btn_coment_del.gif"></td>
    </tr></table>
</td></tr>
<tr><td bgcolor="white" align="center">
    패스워드 : <input type="password" name="password" size="6" maxlength="10" style="height:19px;border:1 #7f9db9 solid;"><input name="btn_comment_ok" style="height:19px;border:1 #7f9db9 solid;" type="button" value="삭제" onclick="comment_submit();">
</td></tr>
</form>
</table>

<br><br>

</td></tr>
</table>

<%@include file="../footer.jsp"%>


</body>
</html>