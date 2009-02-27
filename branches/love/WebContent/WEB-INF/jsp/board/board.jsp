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

			<tr><td><img src="img/menu04.jpg" border="0"></td></tr>
		    <tr><td><img src="img/bbs01.jpg" border="0"></td></tr>
            </table>
     
     <table align="center" cellpadding="0" cellspacing="0" width="887" height="40" background="img/bar.jpg">
    <tr>
        <td width="90" height="40" align="center" valign="middle" class="menubar">
            <p>번호</p>
        </td>
        <td width="527" height="40" align="center" valign="middle" class="menubar">
            <p>제목</p>
        </td>
        <td width="110" height="40" align="center" valign="middle" class="menubar">
            <p>작성자</p>
       </td>
        <td width="110" height="40" align="center" valign="middle" class="menubar">
            <p>작성일</p>
        </td>
        <td width="50" height="40" align="center" valign="middle" class="menubar">
            <p>조회수</p>
        </td>
        
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="887" height="35">
<%
	if (boardItemList != null) {
		for (BoardItem boardItem : boardItemList) {
			boolean isNotice = boardItem.getType().equals(Code.BOARDITEM_TYPE_NOTICE);
			String classHead = isNotice?"notice":"";
			String classSubject = isNotice?"notice subject":"subject";
			String head = isNotice?"<img src='img/notice.jpg' border='0'>":""+itemIdx--;
			String readCount = isNotice?"":""+boardItem.getReadCount();
%>
			<tr>
				 <td width="90" height="35" align="center" valign="middle">
            		<p><%=head%></p>
        		</td>
				 <td width="527" height="35" align="left" valign="middle">
					<p><a href="board.aspx?mode=viewBoardDetail&boardName=<%=boardName%>&id=<%=boardItem.getId()%>&pageIndex=<%=pageIndex%>">
					<%=boardItem.getTitle()%><b>&nbsp;&nbsp;[<%=boardItem.getCommentCount()%>]
					</b>
					</a>
				</td>
				<td width="110" height="35" align="center" valign="middle">
		            <p><%=boardItem.getNickName()%></p>
		        </td>
				 <td width="110" height="35" align="center" valign="middle">
		            <p><%=XwinUtil.getBoardItemDate(boardItem.getDate())%></p>
		        </td>
		        <td width="50" height="35" align="center" valign="middle">
		            <p><%=readCount%></p>
		        </td>
			</tr>
			<tr>
			   <td class="bbsline" colspan="5">
			   </td>
			</tr>
<%
		}
	}
%>  
     </table>
          <table align="center" cellpadding="0" cellspacing="0" width="887" height="40">
	        <tr>
			    <td width="787" height="40" align="center">
<%
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'><img src="img/prev.jpg" border="0" align="absmiddle"></a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'><img src="img/next.jpg" border="0" align="absmiddle"></a>
<%
	}
%>
			    </td>
			    <td width="100" height="40" align="right">
				<a href='board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>'><img src="img/write.jpg" border="0"></a>
				</td>
			</tr>
		    
     </table>

<script>
function goPage(pageIndex)
{
	location.href="board.aspx?mode=viewBoard&boardName=<%=boardName%>&pageIndex=" + pageIndex;
}
</script>
<%@include file="../footer.jsp"%>