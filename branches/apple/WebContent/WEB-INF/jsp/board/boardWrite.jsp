<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%
	String boardName = request.getParameter("boardName");
%>

<%@include file="../header.jsp"%>

<div class='sub_ti1'>
			<img src='img/sub_board_ti.gif' alt='게시판' class='ml10 mr10 fl'> 
			<div class='sub_ti_desc'>게시물을 작성하고, 중요 내용을 확인 할 수 있습니다. </div>
			<div class='state_bar'>
				<div class='state_bar_txt'>
				<span class='name'><%=member.getNickName()%></span> 님
				<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
				<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
				<!-- span class='link'><a href='myBet.aspx?mode=viewMyBettingList'>배팅내역보기</a></span -->
				</div>
			</div>
			<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='board'>
				<div class='write_box'>
					<form name="frm" action="board.aspx" method="post">
					<input type="hidden" name="mode" value="writeBoardItem">
					<input type="hidden" name="boardName" value="<%=boardName%>">
					<table>
						<tr>
							<th>작성자</th>
							<td><%=member.getNickName()%></td>
						</tr>
						<tr>
							<th>제 목</th>
							<td><input type='text' class='w1' name='title'></td>
						</tr>
						<tr>
							<th>내 용</th>
							<td><textarea type='text' class='w2' name='context'></textarea></td>
						</tr>
					</table>
					</form>
				</div>
				<!-- end view_box -->
				<div class='write_bt'>
					<img src='img/board_writeok_bt.gif' alt='작성완료' class='img_bt' onclick='write_board()' style='cursor:hand'>
					<img src='img/board_list_bt.gif' alt='글목록' class='img_bt' onclick='history.back()' style='cursor:hand'>

				</div>				
				<!-- end write_bt -->
	
			</div>
			<!-- end board -->
		</div>
		<!-- sub_content1 -->

<script>
function write_board()
{
	var frm = document.frm;
	if(frm.title.value   ==""){ alert("제목을 입력하세요!");   frm.title.focus();    return false; }
    //if(frm.name.value    ==""){ alert("작성자를 입력하세요!"); frm.name.focus();     return false; }
    if(frm.context.value==""){ alert("내용을 입력하세요!");   frm.context.focus(); return false; }
    
	if (havingSqlKeyword(frm.title.value)) { alert("제목에 사용할수 없는 문자열이 있습니다"); frm.title.focus(); return false; }
	//if (havingSqlKeyword(frm.name.value)) { alert("작성자에 사용할수 없는 문자열이 있습니다"); frm.name.focus(); return false; }
	if (havingSqlKeyword(frm.context.value)) { alert("내용에 사용할수 없는 문자열이 있습니다"); frm.context.focus(); return false; }

    frm.submit();
}
</script>
<%@include file="../footer.jsp"%>


</body>
</html>