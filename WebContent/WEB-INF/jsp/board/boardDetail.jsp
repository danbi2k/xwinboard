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
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	if (pageIndex == null)
		pageIndex = "0";
%>

<tr><td><img src="img/menu04.jpg" border="0"></td></tr>
		    <tr><td><img src="img/bbs01.jpg" border="0"></td></tr>
            </table>
     
     <table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar-.jpg">
    <tr>
        <td width="771" height="40" align="center" valign="middle" class="menubar">
           <%=boardItem.getTitle()%>
        </td>
        
    </tr>
</table>
 <table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
   
    <tr>
        <td width="771" height="37" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="497" height="132" background="img/minit_02.jpg" valign="top" style="padding:20">
            <p>
			 <%
			    String context = boardItem.getContext();
			    context = StringEscapeUtils.escapeHtml(context);
			    context = context.replaceAll("\n", "<br>");
			    out.print(context);
		     %>
			</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
          <table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="671" height="40" align="left">
					<a href='board.aspx?mode=viewBoard&boardName=<%=boardName%>&pageIndex=<%=pageIndex%>'><img src="img/list.jpg" border="0" align="absmiddle"></a>
			    </td>
			    <td width="100" height="40" align="right">
					<a href='board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>'><img src="img/write.jpg" border="0" align="absmiddle"></a>
				</td>
				<%if (boardItem.getUserId().equals(member.getUserId())) {%>
				<td width="100" height="40" align="right">
					<img src="img/delete.jpg" border="0" align="absmiddle" onclick="deleteItem()">
				</td>
				<%} %>
			</tr>
		    
     </table>

<table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar-.jpg">
    <tr>
        <td width="771" height="40" align="center" valign="middle" class="menubar">
           코멘트
        </td>
        
    </tr>
</table>
 <table align="center" cellpadding="0" cellspacing="0" width="771" height="20">
<%
if (boardCommentList != null) {
	for (BoardComment boardComment : boardCommentList) {
%>
    <tr>
		<td width="50" background="img/minit_02.jpg" valign="top" style="padding:10;">
            <p><%=boardComment.getNickName()%></p>
        </td>
        <td width="332" background="img/minit_02.jpg" valign="top" style="padding:10">
            <p><%=StringEscapeUtils.escapeHtml(boardComment.getComment())%></p>
        </td>
		<td width="100" background="img/minit_02.jpg" valign="top" style="padding:10">
            <p><%=XwinUtil.getBoardItemDate(boardComment.getDate()) %></p>
        </td>
		<td width="15" align="center" background="img/minit_02.jpg" valign="top" style="padding:10">
            <p><%if (boardComment.getUserId().equals(member.getUserId())) {%>
					<img onclick="deleteComment(<%=boardComment.getId()%>)" src="img/x.gif"></td>
					<%}else { %>
					&nbsp;					
					<%} %></p>
        </td>
    </tr>
<%
	}
}
%>
</table>
<br><br>
<form name="comment_frm" method="post">
<input type="hidden" name="mode" value="writeBoardComment">
<input type="hidden" name="boardId" value="<%=boardItem.getId()%>">
<input type="hidden" name="boardName" value="<%=boardName%>">
<input type="hidden" name="name" value="<%=member.getNickName()%>">
	  <table align="center" cellpadding="0" cellspacing="0" width="771" height="20">
   
    <tr>
        <td width="771" height="37" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="20" background="img/minit_02.jpg" valign="top" style="padding:1">
           	<table border=0 width=100% align=center>

	 <td align=left height="20"><textarea name="comment" cols=45 rows=5 class=textarea style=width:655></textarea></td>
         <td height="20"><input type="button" class="submit" value=" OK " style=width:100 onclick="comment_add()"></td>
	</tr>
	</table>
        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
</form>
<script>
function comment_add(){
	if (havingSqlKeyword(comment_frm.name.value)) { alert("이름에 사용할수 없는 문자열이 있습니다"); comment_frm.name.focus(); return false; }
	if (havingSqlKeyword(comment_frm.comment.value)) { alert("댓글에 사용할수 없는 문자열이 있습니다"); comment_frm.comment.focus(); return false; }
	
    if(comment_frm.name.value    ==""){ alert("이름을 입력하세요.");      comment_frm.name.focus(); return false; }
    if(comment_frm.comment.value ==""){ alert("댓글 내용을 입력하세요."); comment_frm.comment.focus(); return false; }
    comment_frm.action = "board.aspx";
    comment_frm.method = "post";
    comment_frm.submit();

}

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
			location.href = "board.aspx?mode=viewBoard&boardName=<%=boardItem.getBoardName()%>&grade=<%=boardItem.getGrade()%>";
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
</script>
<%@include file="../footer.jsp"%>


</body>
</html>