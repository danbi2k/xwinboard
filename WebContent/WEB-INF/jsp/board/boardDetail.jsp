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
<div class='sub_ti1'>
			<img src='img/sub_board_ti.gif' alt='게시판' class='ml10 mr10 fl'> 
			<div class='sub_ti_desc'>게시물을 작성하고, 중요 내용을 확인 할 수 있습니다. </div>
			<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='board'>
				<div class='view_box'>
					<table>
						<tr>
							<th><%=boardItem.getTitle()%></th>
						</tr>
						<tr>
							<td class='v1'>
							<span>작성자 : <%=boardItem.getNickName()%></span><span>조회수 : <%=boardItem.getReadCount() %></span><span>등록일 : <%=XwinUtil.getBoardItemDate(boardItem.getDate()) %></span>
							</td>
						</tr>
						<tr>
							<td class='v2'>
							<%
						    String context = boardItem.getContext();
						    context = StringEscapeUtils.escapeHtml(context);
						    context = context.replaceAll("\n", "<br>");
						    out.print(context);
						    %>
							</td>
						</tr>
					</table>
				</div>
				<!-- end view_box -->
				<div class='write_bt'>
					<a href='board.aspx?mode=viewBoard&boardName=<%=boardName%>&pageIndex=<%=pageIndex%>'><img src='img/board_list_bt.gif' alt='글목록' class='img_bt'></a>
					<%if (boardItem.getUserId().equals(member.getUserId())) {%>
					<a href=''><img src='img/board_del_bt.gif' alt='글삭제' class='img_bt' onclick="deleteItem()"></a>
					<%} %>
					<a href='board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>'><img src='img/board_write_bt.gif' alt='글쓰기' class='img_bt'></a>
				</div>				
				<!-- end write_bt -->
				<div class='comment_write'>
					<form name="comment_frm" method="post">
					<input type="hidden" name="mode" value="writeBoardComment">
					<input type="hidden" name="boardId" value="<%=boardItem.getId()%>">
					<input type="hidden" name="boardName" value="<%=boardName%>">
					<table>
						<tr>
						<td class='title'>COMMENT</td>
						<td>작성자 <input type='text' class='input_text w80' name='name' value='<%=member.getNickName()%>' readonly></td>
						<td>내용 <input type='text' class='input_text w380' name='comment'></td>
						<td><img src='img/board_comment_bt.gif' alt='코멘트입력' style="cursor:hand" onclick="comment_add()"></td>
						</tr>
					</table>
					</form>
				</div>			
				<!-- end comment_write -->
				<div class='comment_list'>
					<table>
					 <%
			        if (boardCommentList != null) {
			        	for (BoardComment boardComment : boardCommentList) {
			        %>
						<tr>
							<td class='c1'><%=boardComment.getNickName()%></td>
							<td class='c2'><%=StringEscapeUtils.escapeHtml(boardComment.getComment())%></td>
							<td class='c3'><%=XwinUtil.getBoardItemDate(boardComment.getDate()) %></td>
							<td class='c4'><img src='img/sub_incashlist_del_bt.gif'></td>
						</tr>
					<%
			        	}
			        }
			        %>
					</table>		
				</div>			
				<!-- end comment_list -->
	
			</div>
			<!-- end board -->
		</div>
		<!-- sub_content1 -->

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

function comment_add(){
	if (havingSqlKeyword(comment_frm.name.value)) { alert("이름에 사용할수 없는 문자열이 있습니다"); comment_frm.name.focus(); return false; }
	if (havingSqlKeyword(comment_frm.comment.value)) { alert("댓글에 사용할수 없는 문자열이 있습니다"); comment_frm.comment.focus(); return false; }
	
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

<%@include file="../footer.jsp"%>


</body>
</html>