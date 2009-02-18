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
			<img src='./img/sub_board_ti.gif' alt='게시판' class='ml10 mr10 fl'> 
			<div class='sub_ti_desc'>게시물을 작성하고, 중요 내용을 확인 할 수 있습니다. </div>
	<!-- 	<div class='state_bar'>
				<div class='state_bar_txt'>
				<span class='name'>홍길동</span> 님
				<span class='cash'>· Cash:<span class='val'>0</span></span> 
				<span class='apple'>· Apple:<span class='val'>100,000</span></span> 
				<span class='link'><a href=''>배팅내역보기</a></span>
				</div>
			</div> -->
			<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='board'>
				<div class='view_box'>
					<table>
						<tr>
							<th>안녕하세요 반갑습니다.</th>
						</tr>
						<tr>
							<td class='v1'>
							<span>작성자 : 홍길동</span><span>조회수 : 24</span><span>등록일 : 01/06 23:08</span>
							</td>
						</tr>
						<tr>
							<td class='v2'>
							안녕하세요 반갑습니다.<br>
							안녕하세요 반갑습니다.<br>
							안녕하세요 반갑습니다.<br>
							안녕하세요 반갑습니다.<br>
							안녕하세요 반갑습니다.<br>
							안녕하세요 반갑습니다.<br>
							</td>
						</tr>
					</table>
				</div>
				<!-- end view_box -->
				<div class='write_bt'>
					<a href=''><img src='./img/board_list_bt.gif' alt='글목록' class='img_bt'></a>
					<a href=''><img src='./img/board_del_bt.gif' alt='글삭제' class='img_bt'></a>
					<a href=''><img src='./img/board_write_bt.gif' alt='글쓰기' class='img_bt'></a>
				</div>				
				<!-- end write_bt -->
				<div class='comment_write'>
					<table>
						<tr>
						<td class='title'>COMMENT</td>
						<td>작성자 <input type='text' class='input_text w80'></td>
						<td>내용 <input type='text' class='input_text w380'></td>
						<td><img src='./img/board_comment_bt.gif' alt='코멘트입력'></td>
						</tr>
					</table>

				</div>			
				<!-- end comment_write -->
				<div class='comment_list'>
					<table>
						<tr><td class='c1'>홍기동</td><td class='c2'>안녕하세요 반갑습니다.[2]</td><td class='c3'>01/06 23:08</td></tr>
						<tr><td class='c1'>홍기동</td><td class='c2'>안녕하세요 반갑습니다.[2]</td><td class='c3'>01/06 23:08</td></tr>
						<tr><td class='c1'>홍기동</td><td class='c2'>안녕하세요 반갑습니다.[2]</td><td class='c3'>01/06 23:08</td></tr>
						<tr><td class='c1'>홍기동</td><td class='c2'>안녕하세요 반갑습니다.[2]</td><td class='c3'>01/06 23:08</td></tr>
						<tr><td class='c1'>홍기동</td><td class='c2'>안녕하세요 반갑습니다.[2]</td><td class='c3'>01/06 23:08</td></tr>
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