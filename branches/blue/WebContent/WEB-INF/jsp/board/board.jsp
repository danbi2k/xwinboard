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

			<tr><td><img src="images/<%=boardName.equals("user")?"menu04":"menu05"%>1.jpg" border="0"></td></tr>
		    <tr><td>&nbsp;</td>
		    </tr>
</table>
     
     <table align="center" cellpadding="0" cellspacing="0" width="887" height="40" background="images/bar1.gif">
    <tr>
        <td width="90" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">번호</p>      </td>
        <td width="500" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">제목</p>      </td>
        <td width="27" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold"></p>      </td>    
        <td width="110" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">작성자</p>      </td>
        <td width="110" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">작성일</p>      </td>
        <td width="50" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">조회수</p>      </td>
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="887" height="35">
<%
	if (boardItemList != null) {
		for (BoardItem boardItem : boardItemList) {
			boolean isNotice = boardItem.getType().equals(Code.BOARDITEM_TYPE_NOTICE);
			String classHead = isNotice?"notice":"";
			String classSubject = isNotice?"notice subject":"subject";
			String head = isNotice?"<img src='images/notice.jpg' border='0'>":""+itemIdx--;
			String readCount = isNotice?"":""+boardItem.getReadCount();
%>
			<tr>
				 <td width="90" height="35" align="center" valign="middle">
            		<p><%=head%></p>
        		</td>
				 <td width="500" height="35" align="left" valign="middle">
					<p><a <%=isNotice?"style=color:#d74545;'":""%> href="bbs.php?mode=viewBoardDetail&boardName=<%=boardName%>&id=<%=boardItem.getId()%>&pageIndex=<%=pageIndex%>">
					<%=boardItem.getTitle()%><b>
					</b>
					</a>
				</td>
				<td width="27" height="35" align="center" valign="middle">
					<p>[<%=boardItem.getCommentCount()%>]</p>
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
			   <td class="bbsline" colspan="6">
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
		<a href='javascript:goPage(<%=startPage - 1%>)'><img src="images/prev.jpg" border="0" align="absmiddle"></a>
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
		<a href='javascript:goPage(<%=i%>)'><img src="images/next.jpg" border="0" align="absmiddle"></a>
<%
	}
%>
			    </td>
			    <td width="100" height="40" align="right">
				<a href='bbs.php?mode=viewBoardWriteForm&boardName=<%=boardName%>'><img src="images/write.jpg" border="0"></a>
				</td>
			</tr>
		    
     </table>

<script>
function goPage(pageIndex)
{
	location.href="bbs.php?mode=viewBoard&boardName=<%=boardName%>&pageIndex=" + pageIndex;
}
</script>
<%@include file="../footer.jsp"%>