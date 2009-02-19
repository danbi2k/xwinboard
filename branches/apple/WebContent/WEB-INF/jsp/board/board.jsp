<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.web.controller.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%
	String boardName = request.getParameter("boardName");
%>

<%@include file="../header.jsp"%>

<%
	Integer ROWSIZE = BoardController.ROWSIZE;
	final Integer SHOWPAGE = 10;
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	List<BoardItem> boardItemList = (List<BoardItem>) request.getAttribute("boardItemList");
	Integer totalCount = (Integer) request.getAttribute("boardItemCount");
	
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	else 
		pageIndex = "0";
	
	int itemIdx = totalCount - (pIdx * ROWSIZE);
%>

<div class='sub_ti1'>
		<img src='img/sub_board_ti.gif' alt='게시판' class='ml10 mr10 fl'> 
		<div class='sub_ti_desc'>게시물을 작성하고, 중요 내용을 확인 할 수 있습니다. </div>
<!-- 		<div class='state_bar'>
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


				

				<div class='list_box'>
					<table>
			<tr><th class='t1'>번호</th><th class='t2'>제목</th><th class='t3'>작성자</th><th class='t4'>작성일</th><th class='t5'>조회수</th></tr>
<%
	if (boardItemList != null) {
		for (BoardItem boardItem : boardItemList) {
			String classHead = boardItem.getType().equals(Code.BOARDITEM_TYPE_NOTICE)?"notice":"";
			String classSubject = boardItem.getType().equals(Code.BOARDITEM_TYPE_NOTICE)?"notice subject":"subject";
			String head = boardItem.getType().equals(Code.BOARDITEM_TYPE_NOTICE)?"공지":""+itemIdx--;
%>
			<tr>
				<td class='<%=classHead%>'><%=head%></td>
				<td class='<%=classSubject%>'>
					<a href="board.aspx?mode=viewBoardDetail&boardName=<%=boardName%>&id=<%=boardItem.getId()%>&pageIndex=<%=pageIndex%>">
					<%=boardItem.getTitle()%><b>&nbsp;&nbsp;[<%=boardItem.getCommentCount()%>]
					</b>
				</td>
				<td class='<%=classHead%>'><%=boardItem.getNickName()%></td>
				<td class='<%=classHead%>'><%=XwinUtil.getBoardItemDate(boardItem.getDate())%></td>
				<td class='<%=classHead%>'><%=boardItem.getReadCount()%></td>
			</tr>
<%
		}
	}
%>
					</table>

				</div>
					<div class='write_bt'>
					<a href='board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>'>
					<img src='img/board_write_bt.gif' alt='글쓰기' class='img_bt'>
					</a>				
					</div>				

				<!-- end list_box -->

<!-----[ 페이징 ]--------------------------------------------/-->
				<div class='paginate'>    
<%
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<span class='pre'><a href='javascript:goPage(<%=startPage - 1%>)'><img src='img/list_prev_bt.gif' alt='이전'></a></span>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<span class='txt'><strong><%=i+1%></strong></span>
<%
		} else {
%>		
			<span class='txt'><a href='javascript:goPage(<%=i%>)'><%=i+1%></a></span>
<%			
		}
	}
	if (i < pageNum) {
%>		
		<span class='next'><a href='javascript:goPage(<%=i%>)''><img src='img/list_next_bt.gif' alt='다음' class='next'></a></span>
<%
	}
%>
				</div>			
			</div>
		</div>
		<!-- sub_content1 -->

<script>
function goPage(pageIndex)
{
	location.href="board.aspx?mode=viewBoard&boardName=<%=boardName%>&pageIndex=" + pageIndex;
}
</script>
<%@include file="../footer.jsp"%>